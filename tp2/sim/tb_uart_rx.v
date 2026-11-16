`timescale 1ns / 1ps

// TB modulo 2: uart_rx (con el baud_rate_gen real que le da s_tick).
// El testbench hace de "PC": genera tramas serie en la linea rx.
// Casos: bytes dirigidos, rafaga sin pausas, bytes aleatorios, glitch en la
// linea (no debe recibir nada), stop bit invalido (frame_err, sin rx_done_tick)
// y tolerancia a +-3 % de error de baudrate del emisor.
module tb_uart_rx;

    parameter integer CLK_FREQ  = 1_228_800;
    parameter integer BAUD_RATE = 19_200;

    localparam real CLK_NS = 1.0e9 / CLK_FREQ;

    reg        clk = 1'b0, reset = 1'b1, rx = 1'b1;
    wire       s_tick, rx_done_tick, frame_err;
    wire [7:0] dout;

    always #(CLK_NS / 2.0) clk = ~clk;

    baud_rate_gen #(.CLK_FREQ(CLK_FREQ), .BAUD_RATE(BAUD_RATE)) baud (
        .clk(clk), .reset(reset), .tick(s_tick)
    );

    uart_rx dut (
        .clk(clk), .reset(reset), .rx(rx), .s_tick(s_tick),
        .rx_done_tick(rx_done_tick), .frame_err(frame_err), .dout(dout)
    );

    // ---------------- Scoreboard ----------------
    reg [7:0] exp_q [0:1023];
    integer   exp_n = 0, got_n = 0, ferr_n = 0, exp_ferr = 0;
    integer   errors = 0, checks = 0;
    reg       prev_done = 1'b0;

    always @(posedge clk) begin
        prev_done <= rx_done_tick;
        if (rx_done_tick) begin
            checks = checks + 1;
            if (prev_done) begin
                errors = errors + 1;
                $display("FALLO: rx_done_tick dura mas de 1 ciclo");
            end
            if (got_n >= exp_n) begin
                errors = errors + 1;
                $display("FALLO: rx_done_tick inesperado (dout=%h)", dout);
            end else if (dout !== exp_q[got_n]) begin
                errors = errors + 1;
                $display("FALLO: byte #%0d recibido %h, esperado %h", got_n, dout, exp_q[got_n]);
            end
            got_n = got_n + 1;
        end
        if (frame_err) ferr_n = ferr_n + 1;
    end

    // ---------------- "PC" emisor ----------------
    real bit_ns;

    task send_frame;
        input [7:0] d;
        input       stop_bit;
        input integer gap_bits;     // bits en reposo (rx = 1) despues de la trama
        integer i;
        begin
            rx = 1'b0;  #(bit_ns);                       // start
            for (i = 0; i < 8; i = i + 1) begin          // datos, LSB primero
                rx = d[i]; #(bit_ns);
            end
            rx = stop_bit; #(bit_ns);                    // stop
            rx = 1'b1;
            if (gap_bits > 0) #(bit_ns * gap_bits);
        end
    endtask

    task send_byte;
        input [7:0] d;
        input integer gap_bits;
        begin
            exp_q[exp_n] = d;
            exp_n = exp_n + 1;
            send_frame(d, 1'b1, gap_bits);
        end
    endtask

    integer k;

    initial begin
        bit_ns = 1.0e9 / BAUD_RATE;
        $display("TB uart_rx: CLK_FREQ=%0d BAUD=%0d", CLK_FREQ, BAUD_RATE);
        repeat (10) @(posedge clk);
        reset = 1'b0;
        repeat (20) @(posedge clk);

        // 1) bytes dirigidos con pausas
        send_byte(8'h00, 2);
        send_byte(8'hFF, 1);
        send_byte(8'hA5, 3);
        send_byte(8'h5A, 0);
        send_byte(8'h01, 0);
        send_byte(8'h80, 4);

        // 2) rafaga de 20 bytes aleatorios sin pausa entre tramas
        for (k = 0; k < 20; k = k + 1) send_byte($random, 0);

        // 3) glitch de 1/4 de bit en la linea: NO es un start valido
        rx = 1'b0; #(bit_ns / 4.0); rx = 1'b1; #(bit_ns * 3);
        send_byte(8'h3C, 2);              // y despues una trama normal igual se recibe

        // 4) stop bit invalido: frame_err, sin rx_done_tick, y se recupera
        send_frame(8'hC3, 1'b0, 2);
        exp_ferr = exp_ferr + 1;
        send_byte(8'h96, 2);

        // 5) emisor 3 % mas lento y 3 % mas rapido
        bit_ns = 1.0e9 / BAUD_RATE * 1.03;
        for (k = 0; k < 6; k = k + 1) send_byte($random, 1);
        bit_ns = 1.0e9 / BAUD_RATE * 0.97;
        for (k = 0; k < 6; k = k + 1) send_byte($random, 1);
        bit_ns = 1.0e9 / BAUD_RATE;

        #(bit_ns * 3);

        checks = checks + 2;
        if (got_n != exp_n) begin
            errors = errors + 1;
            $display("FALLO: se recibieron %0d bytes, esperados %0d", got_n, exp_n);
        end
        if (ferr_n != exp_ferr) begin
            errors = errors + 1;
            $display("FALLO: frame_err=%0d veces, esperado %0d", ferr_n, exp_ferr);
        end

        if (errors == 0) $display("TB_uart_rx: PASO (%0d chequeos, %0d bytes, %0d frame_err, 0 errores)", checks, got_n, ferr_n);
        else             $display("TB_uart_rx: FALLO (%0d errores)", errors);
        $finish;
    end

    initial begin
        #(2_000_000_000);   // watchdog 2 s de tiempo simulado
        $display("TB_uart_rx: FALLO (timeout)");
        $finish;
    end

endmodule
