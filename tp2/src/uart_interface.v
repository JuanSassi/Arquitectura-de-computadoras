`timescale 1ns / 1ps

// Modulo 5 - Interface Circuit (bloque entre la UART y la ALU de la filmina).
//
// Lado UART (hacia/desde Rx y Tx)        Lado ALU
//   rx_done_tick, rx_dout  ---> [FIFO rx] ---> r_data, rx_empty   (la ALU hace rd)
//   tx_start, tx_din       <--- [FIFO tx] <--- w_data, tx_full    (la ALU hace wr)
//   tx_done_tick           --->  (saca el dato ya enviado de la FIFO tx)
//
// Rx: cada byte que termina de recibirse (rx_done_tick) se guarda en la FIFO rx.
//     La ALU ve rx_empty = 0 cuando hay algo; lee r_data y confirma con rd.
// Tx: la ALU escribe con wr/w_data. Mientras la FIFO tx no este vacia,
//     tx_start = 1 y tx_din = dato mas viejo; cuando el Tx termina (tx_done_tick)
//     ese dato se descarta y se pasa al siguiente.
module uart_interface #(
    parameter integer DBIT   = 8,
    parameter integer ADDR_W = 4
)(
    input  wire            clk,
    input  wire            reset,

    // ---- Lado UART: Rx ----
    input  wire            rx_done_tick,
    input  wire [DBIT-1:0] rx_dout,

    // ---- Lado UART: Tx ----
    input  wire            tx_done_tick,
    output wire            tx_start,
    output wire [DBIT-1:0] tx_din,

    // ---- Lado ALU ----
    input  wire            rd,           // la ALU consume r_data
    output wire [DBIT-1:0] r_data,
    output wire            rx_empty,
    output wire            rx_full,      // extra: util para detectar desborde
    input  wire            wr,           // la ALU escribe w_data
    input  wire [DBIT-1:0] w_data,
    output wire            tx_full
);

    wire tx_empty;

    sync_fifo #(.DATA_W(DBIT), .ADDR_W(ADDR_W)) fifo_rx (
        .clk(clk), .reset(reset),
        .wr(rx_done_tick), .w_data(rx_dout),
        .rd(rd),           .r_data(r_data),
        .empty(rx_empty),  .full(rx_full)
    );

    sync_fifo #(.DATA_W(DBIT), .ADDR_W(ADDR_W)) fifo_tx (
        .clk(clk), .reset(reset),
        .wr(wr),           .w_data(w_data),
        .rd(tx_done_tick), .r_data(tx_din),
        .empty(tx_empty),  .full(tx_full)
    );

    assign tx_start = ~tx_empty;

endmodule
