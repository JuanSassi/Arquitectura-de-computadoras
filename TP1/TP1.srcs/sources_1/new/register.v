`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 01:34:35 PM
// Design Name: 
// Module Name: register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register #(parameter WIDTH = 8)
(
input wire [WIDTH-1:0] databus,
input wire reset,
input wire clk,
input wire enable,
output reg [WIDTH-1:0] savedvalue
    );
    
always @(posedge clk or posedge reset) begin
    if(reset)
        savedvalue <= {WIDTH{1'b0}};
    else if (enable)
        savedvalue <= databus;
end
endmodule
