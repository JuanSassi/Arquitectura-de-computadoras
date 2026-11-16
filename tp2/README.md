# TP2 – UART + ALU (Basys3)

Implementación por módulos del TP2 de Arquitectura de Computadoras, según la clase
*"5 – Máquinas de Estado Finitas"* (sección **TP: UART**): una UART (baud rate generator,
receptor, transmisor) conectada por un *interface circuit* a la ALU del TP1.

```
                         ┌─────────────────────────── uart_alu_top ───────────────────────────┐
                         │                                                                     │
 RX ──(pin B18)──► rx ───┼─► ┌────────┐ rx_done_tick,dout ┌───────────────┐ r_data,rx_empty ┌──────────────┐
                         │   │uart_rx │ ────────────────► │               │ ──────────────► │              │
                         │   └───▲────┘                   │ uart_interface│ ◄────────────── │ alu_uart_ctrl│
                         │       │ s_tick                 │ (2 × FIFO)    │      rd         │  (FSM + ALU) │
                         │ ┌─────┴──────┐                 │               │                 │              │
 clk ─(pin W5)───────────┼►│baud_rate_  │                 │               │ w_data,wr       │              │
                         │ │gen         │                 │               │ ◄────────────── │              │
                         │ └─────┬──────┘                 │               │ ──────────────► │              │
                         │       │ s_tick                 │               │    tx_full      └──────────────┘
 TX ◄─(pin A18)── tx ◄───┼─ ┌────▼───┐ tx_start,tx_din    │               │
                         │  │uart_tx │ ◄───────────────── │               │
                         │  └────────┘ ─ tx_done_tick ──► └───────────────┘
                         └─────────────────────────────────────────────────────────────────────┘
```

* Placa: **Basys3** (xc7a35tcpg236-1), reloj de **100 MHz**, `btnC` = reset.
* UART: **19200 baudios, 8 bits de datos, sin paridad, 1 bit de stop (8N1)**, muestreo ×16.
* Todo es parametrizable (`CLK_FREQ`, `BAUD_RATE`, `DBIT`, `SB_TICK`, profundidad de FIFO).

## Protocolo PC ↔ FPGA

La filmina define los bloques pero no el contenido de la comunicación, así que se eligió el
protocolo mínimo que usa los tres datos que necesita la ALU del TP1 (A, B, Op), **en el mismo orden en que se
cargaban los registros en el TP1** (Reg A, Reg B, Reg Op) y en que lo hace la UART de `project_2`:

| Sentido | Bytes | Significado |
|---|---|---|
| PC → FPGA | `[A] [B] [OP]` | `A` y `B` = operandos de 8 bits, `OP[5:0]` = código de operación del TP1 (los 2 bits altos se ignoran). El operador llega último y dispara el cálculo |
| FPGA → PC | `[RES]` | `RES = A (op) B`, 8 bits |

Operaciones (las del TP1): `ADD 0x20`, `SUB 0x22`, `AND 0x24`, `OR 0x25`, `XOR 0x26`, `NOR 0x27`,
`SRL 0x02`, `SRA 0x03` (los desplazamientos desplazan **B** una cantidad igual a los 3 bits bajos de **A**).
Un código inválido devuelve `0x00`.

> Si en el enunciado de la cátedra el protocolo es otro (por ejemplo, un byte por comando y registros
> internos), **solo cambia `alu_uart_ctrl.v`**; la UART y el interface no se tocan.

## Orden de implementación (paso a paso)

Cada paso tiene su testbench autochequeable en `sim/`; no se pasa al siguiente hasta que el anterior da `PASO`.

