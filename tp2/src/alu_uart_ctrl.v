`timescale 1ns / 1ps

// Modulo 6 - Bloque "ALU" de la filmina: controlador + ALU del TP1.
//
// Habla con el interface con las senales rd/r_data/rx_empty y wr/w_data/tx_full.
// Protocolo (3 bytes de entrada, 1 byte de salida):
//
//      PC -> FPGA :  [A] [B] [OP]          OP[5:0] = codigo de la ALU del TP1
//      FPGA -> PC :  [RESULTADO]           RESULTADO = A (op) B
//
// El orden A, B, Op es el mismo con que se cargaban los registros en el TP1
// (Reg A, Reg B, Reg Op): el operador llega ultimo y "dispara" el calculo.
//
// FSM:  A -> B -> OP -> CALC -> SEND -> A ...
//   A/B/OP : esperan !rx_empty, capturan r_data en su registro y pulsan rd.
//   CALC   : la ALU (combinacional) ya tiene sus 3 entradas estables; se
//            registra el resultado.
//   SEND   : espera !tx_full y pulsa wr con w_data = resultado.
module alu_uart_ctrl #(
    parameter integer N = 8              // ancho de datos de la ALU (= DBIT de la UART)
)(
    input  wire         clk,
    input  wire         reset,

    // ---- hacia uart_interface (lado Rx) ----
    input  wire         rx_empty,
    input  wire [N-1:0] r_data,
    output reg          rd,

    // ---- hacia uart_interface (lado Tx) ----
    input  wire         tx_full,
    output wire [N-1:0] w_data,
    output reg          wr,

    // ---- visibilidad (LEDs / debug) ----
    output wire [N-1:0] result,          // ultimo resultado calculado
    output wire [2:0]   state_dbg
);

    localparam [2:0] ST_A    = 3'd0,
                     ST_B    = 3'd1,
                     ST_OP   = 3'd2,
                     ST_CALC = 3'd3,
                     ST_SEND = 3'd4;

    reg [2:0]   state_reg, state_next;
    reg [5:0]   op_reg;
    reg [N-1:0] a_reg, b_reg, res_reg;

    wire [N-1:0] alu_result;
    wire         alu_zero, alu_overflow;

    alu #(.N(N)) alu_inst (
        .a        (a_reg),
        .b        (b_reg),
        .op       (op_reg),
        .result   (alu_result),
        .zero     (alu_zero),
        .overflow (alu_overflow)
    );

    // ---- Registro de estado y de datos ----
    always @(posedge clk) begin
        if (reset) begin
            state_reg <= ST_A;
            op_reg    <= 6'd0;
            a_reg     <= {N{1'b0}};
            b_reg     <= {N{1'b0}};
            res_reg   <= {N{1'b0}};
        end else begin
            state_reg <= state_next;
            if (rd) begin
                case (state_reg)
                    ST_A:    a_reg  <= r_data;
                    ST_B:    b_reg  <= r_data;
                    ST_OP:   op_reg <= r_data[5:0];
                    default: ;
                endcase
            end
            if (state_reg == ST_CALC) res_reg <= alu_result;
        end
    end

    // ---- Proximo estado y salidas (rd/wr dependen de la entrada: tipo Mealy) ----
    always @* begin
        state_next = state_reg;
        rd         = 1'b0;
        wr         = 1'b0;

        case (state_reg)
            ST_A, ST_B, ST_OP: begin
                if (!rx_empty) begin
                    rd = 1'b1;
                    state_next = (state_reg == ST_A)  ? ST_B :
                                 (state_reg == ST_B)  ? ST_OP : ST_CALC;
                end
            end
            ST_CALC: state_next = ST_SEND;
            ST_SEND: begin
                if (!tx_full) begin
                    wr = 1'b1;
                    state_next = ST_A;
                end
            end
            default: state_next = ST_A;                   // recuperacion de falla
        endcase
    end

    assign w_data    = res_reg;
    assign result    = res_reg;
    assign state_dbg = state_reg;

    wire _unused = alu_zero | alu_overflow;

endmodule
