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
output reg zero, overflow
    );
    
always@ (*) begin
// complemento a 2
case (opcode)
    6'b100000: begin
        result = dataa + datab;
        overflow = (dataa[WIDTH-1] == datab[WIDTH-1]) && (result[WIDTH-1] != dataa[WIDTH-1]);
    end
    6'b100010: begin
        result = dataa - datab;
        overflow = (dataa[WIDTH-1] == datab[WIDTH-1]) && (result[WIDTH-1] != dataa[WIDTH-1]);
    end
    6'b100100: begin
        result =  dataa & datab;
        overflow = 1'b0;       
    end   
    6'b100101: begin 
        result = dataa | datab;   
        overflow = 1'b0; 
    end        
    6'b100110: begin
        result = dataa ^ datab;           
        overflow = 1'b0;
        end
    6'b000011: begin
        result = dataa >>> datab;
        overflow = 1'b0;
        end
    6'b000010: begin
        result= dataa >> datab;
        overflow = 1'b0;
        end          
    6'b100111: begin
        result = ~(dataa | datab);
        overflow = 1'b0;
        end        
    default:   {overflow, result} = {{1'b0}, {WIDTH{1'b0}}};
endcase
zero = ~|result;
end
endmodule
