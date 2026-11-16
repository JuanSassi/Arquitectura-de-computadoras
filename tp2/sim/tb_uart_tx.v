`timescale 1ns / 1ps

// TB modulo 3: uart_tx (con baud_rate_gen).
// Una cola hace de "interface": tx_start = cola no vacia, din = cabeza de la
// cola, y la cabeza se descarta con tx_done_tick (igual que la FIFO real).
// Un monitor independiente decodifica la linea tx midiendo en el centro de
// cada bit, y con 0x55 (alterna 0/1) mide el ancho exacto de cada bit.
module tb_uart_tx;

    parameter integer CLK_FREQ  = 1_228_800;
    parameter integer BAUD_RATE = 19_200;

    localparam integer DVSR   = (CLK_FREQ + (BAUD_RATE * 16) / 2) / (BAUD_RATE * 16);
    localparam real    CLK_NS = 1.0e9 / CLK_FREQ;
    localparam real    BIT_NS = 16.0 * DVSR * CLK_NS;     // duracion esperada de 1 bit

    reg        clk = 1'b0, reset = 1'b1;
    wire       s_tick, tx_done_tick, tx;

    always #(CLK_NS / 2.0) clk = ~clk;

    // ---- cola de bytes a enviar ----
    reg [7:0] q [0:63];
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

    uart_tx dut (
        .clk(clk), .reset(reset), .tx_start(tx_start), .s_tick(s_tick),
        .din(din), .tx_done_tick(tx_done_tick), .tx(tx)
    );

    integer errors = 0, checks = 0;

    // ---- chequeo de ancho de pulso de tx_done_tick ----
    reg prev_done = 1'b0;
    integer done_n = 0;
    always @(posedge clk) begin
        prev_done <= tx_done_tick;
        if (tx_done_tick) begin
            done_n = done_n + 1;
            if (prev_done) begin errors = errors + 1; $display("FALLO: tx_done_tick dura mas de 1 ciclo"); end
        end
    end

    // ---- monitor de la linea tx ----
    reg [7:0] exp_data [0:63];
    integer   mon_n = 0;
    integer   total = 0;

    task push;
        input [7:0] d;
        begin
            q[q_wr] = d;
            exp_data[total] = d;
            total = total + 1;
            q_wr = q_wr + 1;
        end
    endtask

    integer i;
    reg [7:0] rcv;
    realtime  t_m_edge, t_m_prev;

    initial begin : monitor
        forever begin
            @(negedge tx);                          // flanco de bajada = start
            #(BIT_NS / 2.0);
            checks = checks + 1;
            if (tx !== 1'b0) begin errors = errors + 1; $display("FALLO: start no es 0"); end
            for (i = 0; i < 8; i = i + 1) begin
                #(BIT_NS);
                rcv[i] = tx;
            end
            #(BIT_NS);
            checks = checks + 2;
            if (tx !== 1'b1) begin errors = errors + 1; $display("FALLO: stop no es 1"); end
            if (rcv !== exp_data[mon_n]) begin
                errors = errors + 1;
                $display("FALLO: byte #%0d transmitido %h, esperado %h", mon_n, rcv, exp_data[mon_n]);
            end
            mon_n = mon_n + 1;
        end
    end

    // ---- medicion de ancho de bit con 0x55 (hay un flanco en cada limite de bit) ----
    integer edge_n = 0;
    reg     measuring = 1'b0;
    always @(tx) begin
        if (measuring) begin
            t_m_edge = $realtime;
            if (edge_n > 0) begin
                checks = checks + 1;
                if ((t_m_edge - t_m_prev) < BIT_NS - 0.01 || (t_m_edge - t_m_prev) > BIT_NS + 0.01) begin
                    errors = errors + 1;
                    $display("FALLO: ancho de bit %0.3f ns, esperado %0.3f ns", t_m_edge - t_m_prev, BIT_NS);
                end
            end
            t_m_prev = t_m_edge;
            edge_n = edge_n + 1;
        end
    end

    initial begin
        $display("TB uart_tx: DVSR=%0d, 1 bit = %0.3f us", DVSR, BIT_NS / 1000.0);
        repeat (10) @(posedge clk);
        reset = 1'b0;
        repeat (20) @(posedge clk);

        // idle debe estar en 1
        checks = checks + 1;
        if (tx !== 1'b1) begin errors = errors + 1; $display("FALLO: tx no esta en 1 en reposo"); end

        // 1) medicion de anchos de bit con un unico 0x55
        measuring = 1'b1; edge_n = 0;
        push(8'h55);
        wait (mon_n == 1);
        #(BIT_NS * 0.2);
        measuring = 1'b0;
        checks = checks + 1;
        if (edge_n != 10) begin errors = errors + 1; $display("FALLO: 0x55 debia generar 10 flancos, hubo %0d", edge_n); end
        #(BIT_NS * 3);

        // 2) rafaga: 6 bytes cargados a la vez (tx_start queda en 1 entre tramas)
        push(8'h00); push(8'hFF); push(8'hA5); push(8'h5A); push(8'h01); push(8'h80);
        wait (mon_n == 7);
        #(BIT_NS * 3);

        // 3) bytes que llegan con la UART en reposo (arranque alineado a s_tick)
        push(8'h3C);
        wait (mon_n == 8);
        #(BIT_NS * 2.5);
        push(8'hC3);
        wait (mon_n == 9);
        #(BIT_NS * 1.5);

        // 4) aleatorios en rafaga
        for (i = 0; i < 10; i = i + 1) push($random);
        wait (mon_n == total);
        #(BIT_NS * 2);

        checks = checks + 1;
        if (done_n != total) begin
            errors = errors + 1;
            $display("FALLO: tx_done_tick %0d veces, esperado %0d", done_n, total);
        end
        checks = checks + 1;
        if (tx !== 1'b1) begin errors = errors + 1; $display("FALLO: tx no vuelve a 1"); end

        if (errors == 0) $display("TB_uart_tx: PASO (%0d chequeos, %0d bytes, 0 errores)", checks, total);
        else             $display("TB_uart_tx: FALLO (%0d errores)", errors);
        $finish;
    end

    initial begin
        #(1_000_000_000);
        $display("TB_uart_tx: FALLO (timeout)");
        $finish;
    end

endmodule
