`timescale 1ns / 1ps

// TB integracion final: uart_alu_top por el cable serie.
// El testbench hace de PC: envia [A][B][OP] por rx y decodifica el byte que
// vuelve por tx. Verifica contra un modelo de la ALU:
//   - una operacion de cada tipo + codigo invalido,
//   - N_RANDOM comandos aleatorios (uno por vez),
//   - una rafaga de comandos sin esperar la respuesta (colas FIFO).
// Parametros: CLK_FREQ (por defecto 1.2288 MHz para simular rapido; usar
// 100000000 para el reloj real de la Basys3), BAUD_RATE, NUM_RANDOM.
module tb_uart_alu_top;

    parameter integer CLK_FREQ   = 1_228_800;
    parameter integer BAUD_RATE  = 19_200;
    parameter integer NUM_RANDOM = 40;

    localparam real CLK_NS = 1.0e9 / CLK_FREQ;
    localparam real BIT_NS = 1.0e9 / BAUD_RATE;

    reg         clk = 1'b0, btnC = 1'b1, rx = 1'b1;
    wire        tx;
    wire [15:0] led;

    always #(CLK_NS / 2.0) clk = ~clk;

    uart_alu_top #(.CLK_FREQ(CLK_FREQ), .BAUD_RATE(BAUD_RATE)) dut (
        .clk(clk), .btnC(btnC), .rx(rx), .tx(tx), .led(led)
    );

    // ---------- "PC": emisor ----------
    task send_byte;
        input [7:0] d;
        integer i;
        begin
            rx = 1'b0; #(BIT_NS);
            for (i = 0; i < 8; i = i + 1) begin rx = d[i]; #(BIT_NS); end
            rx = 1'b1; #(BIT_NS);
        end
    endtask

    // ---------- "PC": receptor (decodifica tx en el centro de cada bit) ----------
    reg [7:0] resp [0:255];
    integer   resp_n = 0, bad_frames = 0;
    reg [7:0] rcv;
    integer   j;

    initial begin : monitor
        forever begin
            @(negedge tx);
            #(BIT_NS / 2.0);
            if (tx !== 1'b0) bad_frames = bad_frames + 1;
            for (j = 0; j < 8; j = j + 1) begin #(BIT_NS); rcv[j] = tx; end
            #(BIT_NS);
            if (tx !== 1'b1) bad_frames = bad_frames + 1;
            resp[resp_n] = rcv;
            resp_n = resp_n + 1;
        end
    end

    // ---------- modelo ALU ----------
    function [7:0] model;
        input [5:0] op;
        input [7:0] a, b;
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
                default:   model = 8'h00;
            endcase
        end
    endfunction

    reg [7:0] exp_res [0:255];
    integer   exp_n = 0, errors = 0, checks = 0;
    integer   shown = 0;

    task send_cmd;                 // envia [a][b][op] y registra el resultado esperado
        input [7:0] op, a, b;
        begin
            exp_res[exp_n] = model(op[5:0], a, b);
            exp_n = exp_n + 1;
            send_byte(a); send_byte(b); send_byte(op);
        end
    endtask

    task wait_responses;           // espera hasta tener todas las respuestas (o timeout)
        integer t;
        begin
            t = 0;
            while (resp_n < exp_n && t < 400) begin   // ~20 tiempos de trama
                #(BIT_NS / 2.0);
                t = t + 1;
            end
        end
    endtask

    integer i;
    reg [7:0] ops [0:7];
    reg [7:0] ra, rb;

    initial begin
        ops[0] = 8'h20; ops[1] = 8'h22; ops[2] = 8'h24; ops[3] = 8'h25;
        ops[4] = 8'h26; ops[5] = 8'h27; ops[6] = 8'h02; ops[7] = 8'h03;

        $display("TB uart_alu_top: CLK_FREQ=%0d BAUD=%0d NUM_RANDOM=%0d", CLK_FREQ, BAUD_RATE, NUM_RANDOM);
        repeat (20) @(posedge clk);
        btnC = 1'b0;
        repeat (20) @(posedge clk);
        #(BIT_NS * 2);

        // 1) una por operacion, esperando cada respuesta
        send_cmd(8'h20, 8'd100, 8'd27);  wait_responses;   // ADD
        send_cmd(8'h22, 8'd5,   8'd10);  wait_responses;   // SUB
        send_cmd(8'h24, 8'hF0,  8'h3C);  wait_responses;   // AND
        send_cmd(8'h25, 8'hF0,  8'h0F);  wait_responses;   // OR
        send_cmd(8'h26, 8'hFF,  8'h0F);  wait_responses;   // XOR
        send_cmd(8'h27, 8'hF0,  8'h0F);  wait_responses;   // NOR
        send_cmd(8'h02, 8'd3,   8'hF0);  wait_responses;   // SRL
        send_cmd(8'h03, 8'd3,   8'hF0);  wait_responses;   // SRA
        send_cmd(8'h3F, 8'd1,   8'd1);   wait_responses;   // op invalida -> 0

        // 2) aleatorios, uno por vez
        for (i = 0; i < NUM_RANDOM; i = i + 1) begin
            ra = $random; rb = $random;
            send_cmd(ops[$unsigned($random) % 8], ra, rb);
            wait_responses;
        end

        // 3) rafaga: 4 comandos seguidos (12 bytes) sin esperar; las 4 respuestas salen en orden
        for (i = 0; i < 4; i = i + 1) begin
            ra = $random; rb = $random;
            send_cmd(ops[$unsigned($random) % 8], ra, rb);
        end
        wait_responses;
        #(BIT_NS * 3);

        // ---- verificacion ----
        for (i = 0; i < exp_n; i = i + 1) begin
            checks = checks + 1;
            if (i >= resp_n || resp[i] !== exp_res[i]) begin
                errors = errors + 1;
                $display("FALLO: respuesta #%0d = %h, esperada %h", i, (i < resp_n) ? resp[i] : 8'hxx, exp_res[i]);
            end
        end
        checks = checks + 3;
        if (resp_n != exp_n)    begin errors = errors + 1; $display("FALLO: %0d respuestas, esperadas %0d", resp_n, exp_n); end
        if (bad_frames != 0)    begin errors = errors + 1; $display("FALLO: %0d tramas de salida mal formadas", bad_frames); end
        if (led[15] !== 1'b0)   begin errors = errors + 1; $display("FALLO: led[15] (frame_err) encendido"); end

        if (errors == 0) $display("TB_uart_alu_top: PASO (%0d chequeos, %0d comandos, 0 errores)", checks, exp_n);
        else             $display("TB_uart_alu_top: FALLO (%0d errores)", errors);
        $finish;
    end

    // muestra las primeras operaciones para ver el protocolo en el log
    always @(resp_n) if (resp_n > 0 && resp_n <= 9)
        $display("  respuesta #%0d = 0x%h  (esperada 0x%h)  t=%0t", resp_n - 1, resp[resp_n-1], exp_res[resp_n-1], $time);

    initial begin
        #(20.0e9);        // watchdog: 20 s de tiempo simulado
        $display("TB_uart_alu_top: FALLO (timeout)");
        $finish;
    end

endmodule
