`timescale 1ns / 1ps

// Antirrebote simple: sincroniza la entrada y solo actualiza la salida
// "limpia" cuando el valor sincronizado se mantiene estable durante
// DEBOUNCE_LIMIT ciclos de clk seguidos.
module debounce #(
    parameter integer DEBOUNCE_LIMIT = 250000 // ~2.5 ms a 100 MHz
)(
    input  wire clk,
    input  wire btn_in,
    output reg  btn_clean = 1'b0
);

    reg [1:0] sync = 2'b00;
    reg [$clog2(DEBOUNCE_LIMIT+1)-1:0] count = 0;

    always @(posedge clk) begin
        sync <= {sync[0], btn_in};
    end

    always @(posedge clk) begin
        if (sync[1] == btn_clean) begin
            count <= 0;
        end else if (count == DEBOUNCE_LIMIT) begin
            btn_clean <= sync[1];
            count     <= 0;
        end else begin
            count <= count + 1'b1;
        end
    end

endmodule