| Paso | Módulo | Testbench | Qué se demuestra |
|---|---|---|---|
| 1 | `baud_rate_gen` | `tb_baud_rate_gen` | El tick sale cada `DVSR` ciclos exactos y dura 1 ciclo |
| 2 | `uart_rx` | `tb_uart_rx` | Decodifica bytes desde la línea serie (+ glitch, stop inválido, ±3 % de baud) |
| 3 | `uart_tx` | `tb_uart_tx` | Genera tramas correctas con bits de ancho exacto |
| 3b | `uart_tx → uart_rx` | `tb_uart_loopback` | Tx y Rx se entienden entre sí |
| 4 | `sync_fifo` | `tb_sync_fifo` | Orden, lleno/vacío, protecciones (vs. modelo de referencia) |
| 5 | `uart_interface` | `tb_uart_interface` | Pasaje de señales Rx→FIFO→ALU y ALU→FIFO→Tx |
| 6 | `alu_uart_ctrl` (+ `alu`) | `tb_alu_uart_ctrl` | Protocolo `[A][B][OP]→[RES]`, control de flujo, 311 comandos vs. modelo |
| 7 | `uart_alu_top` | `tb_uart_alu_top` | Todo junto por el cable serie |

---

## Módulo 1 – `baud_rate_gen`  ([src/baud_rate_gen.v](src/baud_rate_gen.v))

**Para qué sirve.** Genera la base de tiempo de la UART. El Rx y el Tx miden un bit contando
**16 ticks**; así no hace falta un reloj por cada baud rate y el Rx puede muestrear en el
centro del bit (tick 8).

**Cuenta.** `DVSR = CLK_FREQ / (BAUD_RATE · 16)`. Con 100 MHz y 19200 baudios: 100 000 000 / 307 200 = 325,5 → **326**
(error de baud ≈ 0,15 %). Es un contador módulo `DVSR` con la salida registrada.

| Señal | Dir. | Ancho | Descripción |
|---|---|---|---|
| `clk` | in | 1 | Reloj del sistema (100 MHz) |
| `reset` | in | 1 | Sincrónico, activo en alto |
| `tick` | out | 1 | Pulso de 1 ciclo cada `DVSR` ciclos. Va a `s_tick` de Rx y Tx |

Parámetros: `CLK_FREQ`, `BAUD_RATE`, `OVERSAMPLE` (16).

**Prueba:** período entre ticks = `DVSR` exacto (en 1,2288 MHz → 4; en 100 MHz → 326), ancho 1 ciclo,
sin ticks con reset activo.

## Módulo 2 – `uart_rx`  ([src/uart_rx.v](src/uart_rx.v))

**Para qué sirve.** Convierte la línea serie `rx` en bytes. Implementa el diagrama de estados de la clase.

| Señal | Dir. | Ancho | Descripción |
|---|---|---|---|
| `clk`, `reset` | in | 1 | Reloj y reset sincrónico |
| `rx` | in | 1 | Línea serie (asincrónica, reposo en 1) |
| `s_tick` | in | 1 | Tick ×16 del `baud_rate_gen` |
| `rx_done_tick` | out | 1 | **1 ciclo** cuando `dout` tiene un byte válido |
| `frame_err` | out | 1 | **1 ciclo** si el stop bit no era 1 (el byte se descarta) |
| `dout` | out | `DBIT` | Último byte recibido (estable hasta el próximo) |

**FSM (4 estados, `s` = contador de ticks, `n` = contador de bits):**

| Estado | Qué hace | Sale cuando |
|---|---|---|
| `idle` | Espera un **flanco de bajada** de `rx` | flanco → `start`, `s←0` |
| `start` | Cuenta ticks | `s_tick` y `s==7` (mitad del start): si `rx` ya es 1 fue ruido → `idle`; si no → `data`, `s←0`, `n←0` |
| `data` | Cada 16 ticks (mitad de cada bit) hace `b ← {rx, b[7:1]}` | `s==15` y `n==DBIT-1` → `stop` |
| `stop` | Cuenta `SB_TICK` ticks (mitad del stop) | `rx==1` → `rx_done_tick`; `rx==0` → `frame_err`; en ambos casos → `idle` |

Entrar a `data` en la mitad del start y luego esperar 16 ticks deja el muestreo siempre en el **centro** de cada bit.
Como cada dato entra por la izquierda y se corre a la derecha, el primer bit (LSB) termina en `b[0]`.

Mejoras respecto a la filmina: sincronizador de 2 FF en `rx`, `idle` exige *flanco* (evita arrancar un frame
falso tras un stop inválido), validación del stop bit, y salidas registradas (sin glitches).

