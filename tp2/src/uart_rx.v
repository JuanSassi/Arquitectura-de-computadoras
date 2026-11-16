`timescale 1ns / 1ps

// Modulo 2 - Receptor UART (FSM idle -> start -> data -> stop).
//
// Sigue el diagrama de estados de la clase ("Diagrama de estados Rx"):
//   idle  : espera el flanco de bajada de rx (bit de start).
//   start : cuenta 8 ticks -> mitad del bit de start; si rx ya volvio a 1 era ruido.
//   data  : cada 16 ticks (mitad de cada bit) muestrea rx y lo mete al shift
//           register por la izquierda (LSB primero => queda alineado al final).
//   stop  : cuenta SB_TICK ticks (mitad del bit de stop), valida rx == 1 y
//           emite rx_done_tick durante 1 ciclo.
//
// Mejoras sobre la FSM de la filmina:
//   * rx pasa por un sincronizador de 2 FF (viene de un pin asincrono).
//   * idle exige un FLANCO de bajada, no solo rx==0. Asi, si un stop bit llega
//     en 0 (frame_err) no se arranca un frame falso con la linea todavia baja.
//   * Si el stop bit no es 1 no se emite rx_done_tick; se emite frame_err.
module uart_rx #(
    parameter integer DBIT    = 8,    // bits de datos (<= 16)
    parameter integer SB_TICK = 16    // ticks del stop (16 = 1 bit, 32 = 2 bits)
)(
    input  wire            clk,
    input  wire            reset,        // sincronico, activo en alto
    input  wire            rx,           // linea serie (asincrona)
    input  wire            s_tick,       // tick x16 del baud_rate_gen
    output reg             rx_done_tick, // 1 ciclo: dout tiene un byte valido
    output reg             frame_err,    // 1 ciclo: stop bit invalido (byte descartado)
    output wire [DBIT-1:0] dout          // ultimo byte recibido (estable hasta el proximo)
);

    // Estados (4 -> codificacion binaria; default = recuperacion a idle)
    localparam [1:0] ST_IDLE  = 2'b00,
                     ST_START = 2'b01,
                     ST_DATA  = 2'b10,
                     ST_STOP  = 2'b11;

    // ---- Sincronizador de entrada + detector de flanco ----
    reg [2:0] rx_sync = 3'b111;               // [0]=ff1  [1]=ff2 (rx_in)  [2]=rx_in retrasado
    always @(posedge clk) rx_sync <= {rx_sync[1:0], rx};
    wire rx_in      = rx_sync[1];
    wire rx_falling = rx_sync[2] & ~rx_sync[1];

    // ---- Registros de la FSMD ----
    reg [1:0]      state_reg, state_next;
    reg [4:0]      s_reg,     s_next;         // contador de ticks (0..SB_TICK-1)
    reg [3:0]      n_reg,     n_next;         // bits de datos recibidos
    reg [DBIT-1:0] b_reg,     b_next;         // shift register
    reg            done_next, ferr_next;

    always @(posedge clk) begin
        if (reset) begin
            state_reg    <= ST_IDLE;
            s_reg        <= 5'd0;
            n_reg        <= 4'd0;
            b_reg        <= {DBIT{1'b0}};
            rx_done_tick <= 1'b0;
            frame_err    <= 1'b0;
        end else begin
            state_reg    <= state_next;
            s_reg        <= s_next;
            n_reg        <= n_next;
            b_reg        <= b_next;
            rx_done_tick <= done_next;        // salidas registradas: sin glitches
            frame_err    <= ferr_next;
        end
    end

    // ---- Logica de proximo estado y de datos ----
    always @* begin
        state_next = state_reg;
        s_next     = s_reg;
        n_next     = n_reg;
        b_next     = b_reg;
        done_next  = 1'b0;
        ferr_next  = 1'b0;

        case (state_reg)
            ST_IDLE: begin
                if (rx_falling) begin
                    state_next = ST_START;
                    s_next     = 5'd0;
                end
            end

            ST_START: begin
                if (s_tick) begin
                    if (s_reg == 5'd7) begin               // mitad del bit de start
                        if (rx_in) begin
                            state_next = ST_IDLE;          // glitch: no era un start
                        end else begin
                            state_next = ST_DATA;
                            s_next     = 5'd0;
                            n_next     = 4'd0;
                        end
                    end else begin
                        s_next = s_reg + 1'b1;
                    end
                end
            end

            ST_DATA: begin
                if (s_tick) begin
                    if (s_reg == 5'd15) begin              // mitad del bit de dato
                        s_next = 5'd0;
                        b_next = {rx_in, b_reg[DBIT-1:1]};
                        if (n_reg == DBIT - 1) state_next = ST_STOP;
                        else                   n_next     = n_reg + 1'b1;
                    end else begin
                        s_next = s_reg + 1'b1;
                    end
                end
            end

            ST_STOP: begin
                if (s_tick) begin
                    if (s_reg == SB_TICK - 1) begin        // mitad del bit de stop
                        state_next = ST_IDLE;
                        if (rx_in) done_next = 1'b1;
                        else       ferr_next = 1'b1;
                    end else begin
                        s_next = s_reg + 1'b1;
                    end
                end
            end

            default: state_next = ST_IDLE;                 // recuperacion de falla
        endcase
    end

    assign dout = b_reg;

endmodule
