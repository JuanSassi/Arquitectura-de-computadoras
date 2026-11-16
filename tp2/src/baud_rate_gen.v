`timescale 1ns / 1ps

// Modulo 1 - Baud Rate Generator.
//
// Genera un pulso de 1 ciclo de clk ("tick") OVERSAMPLE veces por periodo de
// baudio. El Rx y el Tx cuentan estos ticks para medir el tiempo de un bit
// (16 ticks = 1 bit), asi no hace falta un reloj distinto para la UART.
//
//   DVSR = CLK_FREQ / (BAUD_RATE * OVERSAMPLE)   (redondeado al entero mas cercano)
//   100 MHz / (19200 * 16) = 325.52 -> 326  (error de baud ~0.15 %)
//
// Es un contador modulo DVSR: cuenta 0..DVSR-1 y levanta tick al terminar.
module baud_rate_gen #(
    parameter integer CLK_FREQ   = 100_000_000,
    parameter integer BAUD_RATE  = 19_200,
    parameter integer OVERSAMPLE = 16
)(
    input  wire clk,
    input  wire reset,   // sincronico, activo en alto
    output reg  tick     // 1 ciclo en alto cada DVSR ciclos de clk
);

    localparam integer DVSR   = (CLK_FREQ + (BAUD_RATE * OVERSAMPLE) / 2) / (BAUD_RATE * OVERSAMPLE);
    localparam integer CNT_W  = (DVSR <= 2) ? 1 : $clog2(DVSR);

    reg [CNT_W-1:0] cnt = {CNT_W{1'b0}};

    always @(posedge clk) begin
        if (reset) begin
            cnt  <= {CNT_W{1'b0}};
            tick <= 1'b0;
        end else begin
            // tick registrado: sale sin glitches y con periodo exacto DVSR
            tick <= (cnt == DVSR - 1);
            if (cnt == DVSR - 1) cnt <= {CNT_W{1'b0}};
            else                 cnt <= cnt + 1'b1;
        end
    end

endmodule
