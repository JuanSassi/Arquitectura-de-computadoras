`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 01:34:35 PM
// Design Name: 
// Module Name: top
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


module top (
    input  wire clk,             // FPGA clock
    input  wire reset,           // global reset (button)
    input  wire enA, enB, enOp,  // enable signals for registers (buttons)
    input  wire signed [7:0] sw,  // switch inputs (reused for A, B, or Op loading)
    output wire signed [7:0] led,      // show ALU result
    output wire zero_led,        // zero flag
    output wire overflow_led       // overflow flag
);

    // Internal wires
    wire signed [7:0] A, B;
    wire [5:0] Op;
    wire signed [7:0] Result;
    wire Zero, Carry;

    // Register for A (8 bits)
    register #(.WIDTH(8)) A_reg (
        .clk(clk),
        .reset(reset),
        .enable(enA),
        .databus(sw),
        .savedvalue(A)
    );

    // Register for B (8 bits)
    register #(.WIDTH(8)) B_reg (
        .clk(clk),
        .reset(reset),
        .enable(enB),
        .databus(sw),
        .savedvalue(B)
    );

    // Register for Op (6 bits)
    register #(.WIDTH(6)) Op_reg (
        .clk(clk),
        .reset(reset),
        .enable(enOp),
        .databus(sw[5:0]),
        .savedvalue(Op)
    );

    // ALU
    alu #(.WIDTH(8)) alu0 (
        .dataa(A),
        .datab(B),
        .opcode(Op),
        .result(Result),
        .zero(Zero),
        .overflow(overflow)
    );

    assign led     = Result;
    assign zero_led = Zero;
    assign overflow_led = overflow;


endmodule

