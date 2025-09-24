module sim;

    localparam WIDTH = 8;

    // DUT inputs
    reg signed [WIDTH-1:0] dataa, datab;
    reg [5:0] opcode;

    // DUT outputs
    wire signed [WIDTH-1:0] result;
    wire zero, carry;

    // Instantiate ALU
    alu #(.WIDTH(WIDTH)) dut (
        .dataa(dataa),
        .datab(datab),
        .opcode(opcode),
        .result(result),
        .zero(zero),
        .carry(carry)
    );

    // Task to check results
    task check;
        input signed [WIDTH-1:0] exp_result;
        input exp_zero;
        input exp_carry;
        input [127:0] msg;
        begin
            #1;
            if (result === exp_result && zero === exp_zero && carry === exp_carry) begin
                $display("PASS: %s | result=%0d (0x%h) zero=%b carry=%b", 
                         msg, result, result, zero, carry);
            end else begin
                $display("FAIL: %s | got result=%0d (0x%h) zero=%b carry=%b, expected %0d (0x%h) zero=%b carry=%b",
                         msg, result, result, zero, carry, exp_result, exp_result, exp_zero, exp_carry);
            end
        end
    endtask

    initial begin
        $display("=== Starting signed ALU testbench ===");

        // ---------- ADD ----------
        dataa = 8'sd3; datab = 8'sd5; opcode = 6'b100000;
        check(8'sd8, 0, 0, "ADD 3 + 5");

        dataa = 8'sd100; datab = 8'sd30; opcode = 6'b100000;
        check(-126, 0, 0, "ADD overflow 100 + 30 = -126");

        dataa = -8'sd100; datab = -8'sd50; opcode = 6'b100000;
        check(106, 0, 1, "ADD negative overflow -100 + -50");

        // ---------- SUB ----------
        dataa = 8'sd7; datab = 8'sd2; opcode = 6'b100010;
        check(8'sd5, 0, 0, "SUB 7 - 2");

        dataa = 8'sd2; datab = 8'sd5; opcode = 6'b100010;
        check(-3, 0, 1, "SUB 2 - 5 = -3 (borrow)");

        dataa = -8'sd128; datab = 8'sd1; opcode = 6'b100010;
        check(127, 0, 1, "SUB underflow -128 - 1 wraps to 127");

        // ---------- AND ----------
        dataa = 8'b10101010; datab = 8'b11110000; opcode = 6'b100100;
        check(8'b10100000, 0, 0, "AND test");

        // ---------- OR ----------
        dataa = 8'b00001111; datab = 8'b11110000; opcode = 6'b100101;
        check(8'b11111111, 0, 0, "OR test");

        // ---------- XOR ----------
        dataa = 8'b1100; datab = 8'b1100; opcode = 6'b100110;
        check(8'b0000, 1, 0, "XOR identical -> zero");

        dataa = 8'b11110000; datab = 8'b00001111; opcode = 6'b100110;
        check(8'b11111111, 0, 0, "XOR complementary");

        // ---------- NOR ----------
        dataa = 8'b11110000; datab = 8'b00001111; opcode = 6'b100111;
        check(8'b00000000, 1, 0, "NOR -> zero");

        dataa = 8'b00000000; datab = 8'b00000000; opcode = 6'b100111;
        check(8'b11111111, 0, 0, "NOR of 0s");

        // ---------- Logical Shift Right ----------
        dataa = 8'b10000000; datab = 8'd1; opcode = 6'b000010;
        check(8'b01000000, 0, 0, "SRL 0x80 >> 1");

        dataa = 8'b00000001; datab = 8'd8; opcode = 6'b000010;
        check(8'b00000000, 1, 0, "SRL full shift -> 0");

        // ---------- Arithmetic Shift Right ----------
        dataa = -8'sd128; datab = 8'd1; opcode = 6'b000011;
        check(-64, 0, 0, "SRA -128 >>> 1 -> -64");

        dataa = 8'sd127; datab = 8'd1; opcode = 6'b000011;
        check(63, 0, 0, "SRA 127 >>> 1 -> 63");

        dataa = -8'sd1; datab = 8'd3; opcode = 6'b000011;
        check(-1, 0, 0, "SRA -1 >>> 3 stays -1 (sign extend)");

        // ---------- Default case ----------
        dataa = 8'sd55; datab = 8'sd99; opcode = 6'b000000;
        check(8'sd0, 1, 0, "Invalid opcode -> zero");

        $display("=== All tests finished ===");
        $stop;
    end
endmodule
