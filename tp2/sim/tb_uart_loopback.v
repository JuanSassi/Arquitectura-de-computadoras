`timescale 1ns / 1ps

// TB integracion 1: uart_tx -> uart_rx (loopback) con un unico baud_rate_gen.
// Verifica que el Tx y el Rx "se entienden": todo byte que sale por tx y entra a rx
// aparece identico en dout/rx_done_tick, sin frame_err y sin perder bytes.
module tb_uart_loopback;

    parameter integer CLK_FREQ  = 1_228_800;
    parameter integer BAUD_RATE = 19_200;
    parameter integer N_BYTES   = 60;

    localparam real CLK_NS = 1.0e9 / CLK_FREQ;

    reg        clk = 1'b0, reset = 1'b1;
    wire       s_tick, tx_done_tick, tx;
    wire       rx_done_tick, frame_err;
    wire [7:0] dout;

    always #(CLK_NS / 2.0) clk = ~clk;

    // ---- cola de envio (igual criterio que la FIFO tx del interface) ----
    reg [7:0] q [0:255];
    integer   q_wr = 0, q_rd = 0;
    wire        tx_start = (q_rd != q_wr);
    wire [7:0]  din      = q[q_rd];

    always @(posedge clk) begin
        if (reset)             q_rd <= q_wr;
        else if (tx_done_tick) q_rd <= q_rd + 1;
    end

    baud_rate_gen #(.CLK_FREQ(CLK_FREQ), .BAUD_RATE(BAUD_RATE)) baud (
        .clk(clk), .reset(reset), .tick(s_tick)
    );
    uart_tx u_tx (
        .clk(clk), .reset(reset), .tx_start(tx_start), .s_tick(s_tick),
        .din(din), .tx_done_tick(tx_done_tick), .tx(tx)
    );
    uart_rx u_rx (
        .clk(clk), .reset(reset), .rx(tx), .s_tick(s_tick),       // <- rx conectado a tx
        .rx_done_tick(rx_done_tick), .frame_err(frame_err), .dout(dout)
    );

    integer errors = 0, checks = 0, got_n = 0, i;

    always @(posedge clk) begin
        if (rx_done_tick) begin
            checks = checks + 1;
            if (dout !== q[got_n]) begin
                errors = errors + 1;
                $display("FALLO: byte #%0d recibido %h, enviado %h", got_n, dout, q[got_n]);
            end
            got_n = got_n + 1;
        end
        if (frame_err) begin errors = errors + 1; $display("FALLO: frame_err"); end
    end

    initial begin
        $display("TB uart_loopback: tx -> rx, %0d bytes", N_BYTES);
        repeat (10) @(posedge clk);
        reset = 1'b0;
        repeat (10) @(posedge clk);

        // directos: todos los patrones de un solo bit + extremos
        for (i = 0; i < 8; i = i + 1) begin q[q_wr] = 8'h01 << i; q_wr = q_wr + 1; end
        q[q_wr] = 8'h00; q_wr = q_wr + 1;
        q[q_wr] = 8'hFF; q_wr = q_wr + 1;
        // aleatorios
        for (i = 0; i < N_BYTES - 10; i = i + 1) begin q[q_wr] = $random; q_wr = q_wr + 1; end

        wait (got_n == N_BYTES);
        repeat (400) @(posedge clk);

        checks = checks + 1;
        if (got_n != N_BYTES) begin errors = errors + 1; $display("FALLO: bytes recibidos %0d de %0d", got_n, N_BYTES); end

        if (errors == 0) $display("TB_uart_loopback: PASO (%0d chequeos, 0 errores)", checks);
        else             $display("TB_uart_loopback: FALLO (%0d errores)", errors);
        $finish;
    end

    initial begin
        #(2_000_000_000);
        $display("TB_uart_loopback: FALLO (timeout)");
        $finish;
    end

endmodule