**Prueba:** bytes dirigidos (`00 FF A5 5A 01 80`), ráfaga de 20 bytes sin pausas, aleatorios, glitch de ¼ de bit
(no debe recibir nada), stop = 0 (`frame_err` y recupera), emisor ±3 % de error de baud.

## Módulo 3 – `uart_tx`  ([src/uart_tx.v](src/uart_tx.v))

**Para qué sirve.** Serializa un byte: start (0) + `DBIT` datos (LSB primero) + stop (1).

| Señal | Dir. | Ancho | Descripción |
|---|---|---|---|
| `clk`, `reset` | in | 1 | Reloj y reset sincrónico |
| `tx_start` | in | 1 | **Nivel**: hay un dato válido en `din` para enviar |
| `s_tick` | in | 1 | Tick ×16 |
| `din` | in | `DBIT` | Byte a enviar (se captura al arrancar) |
| `tx_done_tick` | out | 1 | **1 ciclo** al terminar el stop bit: "ya podés pasar al siguiente" |
| `tx` | out | 1 | Línea serie (salida de un registro, reposo en 1) |

**FSM:** `idle` (tx=1) → `start` (16 ticks en 0) → `data` (16 ticks por bit, desplaza `b >> 1`) → `stop`
(`SB_TICK` ticks en 1, emite `tx_done_tick`) → `idle`.

Decisiones de diseño:
* La trama arranca solo en un `s_tick`, así que **todos los bits miden exactamente 16 ticks** (verificado en el tb con 0x55, que alterna en cada bit).
* `tx_done_tick` es combinacional y cae en el mismo ciclo en que la FSM vuelve a `idle`. La FIFO del interface descarta el byte en ese flanco, de modo que en `idle` `tx_start` ya refleja la FIFO actualizada. Si el pulso estuviese registrado, el Tx re-enviaría el mismo byte.

**Prueba:** un monitor independiente decodifica la línea midiendo en el centro de cada bit; se envían
`55`, ráfaga (`tx_start` queda en 1 entre tramas), bytes con la UART en reposo y 10 aleatorios.

**Paso 3b – loopback** (`tb_uart_loopback`): `tx` se conecta a `rx` con un único `baud_rate_gen`; 60 bytes
(todos los patrones de un bit, `00`, `FF`, aleatorios) salen idénticos, sin `frame_err`.

## Módulo 4 – `sync_fifo`  ([src/sync_fifo.v](src/sync_fifo.v))

**Para qué sirve.** Desacopla velocidades: el Rx entrega un byte cada ~520 µs, la ALU consume en nanosegundos.

| Señal | Dir. | Ancho | Descripción |
|---|---|---|---|
| `clk`, `reset` | in | 1 | Reloj y reset sincrónico |
| `wr` / `w_data` | in | 1 / `DATA_W` | Escribe `w_data` en el flanco (se ignora si `full`) |
| `rd` | in | 1 | Descarta el dato más viejo en el flanco (se ignora si `empty`) |
| `r_data` | out | `DATA_W` | Dato más viejo (*first-word fall-through*: válido siempre que `empty==0`) |
| `empty`, `full` | out | 1 | Estado (a partir de un contador de ocupación) |

Profundidad `2**ADDR_W` (16 por defecto). Con `wr`+`rd` simultáneos hace ambos si es posible.

**Prueba:** lleno/vacío dirigido y 3000 ciclos aleatorios comparados ciclo a ciclo contra un modelo.

## Módulo 5 – `uart_interface`  ([src/uart_interface.v](src/uart_interface.v))

**Para qué sirve.** Es el "Interface Circuit" de la filmina: une la UART con la ALU mediante dos FIFO.

