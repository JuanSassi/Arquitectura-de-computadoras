`timescale 1ns / 1ps

// Modulo 4 - FIFO sincronica (buffer entre la UART y la ALU).
//
// El Rx entrega bytes a la velocidad del cable y la ALU los consume a la del
// reloj: la FIFO desacopla ambos lados.
//
//   * Lectura "first-word fall-through": r_data siempre muestra el dato mas
//     viejo; si empty = 0 ese dato es valido y rd lo descarta en el flanco.
//   * Protegida: wr con full y rd con empty se ignoran (no corrompen punteros).
//   * Si wr y rd ocurren en el mismo ciclo y hay lugar/datos, hace ambos.
module sync_fifo #(
    parameter integer DATA_W = 8,
    parameter integer ADDR_W = 4            // profundidad = 2**ADDR_W
)(
    input  wire              clk,
    input  wire              reset,
    input  wire              wr,
    input  wire [DATA_W-1:0] w_data,
    input  wire              rd,
    output wire [DATA_W-1:0] r_data,
    output wire              empty,
    output wire              full
);

    localparam integer DEPTH = (1 << ADDR_W);

    reg [DATA_W-1:0] mem [0:DEPTH-1];
    reg [ADDR_W-1:0] w_ptr = {ADDR_W{1'b0}};
    reg [ADDR_W-1:0] r_ptr = {ADDR_W{1'b0}};
    reg [ADDR_W:0]   count = {(ADDR_W+1){1'b0}};      // cantidad de datos guardados

    assign empty = (count == 0);
    assign full  = (count == DEPTH);

    wire do_wr = wr & ~full;
    wire do_rd = rd & ~empty;

    always @(posedge clk) begin
        if (do_wr) mem[w_ptr] <= w_data;
    end

    always @(posedge clk) begin
        if (reset) begin
            w_ptr <= {ADDR_W{1'b0}};
            r_ptr <= {ADDR_W{1'b0}};
            count <= {(ADDR_W+1){1'b0}};
        end else begin
            if (do_wr) w_ptr <= w_ptr + 1'b1;
            if (do_rd) r_ptr <= r_ptr + 1'b1;
            case ({do_wr, do_rd})
                2'b10:   count <= count + 1'b1;
                2'b01:   count <= count - 1'b1;
                default: count <= count;
            endcase
        end
    end

    assign r_data = mem[r_ptr];

endmodule
