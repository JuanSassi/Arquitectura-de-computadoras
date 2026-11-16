`timescale 1ns / 1ps

// TB modulo 1: baud_rate_gen.
// Verifica: (a) tick cada DVSR ciclos exactos, (b) tick dura 1 ciclo,
//           (c) con reset activo no hay ticks y el conteo reinicia.
module tb_baud_rate_gen;

    parameter integer CLK_FREQ  = 1_228_800;   // DVSR = 4 (simulacion rapida)
    parameter integer BAUD_RATE = 19_200;

    localparam integer DVSR   = (CLK_FREQ + (BAUD_RATE * 16) / 2) / (BAUD_RATE * 16);
    localparam real    CLK_NS = 1.0e9 / CLK_FREQ;

    reg  clk = 1'b0, reset = 1'b1;
    wire tick;

    always #(CLK_NS / 2.0) clk = ~clk;

    baud_rate_gen #(.CLK_FREQ(CLK_FREQ), .BAUD_RATE(BAUD_RATE)) dut (
        .clk(clk), .reset(reset), .tick(tick)
    );

    integer errors = 0, checks = 0;
    integer cyc = 0, last_tick_cyc = -1, n_ticks = 0;
    reg     prev_tick = 1'b0;

    always @(posedge clk) begin
        cyc <= cyc + 1;
        prev_tick <= tick;
        if (tick) begin
            checks = checks + 1;
            if (reset) begin
                errors = errors + 1;
                $display("FALLO: tick con reset activo (t=%0t)", $time);
            end
            if (prev_tick) begin
                errors = errors + 1;
                $display("FALLO: tick dura mas de 1 ciclo (t=%0t)", $time);
            end
            if (last_tick_cyc >= 0 && (cyc - last_tick_cyc) != DVSR) begin
                errors = errors + 1;
                $display("FALLO: periodo entre ticks = %0d ciclos, esperado %0d", cyc - last_tick_cyc, DVSR);
            end
            last_tick_cyc = cyc;
            n_ticks = n_ticks + 1;
        end
    end

    initial begin
        $display("TB baud_rate_gen: CLK_FREQ=%0d BAUD=%0d -> DVSR=%0d (tick cada %0.3f us)",
                 CLK_FREQ, BAUD_RATE, DVSR, DVSR * CLK_NS / 1000.0);
        repeat (5) @(posedge clk);
        reset = 1'b0;

        repeat (50 * DVSR) @(posedge clk);
        checks = checks + 1;
        if (n_ticks < 49 || n_ticks > 50) begin
            errors = errors + 1;
            $display("FALLO: se esperaban ~50 ticks en 50*DVSR ciclos y hubo %0d", n_ticks);
        end

        // reset en medio de la cuenta: el siguiente tick debe tardar DVSR+1 ciclos
        @(negedge clk) reset = 1'b1;
        repeat (3 * DVSR) @(posedge clk);
        @(negedge clk) reset = 1'b0;
        last_tick_cyc = -1;
        repeat (3 * DVSR) @(posedge clk);

        if (errors == 0) $display("TB_baud_rate_gen: PASO (%0d chequeos, 0 errores)", checks);
        else             $display("TB_baud_rate_gen: FALLO (%0d errores)", errors);
        $finish;
    end

endmodule
