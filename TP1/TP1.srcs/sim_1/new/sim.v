
module sim;

    // Parameters
    localparam WIDTH = 8;

    // DUT inputs
    reg [WIDTH-1:0] dataa, datab;
    reg [5:0] opcode;

    // DUT outputs
    wire [WIDTH-1:0] result;
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

    // Task for checking results
    task check;
        input [WIDTH-1:0] exp_result;
        input exp_zero;
        input exp_carry;
        input [127:0] msg;
        begin
            #1; // small delay to settle
            if (result === exp_result && zero === exp_zero && carry === exp_carry) begin
                $display("PASS: %s | result=%h zero=%b carry=%b", msg, result, zero, carry);
            end else begin
                $display("FAIL: %s | got result=%h zero=%b carry=%b, expected result=%h zero=%b carry=%b",
                    msg, result, zero, carry, exp_result, exp_zero, exp_carry);
            end
        end
    endtask

    initial begin
        $display("Starting ALU testbench...");

        // ADD
        dataa = 8'd3; datab = 8'd5; opcode = 6'b100000;
        check(8'd8, 0, 0, "ADD 3+5");

        dataa = 8'd255; datab = 8'd1; opcode = 6'b100000;
        check(8'd0, 1, 1, "ADD 255+1 overflow");

        // SUB
        dataa = 8'd7; datab = 8'd2; opcode = 6'b100010;
        check(8'd5, 0, 0, "SUB 7-2");

        dataa = 8'd2; datab = 8'd5; opcode = 6'b100010;
        check(8'hFD, 0, 1, "SUB 2-5 underflow"); // carry=1 meaning borrow

        // AND
        dataa = 8'b10101010; datab = 8'b11110000; opcode = 6'b100100;
        check(8'b10100000, 0, 0, "AND test");

        // OR
        dataa = 8'b00001111; datab = 8'b11110000; opcode = 6'b100101;
        check(8'b11111111, 0, 0, "OR test");

        // XOR
        dataa = 8'b1100; datab = 8'b1100; opcode = 6'b100110;
        check(8'b0000, 1, 0, "XOR identical inputs");

        // NOR
        dataa = 8'b11110000; datab = 8'b00001111; opcode = 6'b100111;
        check(8'b00000000, 1, 0, "NOR test");

        // SRL
        dataa = 8'b10000000; datab = 8'd1; opcode = 6'b000010;
        check(8'b01000000, 0, 0, "SRL shift right");

        dataa = 8'b00000001; datab = 8'd8; opcode = 6'b000010;
        check(8'b00000000, 1, 0, "SRL full shift");

        // SRA (signed right shift)
        dataa = 8'b10000000; datab = 8'd1; opcode = 6'b000011;
        check(8'b11000000, 0, 0, "SRA negative extend");

        dataa = 8'b01111111; datab = 8'd1; opcode = 6'b000011;
        check(8'b00111111, 0, 0, "SRA positive extend");

        // Invalid opcode
        dataa = 8'd55; datab = 8'd99; opcode = 6'b000000;
        check(8'b00000000, 1, 0, "Invalid opcode default to 0");

        $display("All tests finished.");
        $stop;
    end
endmodule