| Señal | Dir. | Ancho | Lado | Descripción |
|---|---|---|---|---|
| `rx_done_tick` | in | 1 | Rx | Escribe `rx_dout` en la FIFO rx |
| `rx_dout` | in | `DBIT` | Rx | Byte recibido |
| `tx_done_tick` | in | 1 | Tx | Descarta de la FIFO tx el byte ya enviado |
| `tx_start` | out | 1 | Tx | `= ~FIFO_tx.empty` |
| `tx_din` | out | `DBIT` | Tx | Cabeza de la FIFO tx |
| `rd` | in | 1 | ALU | La ALU consumió `r_data` |
| `r_data` | out | `DBIT` | ALU | Byte más viejo recibido |
| `rx_empty` | out | 1 | ALU | 1 = no hay bytes para leer |
| `rx_full` | out | 1 | ALU | Extra: FIFO rx llena (se perderían bytes) |
| `wr`, `w_data` | in | 1, `DBIT` | ALU | La ALU encola un byte para transmitir |
| `tx_full` | out | 1 | ALU | 1 = la ALU debe esperar para escribir |

**Prueba (a nivel de señales, sin serie):** el tb hace de Rx/Tx/ALU y verifica `rx_empty`, orden de `r_data`,
que `r_data` no cambia hasta `rd`, `rx_full` y que un byte extra se descarta sin romper el orden, `tx_start`/`tx_din`
con 2 bytes encolados, `tx_full` y que las dos FIFO son independientes.

## Módulo 6 – `alu_uart_ctrl` + `alu`  ([src/alu_uart_ctrl.v](src/alu_uart_ctrl.v), [src/alu.v](src/alu.v))

**Para qué sirve.** Es el bloque "ALU" de la filmina: una FSM que arma el comando leyendo bytes del interface,
usa la **ALU del TP1** (`alu.v`, copiada sin cambios, `N=8`) y devuelve el resultado.

| Señal | Dir. | Ancho | Descripción |
|---|---|---|---|
| `rx_empty` / `r_data` / `rd` | in / in / out | 1 / `N` / 1 | Lectura del interface (cuando `rx_empty==0`, `r_data` es válido y `rd` lo consume) |
| `tx_full` / `w_data` / `wr` | in / out / out | 1 / `N` / 1 | Escritura del resultado (cuando `tx_full==0`, `wr` lo encola) |
| `result` | out | `N` | Último resultado (a los LEDs) |
| `state_dbg` | out | 3 | Estado de la FSM (debug) |

**FSM:** `A → B → OP → CALC → SEND → A …`

| Estado | Acción |
|---|---|
| `A`, `B`, `OP` | Si `!rx_empty`: `rd=1`, captura `r_data` en `a_reg` / `b_reg` / `op_reg[5:0]`, avanza |
| `CALC` | La ALU combinacional tiene sus 3 entradas estables; se registra su resultado |
| `SEND` | Si `!tx_full`: `wr=1` con `w_data=res_reg`, vuelve a `A` |

**Prueba:** un modelo independiente de la ALU en el tb; 11 comandos dirigidos (uno por operación, desborde de ADD,
SUB negativo, SRA con signo, op inválida, bits altos de OP ignorados) + 300 aleatorios inyectados sin esperar la
respuesta, de modo que se ejercitan `rx_full` y `tx_full` (control de flujo).

## Módulo 7 – `uart_alu_top`  ([src/uart_alu_top.v](src/uart_alu_top.v))

Conecta todo y agrega: reset sincronizado desde `btnC`, y LEDs: `led[7:0]` último resultado,
`led[13]` hay bytes pendientes, `led[14]` FIFO tx llena, `led[15]` error de frame (pegajoso). Pines en
[constraints/basys3.xdc](constraints/basys3.xdc) (`RsRx = B18`, `RsTx = A18`).

**Prueba (`tb_uart_alu_top`):** el tb hace de PC por el cable serie: 9 operaciones, 40 aleatorias de a una, y una
ráfaga de 4 comandos (12 bytes seguidos) cuyas 4 respuestas salen en orden.

---

## Cómo simular

Desde esta carpeta (usa el `xsim` de Vivado 2025.2 instalado en `D:\Facultad\Arquitectura\Vivado`):

