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

 // cambios params y reset a 11

module alu #(parameter WIDTH = 8,
parameter RESET_OUTPUT = 9'h1FF)
(
input signed [WIDTH-1:0] dataa,datab,
input wire [5:0] opcode,
output reg signed [WIDTH-1:0] result,
output reg zero, overflow
    );
    localparam ADD_CODE = 6'b100000;
    localparam SUB_CODE = 6'b100010;
    localparam AND_CODE = 6'b100100;
    localparam OR_CODE = 6'b100101;
    localparam XOR_CODE = 6'b100110;
    localparam SRA_CODE = 6'b000011;
    localparam SRL_CODE = 6'b000010;
    localparam NOR_CODE = 6'b100111;    
    
always@ (*) begin
// complemento a 2
case (opcode)
    ADD_CODE : begin
        result = dataa + datab;
        overflow = (dataa[WIDTH-1] == datab[WIDTH-1]) && (result[WIDTH-1] != dataa[WIDTH-1]);
    end
    SUB_CODE: begin
        result   = dataa - datab;
        overflow = (dataa[WIDTH-1] != datab[WIDTH-1]) && (result[WIDTH-1] != dataa[WIDTH-1]);
    end
    AND_CODE: begin
        result =  dataa & datab;
        overflow = 1'b0;       
    end   
    OR_CODE: begin 
        result = dataa | datab;   
        overflow = 1'b0; 
    end        
    XOR_CODE: begin
        result = dataa ^ datab;           
        overflow = 1'b0;
        end
    SRA_CODE: begin
        result = dataa >>> datab;
        overflow = 1'b0;
        end
    SRL_CODE: begin
        result= dataa >> datab;
        overflow = 1'b0;
        end          
    NOR_CODE: begin
        result = ~(dataa | datab);
        overflow = 1'b0;
        end        
    default:   {overflow, result} = RESET_OUTPUT;
endcase
zero = ~|result;
end
endmodule
