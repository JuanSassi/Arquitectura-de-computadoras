`timescale 1ns / 1ps

// TB modulo 5: uart_interface, probado a nivel de senales (sin serie).
// El testbench hace de Rx/Tx (rx_done_tick, rx_dout, tx_done_tick) y de ALU
// (rd, wr, w_data) y mira las salidas: rx_empty, r_data, rx_full,
// tx_start, tx_din, tx_full.
module tb_uart_interface;

    localparam integer DBIT = 8;
    localparam integer AW   = 2;           // FIFOs de 4 palabras
    localparam integer DEPTH = 1 << AW;

    reg            clk = 1'b0, reset = 1'b1;
    reg            rx_done_tick = 1'b0, tx_done_tick = 1'b0, rd = 1'b0, wr = 1'b0;
    reg [DBIT-1:0] rx_dout = 0, w_data = 0;
    wire           tx_start, rx_empty, rx_full, tx_full;
    wire [DBIT-1:0] tx_din, r_data;

    always #5 clk = ~clk;

    uart_interface #(.DBIT(DBIT), .ADDR_W(AW)) dut (
        .clk(clk), .reset(reset),
        .rx_done_tick(rx_done_tick), .rx_dout(rx_dout),
        .tx_done_tick(tx_done_tick), .tx_start(tx_start), .tx_din(tx_din),
        .rd(rd), .r_data(r_data), .rx_empty(rx_empty), .rx_full(rx_full),
        .wr(wr), .w_data(w_data), .tx_full(tx_full)
    );

    integer errors = 0, checks = 0;

    task chk;
        input        cond;
        input [255:0] what;
        begin
            checks = checks + 1;
            if (!cond) begin errors = errors + 1; $display("FALLO t=%0t: %0s", $time, what); end
        end
    endtask

    // pulsos de 1 ciclo (se sueltan en negedge, se muestrean en el posedge siguiente)
    task rx_push;  input [DBIT-1:0] d; begin rx_dout = d; rx_done_tick = 1; @(negedge clk); rx_done_tick = 0; end endtask
    task alu_rd;   begin rd = 1; @(negedge clk); rd = 0; end endtask
    task alu_wr;   input [DBIT-1:0] d; begin w_data = d; wr = 1; @(negedge clk); wr = 0; end endtask
    task tx_done;  begin tx_done_tick = 1; @(negedge clk); tx_done_tick = 0; end endtask

    integer i;

    initial begin
        $display("TB uart_interface: FIFOs de %0d palabras", DEPTH);
        repeat (3) @(negedge clk);
        reset = 1'b0;
        @(negedge clk);

        // --- tras reset ---
        chk(rx_empty === 1 && rx_full === 0, "reset: rx_empty=1 rx_full=0");
        chk(tx_start === 0 && tx_full === 0, "reset: tx_start=0 tx_full=0");

        // --- RX: Rx entrega 3 bytes, la ALU los lee en orden ---
        rx_push(8'hA1);
        chk(rx_empty === 0, "rx: tras el 1er byte rx_empty=0");
        chk(r_data === 8'hA1, "rx: r_data = 1er byte");
        rx_push(8'hB2);
        rx_push(8'hC3);
        chk(r_data === 8'hA1, "rx: r_data sigue en A1 hasta que la ALU hace rd");
        alu_rd; chk(r_data === 8'hB2, "rx: despues de rd -> B2");
        alu_rd; chk(r_data === 8'hC3, "rx: despues de rd -> C3");
        alu_rd; chk(rx_empty === 1, "rx: tras leer todo rx_empty=1");
        alu_rd; chk(rx_empty === 1, "rx: rd con FIFO vacia se ignora");

        // --- RX: desborde (Rx llena la FIFO) ---
        for (i = 0; i < DEPTH; i = i + 1) rx_push(8'h20 + i);
        chk(rx_full === 1, "rx: FIFO llena -> rx_full=1");
        rx_push(8'hFF);                                   // se pierde
        for (i = 0; i < DEPTH; i = i + 1) begin
            chk(r_data === 8'h20 + i, "rx: orden conservado y 0xFF descartado");
            alu_rd;
        end
        chk(rx_empty === 1 && rx_full === 0, "rx: vacia otra vez");

        // --- TX: la ALU escribe, el Tx consume ---
        alu_wr(8'h11);
        chk(tx_start === 1, "tx: tras wr -> tx_start=1");
        chk(tx_din === 8'h11, "tx: tx_din = 11");
        alu_wr(8'h22);
        chk(tx_din === 8'h11, "tx: tx_din sigue en 11 hasta tx_done_tick");
        tx_done; chk(tx_din === 8'h22 && tx_start === 1, "tx: tras tx_done_tick -> 22");
        tx_done; chk(tx_start === 0, "tx: ultimo dato enviado -> tx_start=0");

        // --- TX: llenar la FIFO tx (la ALU debe ver tx_full) ---
        for (i = 0; i < DEPTH; i = i + 1) alu_wr(8'h40 + i);
        chk(tx_full === 1, "tx: FIFO llena -> tx_full=1");
        alu_wr(8'hEE);                                    // ignorado
        for (i = 0; i < DEPTH; i = i + 1) begin
            chk(tx_din === 8'h40 + i, "tx: orden conservado");
            tx_done;
        end
        chk(tx_start === 0 && tx_full === 0, "tx: vacia otra vez");

        // --- las dos FIFOs son independientes ---
        rx_push(8'h99); alu_wr(8'h88);
        chk(r_data === 8'h99 && tx_din === 8'h88, "rx y tx independientes");

        if (errors == 0) $display("TB_uart_interface: PASO (%0d chequeos, 0 errores)", checks);
        else             $display("TB_uart_interface: FALLO (%0d errores)", errors);
        $finish;
    end

endmodule
