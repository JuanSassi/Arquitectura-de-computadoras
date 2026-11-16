`timescale 1ns / 1ps

// Top level para la placa Basys3.
//
// Como solo hay 16 switches y necesitamos cargar A, B y Op (segun el
// diagrama del TP), los switches se usan como un unico bus de datos
// que se "reparte" entre tres registros (Reg A, Reg B, Reg Op) usando
// tres botones como pulso de carga (btnL -> A, btnR -> B, btnU -> Op).
// btnC actua como reset sincrono.
//
// Flujo de uso en la placa:
//   1) Poner el valor de A en sw[N-1:0] y presionar btnL.
//   2) Poner el valor de B en sw[N-1:0] y presionar btnR.
//   3) Poner el codigo de operacion en sw[5:0] y presionar btnU.
//   4) El resultado S = A op B se muestra en los leds[N-1:0].
module alu_basys3_top #(
    parameter integer N = 16
)(
    input  wire        clk,     // W5, 100 MHz
    input  wire [15:0] sw,
    input  wire        btnC,    // reset
    input  wire        btnU,    // carga Op
    input  wire        btnL,    // carga A
    input  wire        btnR,    // carga B
    output wire [15:0] led
);

    // ---- Antirrebote de los 4 botones usados ----
    wire btnC_clean, btnU_clean, btnL_clean, btnR_clean;

    debounce db_c (.clk(clk), .btn_in(btnC), .btn_clean(btnC_clean));
    debounce db_u (.clk(clk), .btn_in(btnU), .btn_clean(btnU_clean));
    debounce db_l (.clk(clk), .btn_in(btnL), .btn_clean(btnL_clean));
    debounce db_r (.clk(clk), .btn_in(btnR), .btn_clean(btnR_clean));

    // ---- Deteccion de flanco: un pulso de carga por cada apretada ----
    reg btnU_d = 1'b0, btnL_d = 1'b0, btnR_d = 1'b0;
    always @(posedge clk) begin
        btnU_d <= btnU_clean;
        btnL_d <= btnL_clean;
        btnR_d <= btnR_clean;
    end

    wire load_op = btnU_clean & ~btnU_d;
    wire load_a  = btnL_clean & ~btnL_d;
    wire load_b  = btnR_clean & ~btnR_d;
    wire rst     = btnC_clean;

    // ---- Registros de entrada de la ALU ----
    reg [N-1:0] reg_a  = {N{1'b0}};
    reg [N-1:0] reg_b  = {N{1'b0}};
    reg [5:0]   reg_op = 6'b100000; // ADD por defecto

    always @(posedge clk) begin
        if (rst) begin
            reg_a  <= {N{1'b0}};
            reg_b  <= {N{1'b0}};
            reg_op <= 6'b100000;
        end else begin
            if (load_a)  reg_a  <= sw[N-1:0];
            if (load_b)  reg_b  <= sw[N-1:0];
            if (load_op) reg_op <= sw[5:0];
        end
    end

    // ---- ALU combinacional ----
    wire [N-1:0] alu_result;
    wire         alu_zero, alu_overflow;

    alu #(.N(N)) alu_inst (
        .a        (reg_a),
        .b        (reg_b),
        .op       (reg_op),
        .result   (alu_result),
        .zero     (alu_zero),
        .overflow (alu_overflow)
    );

    // ---- Registro de salida: da un camino sincronico claro
    //      (registro -> combinacional -> registro) para que el
    //      analisis de timing de Vivado tenga sentido. ----
    reg [N-1:0] result_reg = {N{1'b0}};
    always @(posedge clk) begin
        if (rst) result_reg <= {N{1'b0}};
        else     result_reg <= alu_result;
    end

    assign led[N-1:0] = result_reg;

    generate
        if (N < 16) begin : g_pad
            // Bits de led sin uso apagados (las banderas zero/overflow
            // quedan disponibles como senales internas para simulacion).
            assign led[15:N] = {(16-N){1'b0}};
        end
    endgenerate

    // Evita warnings de "señal sin usar" cuando N = 16 (no sobran leds).
    wire _unused_flags = alu_zero | alu_overflow;

endmodule
