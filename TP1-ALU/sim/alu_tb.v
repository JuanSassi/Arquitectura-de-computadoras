`timescale 1ns / 1ps

// Testbench autochequeable para la ALU.
// - Genera entradas aleatorias para A, B y Op.
// - Calcula el resultado esperado con un modelo de referencia en Verilog.
// - Compara automaticamente contra la salida del DUT y reporta errores.
module alu_tb;

    localparam integer N          = 16;
    localparam integer NUM_RANDOM = 2000;

    reg  [N-1:0] a, b;
    reg  [5:0]   op;
    wire [N-1:0] result;
    wire         zero, overflow;

    integer errors = 0;
    integer i;

    alu #(.N(N)) dut (
        .a        (a),
        .b        (b),
        .op       (op),
        .result   (result),
        .zero     (zero),
        .overflow (overflow)
    );

    // ---- Lista de codigos de operacion validos (tabla del TP1) ----
    reg [5:0] op_list [0:7];
    initial begin
        op_list[0] = 6'b100000; // ADD
        op_list[1] = 6'b100010; // SUB
        op_list[2] = 6'b100100; // AND
        op_list[3] = 6'b100101; // OR
        op_list[4] = 6'b100110; // XOR
        op_list[5] = 6'b100111; // NOR
        op_list[6] = 6'b000010; // SRL
        op_list[7] = 6'b000011; // SRA
    end

    // ---- Modelo de referencia (comportamental, independiente del DUT) ----
    function [N-1:0] model_result;
        input [N-1:0] a_i;
        input [N-1:0] b_i;
        input [5:0]   op_i;
        begin
            case (op_i)
                6'b100000: model_result = a_i + b_i;
                6'b100010: model_result = a_i - b_i;
                6'b100100: model_result = a_i & b_i;
                6'b100101: model_result = a_i | b_i;
                6'b100110: model_result = a_i ^ b_i;
                6'b100111: model_result = ~(a_i | b_i);
                6'b000010: model_result = b_i >> a_i[3:0];
                6'b000011: model_result = $signed(b_i) >>> a_i[3:0];
                default:   model_result = {N{1'b0}};
            endcase
        end
    endfunction

    task automatic check_one(input [N-1:0] a_i, input [N-1:0] b_i, input [5:0] op_i);
        reg [N-1:0] expected;
        begin
            a  = a_i;
            b  = b_i;
            op = op_i;
            #10;
            expected = model_result(a_i, b_i, op_i);
            if (result !== expected) begin
                errors = errors + 1;
                $display("ERROR t=%0t op=%b a=%0d b=%0d -> result=%0d (esperado=%0d)",
                          $time, op_i, a_i, b_i, result, expected);
            end
        end
    endtask

    initial begin
        // ---- Casos dirigidos: overflow, bordes de shift, ceros ----
        check_one(16'h7FFF, 16'h0001, 6'b100000); // ADD -> overflow positivo
        check_one(16'h8000, 16'hFFFF, 6'b100010); // SUB -> overflow negativo
        check_one(16'h0000, 16'h0000, 6'b100000); // ADD 0+0 -> zero flag
        check_one(16'hFFFF, 16'h0001, 6'b100000); // ADD con acarreo
        check_one(16'h8000, 16'h0004, 6'b000011); // SRA con signo negativo
        check_one(16'hFFFF, 16'hFFFF, 6'b100111); // NOR

        // ---- Estimulos aleatorios ----
        for (i = 0; i < NUM_RANDOM; i = i + 1) begin
            check_one($random, $random, op_list[$unsigned($random) % 8]);
        end

        if (errors == 0)
            $display("TESTBENCH PASO: %0d vectores (dirigidos + aleatorios), 0 errores.", NUM_RANDOM + 6);
        else
            $display("TESTBENCH FALLO: %0d errores en %0d vectores.", errors, NUM_RANDOM + 6);

        $finish;
    end

endmodule
