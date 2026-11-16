`timescale 1ns / 1ps

// TB modulo 6: alu_uart_ctrl conectado al uart_interface real.
// A nivel de senales, sin serie: el testbench inyecta bytes como si los
// entregara el Rx (rx_done_tick/rx_dout) y un modelo del Tx consume los
// resultados (tx_start/tx_din -> tx_done_tick, tardando varios ciclos).
// Los comandos [A][B][OP] se envian "amontonados" para probar tambien el
// control de flujo (rx_full en la entrada, tx_full en la salida).
module tb_alu_uart_ctrl;

    localparam integer N     = 8;
    localparam integer NUM_RANDOM = 300;

    reg          clk = 1'b0, reset = 1'b1;
    always #5 clk = ~clk;

    // ---- lado "UART" (modelado por el tb) ----
    reg          rx_done_tick = 1'b0;
    reg  [N-1:0] rx_dout = 0;
    reg          tx_done_tick = 1'b0;
    wire         tx_start;
    wire [N-1:0] tx_din;

    // ---- ALU <-> interface ----
    wire         rd, wr, rx_empty, rx_full, tx_full;
    wire [N-1:0] r_data, w_data, result;
    wire [2:0]   state_dbg;

    uart_interface #(.DBIT(N), .ADDR_W(4)) intf (
        .clk(clk), .reset(reset),
        .rx_done_tick(rx_done_tick), .rx_dout(rx_dout),
        .tx_done_tick(tx_done_tick), .tx_start(tx_start), .tx_din(tx_din),
        .rd(rd), .r_data(r_data), .rx_empty(rx_empty), .rx_full(rx_full),
        .wr(wr), .w_data(w_data), .tx_full(tx_full)
    );

    alu_uart_ctrl #(.N(N)) dut (
        .clk(clk), .reset(reset),
        .rx_empty(rx_empty), .r_data(r_data), .rd(rd),
        .tx_full(tx_full), .w_data(w_data), .wr(wr),
        .result(result), .state_dbg(state_dbg)
    );

    // ---- modelo del Tx: tarda TX_CYC ciclos por byte ----
    localparam integer TX_CYC = 9;
    reg [7:0] resp [0:1023];
    integer   resp_n = 0;
    integer   busy_cnt = 0;
    reg       busy = 1'b0;
    integer   seen_tx_full = 0, seen_rx_full = 0;

    always @(posedge clk) begin
        tx_done_tick <= 1'b0;
        if (tx_full) seen_tx_full = seen_tx_full + 1;
        if (rx_full) seen_rx_full = seen_rx_full + 1;
        if (!busy) begin
            if (tx_start) begin busy <= 1'b1; busy_cnt <= TX_CYC; end
        end else if (tx_done_tick) begin
            busy <= 1'b0;                       // la FIFO tx descarta el byte en este mismo flanco
        end else if (busy_cnt == 0) begin
            tx_done_tick <= 1'b1;
            resp[resp_n] = tx_din;              // el Tx habria transmitido este byte
            resp_n = resp_n + 1;
        end else begin
            busy_cnt <= busy_cnt - 1;
        end
    end

    // ---- modelo de referencia de la ALU (independiente del DUT) ----
    function [N-1:0] model;
        input [5:0]   op;
        input [N-1:0] a, b;
        begin
            case (op)
                6'b100000: model = a + b;
                6'b100010: model = a - b;
                6'b100100: model = a & b;
                6'b100101: model = a | b;
                6'b100110: model = a ^ b;
                6'b100111: model = ~(a | b);
                6'b000010: model = b >> a[2:0];
                6'b000011: model = $signed(b) >>> a[2:0];
                default:   model = {N{1'b0}};
            endcase
        end
    endfunction

    reg [7:0] exp_res [0:1023];
    integer   exp_n = 0;
    integer   errors = 0, checks = 0;

    // inyecta un byte (pulso de 1 ciclo) respetando rx_full (el Rx real nunca satura
    // porque llega 1 byte cada ~520 us; aca simulamos a "toda velocidad")
    task inject;
        input [7:0] d;
        begin
            while (rx_full) @(negedge clk);
            rx_dout = d; rx_done_tick = 1'b1;
            @(negedge clk);
            rx_done_tick = 1'b0;
        end
    endtask

    task command;
        input [7:0] op_byte;
        input [7:0] a, b;
        input integer gap;           // ciclos de espera entre bytes
        begin
            exp_res[exp_n] = model(op_byte[5:0], a, b);
            exp_n = exp_n + 1;
            inject(a);       repeat (gap) @(negedge clk);
            inject(b);       repeat (gap) @(negedge clk);
            inject(op_byte); repeat (gap) @(negedge clk);
        end
    endtask

    integer i;
    reg [7:0] ops [0:7];

    initial begin
        ops[0] = 8'h20; ops[1] = 8'h22; ops[2] = 8'h24; ops[3] = 8'h25;
        ops[4] = 8'h26; ops[5] = 8'h27; ops[6] = 8'h02; ops[7] = 8'h03;

        $display("TB alu_uart_ctrl: N=%0d", N);
        repeat (3) @(negedge clk);
        reset = 1'b0;
        repeat (3) @(negedge clk);

        // 1) ejemplos dirigidos (uno por operacion), un comando por vez
        command(8'h20, 8'd100, 8'd27, 0);     // ADD  100 + 27  = 127
        command(8'h20, 8'd200, 8'd100, 0);    // ADD  desborda 8 bits -> 44
        command(8'h22, 8'd5,   8'd10, 0);     // SUB  5 - 10 = 251 (-5)
        command(8'h24, 8'hF0,  8'h3C, 0);     // AND
        command(8'h25, 8'hF0,  8'h0F, 0);     // OR
        command(8'h26, 8'hFF,  8'h0F, 0);     // XOR
        command(8'h27, 8'hF0,  8'h0F, 0);     // NOR
        command(8'h02, 8'd3,   8'hF0, 0);     // SRL: 0xF0 >> 3
        command(8'h03, 8'd3,   8'hF0, 0);     // SRA: 0xF0 >>> 3 (extiende el signo)
        command(8'h00, 8'd1,   8'd1,  0);     // op invalida -> 0
        command(8'hE0, 8'd7,   8'd8,  0);     // bits altos de OP se ignoran (0xE0 -> 0x20 = ADD)

        // esperar que se vacien las colas
        wait (resp_n == exp_n);
        repeat (20) @(negedge clk);

        // 2) aleatorios en rafaga (sin esperar la respuesta, con pausas cortas al azar)
        for (i = 0; i < NUM_RANDOM; i = i + 1)
            command(ops[$unsigned($random) % 8], $random, $random, $unsigned($random) % 3);

        wait (resp_n == exp_n);
        repeat (50) @(negedge clk);

        // comparar todo en orden
        for (i = 0; i < exp_n; i = i + 1) begin
            checks = checks + 1;
            if (resp[i] !== exp_res[i]) begin
                errors = errors + 1;
                $display("FALLO: resultado #%0d = %h, esperado %h", i, resp[i], exp_res[i]);
            end
        end
        checks = checks + 1;
        if (resp_n != exp_n) begin errors = errors + 1; $display("FALLO: %0d respuestas, esperadas %0d", resp_n, exp_n); end
        checks = checks + 1;
        if (state_dbg !== 3'd0) begin errors = errors + 1; $display("FALLO: la FSM no volvio a ST_A"); end

        $display("  (tx_full visto %0d ciclos, rx_full visto %0d ciclos: control de flujo %s)",
                 seen_tx_full, seen_rx_full, (seen_tx_full > 0) ? "ejercitado" : "no ejercitado");
        if (errors == 0) $display("TB_alu_uart_ctrl: PASO (%0d chequeos, %0d comandos, 0 errores)", checks, exp_n);
        else             $display("TB_alu_uart_ctrl: FALLO (%0d errores)", errors);
        $finish;
    end

    initial begin
        #(50_000_000);
        $display("TB_alu_uart_ctrl: FALLO (timeout)");
        $finish;
    end

endmodule