```powershell
.\run_sim.ps1                       # los 8 testbenches en orden
.\run_sim.ps1 -Tb tb_uart_rx        # uno solo
.\run_sim.ps1 -Tb tb_uart_rx -Wave  # deja build\tb_uart_rx.wdb para ver formas de onda en Vivado
.\run_sim.ps1 -Real                 # además baud/rx/tx/top con el reloj real de 100 MHz (más lento)
```

Los testbenches usan por defecto `CLK_FREQ = 1,2288 MHz` (= 16·19200·4, o sea `DVSR = 4`) para simular rápido;
con `-Real` se repiten con 100 MHz (`DVSR = 326`). También se puede abrir en Vivado con
`vivado -mode batch -source create_project.tcl` y elegir el testbench en *Simulation Settings*.

## Resultados obtenidos

Simulación (xsim 2025.2), todos `PASO`:

| Testbench | Chequeos | Notas |
|---|---|---|
| `tb_baud_rate_gen` | 53 | también con 100 MHz (DVSR = 326) |
| `tb_uart_rx` | 42 | 40 bytes, 1 `frame_err` esperado; también a 100 MHz |
| `tb_uart_tx` | 70 | 19 bytes, ancho de bit exacto; también a 100 MHz |
| `tb_uart_loopback` | 61 | 60 bytes Tx→Rx |
| `tb_sync_fifo` | 3022 | contra modelo de referencia |
| `tb_uart_interface` | 27 | |
| `tb_alu_uart_ctrl` | 313 | 311 comandos, `tx_full` y `rx_full` ejercitados |
| `tb_uart_alu_top` | 56 | 53 comandos (a 100 MHz reales: 16 comandos) |

Además se verificó que los tests **detectan fallas** introduciendo cinco errores a propósito (muestreo del bit
fuera del centro, no validar el stop, orden de bits invertido, FIFO que pisa datos con `full`, `idle` sin flanco): los cinco hicieron fallar el testbench correspondiente.

Síntesis + implementación (Vivado, xc7a35t): **143 LUT (0,69 %), 124 FF (0,30 %), 0 BRAM**, 0 errores / 0 critical warnings,
timing a 100 MHz cumplido con **WNS = +5,338 ns** (reportes en `build/utilization.rpt` y `build/timing.rpt`).

## Probar en la placa

```powershell
vivado -mode batch -source run_bitstream.tcl     # genera build\uart_alu_top.bit
vivado -mode batch -source program_board.tcl     # programa la Basys3 conectada por USB
python pc\hw_test.py COM3                        # bateria completa (cambiar COM3 por el puerto de la placa)
python pc\alu_uart_client.py COM3 --op ADD --a 100 --b 27   # una operacion suelta
```

El puerto COM se ve en el Administrador de dispositivos (chip FTDI, `USB Serial Port`).
El LED `led[7:0]` muestra el último resultado (127 = `0111 1111`).

**Resultado en hardware (Basys3, 19200 8N1):** `hw_test.py` dio **PASO, 1050 chequeos, 0 errores**: operaciones
dirigidas y con valores extremos, código inválido (devuelve 0), bits altos de OP ignorados, comando enviado en
pausas, 100 aleatorias por operación, 20 ráfagas de 8 comandos y 2004 comandos de estrés en tandas de 12.
`alu_uart_client.py --selftest` también dio OK. Timing del bitstream: WNS = +4,9 ns.

## Qué se reutilizó

* **Tp1:** `alu.v` (sin cambios), estilo de testbench autochequeable, scripts Tcl y constraints de la Basys3.
* **Clase de FSM (PDF del Tp2):** diagrama de estados del Rx, relación `DVSR`, esquema de bloques, estilo de FSM
  en tres bloques (registro de estado / próximo estado / salidas) con estado de recuperación en `default`.
* **`project_2` (UART de otro año) y `TP_2` (intento anterior):** se tomaron como referencia pero **no se copiaron**,
  porque tienen problemas que acá se corrigieron: la FIFO hace avanzar el puntero de lectura si se lee estando
  vacía en un ciclo con escritura, el `uart_rx` de `TP_2` nunca levanta `rx_done_tick` (lo asigna a 0) y `rx` entra sin sincronizar.
