`timescale 1ns / 1ps

// Modulo 7 - Top level (Basys3): UART + interface + ALU.
//
//   rx  --> uart_rx --> uart_interface --> alu_uart_ctrl (ALU)
//   tx  <-- uart_tx <-- uart_interface <--      "
//                ^ s_tick
//        baud_rate_gen
//
// Pines (USB-UART de la Basys3): rx = B18 (RsRx), tx = A18 (RsTx).
// LEDs: led[7:0]  ultimo resultado de la ALU
//       led[13]   hay bytes pendientes en la FIFO rx
//       led[14]   FIFO tx llena
//       led[15]   error de frame (stop bit invalido) - se limpia con reset
// btnC = reset.
module uart_alu_top #(
    parameter integer CLK_FREQ    = 100_000_000,
    parameter integer BAUD_RATE   = 19_200,
    parameter integer DBIT        = 8,
    parameter integer SB_TICK     = 16,
    parameter integer FIFO_ADDR_W = 4
)(
    input  wire        clk,
    input  wire        btnC,
    input  wire        rx,
    output wire        tx,
    output wire [15:0] led
);

    // ---- Reset: boton sincronizado (arranca en 1 => reset al energizar) ----
    reg [1:0] rst_sync = 2'b11;
    always @(posedge clk) rst_sync <= {rst_sync[0], btnC};
    wire reset = rst_sync[1];

    // ---- Senales entre modulos ----
    wire            s_tick;
    wire            rx_done_tick, frame_err;
    wire [DBIT-1:0] rx_dout;
    wire            tx_start, tx_done_tick;
    wire [DBIT-1:0] tx_din;
    wire            rd, rx_empty, rx_full, wr, tx_full;
    wire [DBIT-1:0] r_data, w_data, result;
    wire [2:0]      state_dbg;

    baud_rate_gen #(.CLK_FREQ(CLK_FREQ), .BAUD_RATE(BAUD_RATE)) baud_gen (
        .clk(clk), .reset(reset), .tick(s_tick)
    );

    uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) u_rx (
        .clk(clk), .reset(reset), .rx(rx), .s_tick(s_tick),
        .rx_done_tick(rx_done_tick), .frame_err(frame_err), .dout(rx_dout)
    );

    uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) u_tx (
        .clk(clk), .reset(reset), .tx_start(tx_start), .s_tick(s_tick),
        .din(tx_din), .tx_done_tick(tx_done_tick), .tx(tx)
    );

    uart_interface #(.DBIT(DBIT), .ADDR_W(FIFO_ADDR_W)) intf (
        .clk(clk), .reset(reset),
        .rx_done_tick(rx_done_tick), .rx_dout(rx_dout),
        .tx_done_tick(tx_done_tick), .tx_start(tx_start), .tx_din(tx_din),
        .rd(rd), .r_data(r_data), .rx_empty(rx_empty), .rx_full(rx_full),
        .wr(wr), .w_data(w_data), .tx_full(tx_full)
    );

    alu_uart_ctrl #(.N(DBIT)) alu_blk (
        .clk(clk), .reset(reset),
        .rx_empty(rx_empty), .r_data(r_data), .rd(rd),
        .tx_full(tx_full), .w_data(w_data), .wr(wr),
        .result(result), .state_dbg(state_dbg)
    );

    // ---- Indicadores ----
    reg ferr_sticky = 1'b0;
    always @(posedge clk) begin
        if (reset)          ferr_sticky <= 1'b0;
        else if (frame_err) ferr_sticky <= 1'b1;
    end

    assign led[DBIT-1:0] = result;
    generate
        if (DBIT < 13) begin : g_led_pad
            assign led[12:DBIT] = {(13-DBIT){1'b0}};
        end
    endgenerate
    assign led[13] = ~rx_empty;
    assign led[14] = tx_full;
    assign led[15] = ferr_sticky;

    wire _unused = rx_full | (^state_dbg);

endmodule
