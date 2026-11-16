`timescale 1ns / 1ps

// ALU parametrizable en ancho de datos (N bits).
// Codigos de operacion (Op) tomados de la tabla del TP1 (funct de MIPS):
//   ADD 100000   SUB 100010   AND 100100   OR  100101
//   XOR 100110   NOR 100111   SRL 000010   SRA 000011
//
// SRL/SRA desplazan el dato B una cantidad de bits igual al valor
// contenido en los log2(N) bits menos significativos del dato A.
module alu #(
    parameter integer N = 16
)(
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    input  wire [5:0]   op,
    output reg  [N-1:0] result,
    output wire          zero,
    output reg           overflow
);

    localparam integer SH = (N <= 2) ? 1 : $clog2(N);

    localparam [5:0]
        OP_ADD = 6'b100000,
        OP_SUB = 6'b100010,
        OP_AND = 6'b100100,
        OP_OR  = 6'b100101,
        OP_XOR = 6'b100110,
        OP_NOR = 6'b100111,
        OP_SRL = 6'b000010,
        OP_SRA = 6'b000011;

    // Suma/resta con un bit extra para poder detectar overflow con signo
    wire signed [N:0] a_ext   = {a[N-1], a};
    wire signed [N:0] b_ext   = {b[N-1], b};
    wire signed [N:0] sum_ext = a_ext + b_ext;
    wire signed [N:0] sub_ext = a_ext - b_ext;

    always @(*) begin
        overflow = 1'b0;
        case (op)
            OP_ADD: begin
                result   = sum_ext[N-1:0];
                overflow = sum_ext[N] ^ sum_ext[N-1];
            end
            OP_SUB: begin
                result   = sub_ext[N-1:0];
                overflow = sub_ext[N] ^ sub_ext[N-1];
            end
            OP_AND:  result = a & b;
            OP_OR:   result = a | b;
            OP_XOR:  result = a ^ b;
            OP_NOR:  result = ~(a | b);
            OP_SRL:  result = b >> a[SH-1:0];
            OP_SRA:  result = $signed(b) >>> a[SH-1:0];
            default: result = {N{1'b0}};
        endcase
    end

    assign zero = (result == {N{1'b0}});

endmodule
