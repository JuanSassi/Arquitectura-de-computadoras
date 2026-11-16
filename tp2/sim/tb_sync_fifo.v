`timescale 1ns / 1ps

// TB modulo 4: sync_fifo (profundidad 4 para llegar facil a lleno/vacio).
// Parte dirigida (lleno, vacio, wr+rd simultaneos, wr con full, rd con empty)
// y parte aleatoria comparada ciclo a ciclo contra un modelo de referencia.
module tb_sync_fifo;

    localparam integer W     = 8;
    localparam integer AW    = 2;
    localparam integer DEPTH = 1 << AW;

    reg          clk = 1'b0, reset = 1'b1, wr = 1'b0, rd = 1'b0;
    reg  [W-1:0] w_data = 0;
    wire [W-1:0] r_data;
    wire         empty, full;

    always #5 clk = ~clk;

    sync_fifo #(.DATA_W(W), .ADDR_W(AW)) dut (
        .clk(clk), .reset(reset), .wr(wr), .w_data(w_data),
        .rd(rd), .r_data(r_data), .empty(empty), .full(full)
    );

    // ---------------- modelo de referencia ----------------
    reg [W-1:0] m_mem [0:DEPTH-1];
    integer m_wp = 0, m_rp = 0, m_cnt = 0;
    integer errors = 0, checks = 0;

    // se aplica en negedge: actualiza el modelo igual que lo hara el DUT en el siguiente posedge
    task step;
        input         t_wr;
        input         t_rd;
        input [W-1:0] t_data;
        reg           do_wr, do_rd;
        begin
            do_wr = t_wr && (m_cnt < DEPTH);
            do_rd = t_rd && (m_cnt > 0);
            wr = t_wr; rd = t_rd; w_data = t_data;
            if (do_wr) begin m_mem[m_wp] = t_data; m_wp = (m_wp + 1) % DEPTH; end
            if (do_rd) m_rp = (m_rp + 1) % DEPTH;
            m_cnt = m_cnt + (do_wr ? 1 : 0) - (do_rd ? 1 : 0);
            @(negedge clk);
            check;
        end
    endtask

    task check;
        begin
            checks = checks + 1;
            if (empty !== (m_cnt == 0)) begin errors = errors + 1; $display("FALLO t=%0t: empty=%b, esperado %b", $time, empty, (m_cnt == 0)); end
            if (full  !== (m_cnt == DEPTH)) begin errors = errors + 1; $display("FALLO t=%0t: full=%b, esperado %b", $time, full, (m_cnt == DEPTH)); end
            if (m_cnt > 0 && r_data !== m_mem[m_rp]) begin
                errors = errors + 1;
                $display("FALLO t=%0t: r_data=%h, esperado %h", $time, r_data, m_mem[m_rp]);
            end
        end
    endtask

    integer i;

    initial begin
        $display("TB sync_fifo: DEPTH=%0d", DEPTH);
        repeat (3) @(negedge clk);
        reset = 1'b0;
        @(negedge clk);
        check;                                   // tras reset: vacia

        // escribir hasta llenar
        for (i = 0; i < DEPTH; i = i + 1) step(1, 0, 8'h10 + i);
        // escribir con full: se ignora (no pisa datos)
        step(1, 0, 8'hEE);
        step(1, 0, 8'hEF);
        // wr+rd con full: se lee, el wr se descarta
        step(1, 1, 8'hAA);
        // wr+rd con datos (no lleno ni vacio): ambos
        step(1, 1, 8'hBB);
        // vaciar
        for (i = 0; i < DEPTH + 2; i = i + 1) step(0, 1, 8'h00);
        // leer con empty: se ignora
        step(0, 1, 8'h00);
        // wr+rd con empty: solo escribe
        step(1, 1, 8'hCC);
        step(0, 1, 8'h00);
        step(0, 0, 8'h00);

        // aleatorio: 3000 ciclos con probabilidades variables
        for (i = 0; i < 3000; i = i + 1) begin
            case ((i / 500) % 3)
                0: step(($random & 3) != 0, ($random & 3) == 0, $random);   // mas escrituras -> tiende a lleno
                1: step(($random & 3) == 0, ($random & 3) != 0, $random);   // mas lecturas  -> tiende a vacio
                2: step($random, $random, $random);                          // 50/50
            endcase
        end

        // reset con datos adentro
        step(1, 0, 8'h77);
        reset = 1'b1; m_wp = 0; m_rp = 0; m_cnt = 0;
        @(negedge clk); wr = 0;
        check;
        reset = 1'b0;
        @(negedge clk); check;

        if (errors == 0) $display("TB_sync_fifo: PASO (%0d chequeos, 0 errores)", checks);
        else             $display("TB_sync_fifo: FALLO (%0d errores)", errors);
        $finish;
    end

endmodule
