`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 01:34:35 PM
// Design Name: 
// Module Name: alu
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


module alu #(parameter WIDTH = 8)
(
input signed [WIDTH-1:0] dataa,datab,
input wire [5:0] opcode,
output reg [WIDTH-1:0] result,
output reg zero, carry
    );
    
always@ (*) begin
case (opcode)
    6'b100000: {carry, result} = dataa + datab;
    6'b100010: {carry, result} = dataa - datab;
    6'b100100: {carry, result} = {{1'b0}, dataa & datab};           
    6'b100101: {carry, result} = {{1'b0}, dataa | datab};           
    6'b100110: {carry, result} = {{1'b0}, dataa ^ datab};           
    6'b000011: {carry, result} = {{1'b0}, dataa >>> datab};
    6'b000010: {carry, result} = {{1'b0}, dataa >> datab};          
    6'b100111: {carry, result} = {{1'b0}, ~(dataa | datab)};        
    default:   {carry, result} = {{1'b0}, {WIDTH{1'b0}}};
endcase
zero = ~(|result);
end
endmodule
