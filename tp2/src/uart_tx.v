`timescale 1ns / 1ps

// Modulo 3 - Transmisor UART (FSM idle -> start -> data -> stop).
//
//   idle  : tx = 1. Cuando hay tx_start, en el proximo s_tick captura din y
//           baja tx (bit de start).
//   start : mantiene tx = 0 durante 16 ticks.
//   data  : cada 16 ticks saca el siguiente bit (LSB primero).
//   stop  : tx = 1 durante SB_TICK ticks; al final levanta tx_done_tick.
//
// Detalles de diseno:
//   * Todos los cambios de tx ocurren en un s_tick, por lo que cada bit dura
//     exactamente 16 ticks (no hay jitter de fase como si arrancara en cualquier ciclo).
//   * tx es la salida de un registro (sin glitches).
//   * tx_done_tick es combinacional y coincide con el ciclo en que la FSM vuelve
//     a idle: la FIFO del interface saca el dato en ese mismo flanco, de modo que
//     en idle tx_start ya refleja la FIFO actualizada (si no, se re-enviaria el
//     mismo byte dos veces).
module uart_tx #(
    parameter integer DBIT    = 8,
    parameter integer SB_TICK = 16
)(
    input  wire            clk,
    input  wire            reset,         // sincronico, activo en alto
    input  wire            tx_start,      // nivel: hay un dato para enviar en din
    input  wire            s_tick,        // tick x16 del baud_rate_gen
    input  wire [DBIT-1:0] din,           // dato a enviar (debe estar estable mientras tx_start)
    output wire            tx_done_tick,  // 1 ciclo: termino el stop bit, ya se puede pasar al siguiente
    output wire            tx             // linea serie
);

    localparam [1:0] ST_IDLE  = 2'b00,
                     ST_START = 2'b01,
                     ST_DATA  = 2'b10,
                     ST_STOP  = 2'b11;

    reg [1:0]      state_reg, state_next;
    reg [4:0]      s_reg,     s_next;
    reg [3:0]      n_reg,     n_next;
    reg [DBIT-1:0] b_reg,     b_next;      // shift register: b_reg[0] = bit actual
    reg            tx_reg = 1'b1, tx_next;

    always @(posedge clk) begin
        if (reset) begin
            state_reg <= ST_IDLE;
            s_reg     <= 5'd0;
            n_reg     <= 4'd0;
            b_reg     <= {DBIT{1'b0}};
            tx_reg    <= 1'b1;
        end else begin
            state_reg <= state_next;
            s_reg     <= s_next;
            n_reg     <= n_next;
            b_reg     <= b_next;
            tx_reg    <= tx_next;
        end
    end

    always @* begin
        state_next = state_reg;
        s_next     = s_reg;
        n_next     = n_reg;
        b_next     = b_reg;
        tx_next    = tx_reg;

        case (state_reg)
            ST_IDLE: begin
                tx_next = 1'b1;
                if (tx_start && s_tick) begin
                    state_next = ST_START;
                    s_next     = 5'd0;
                    b_next     = din;
                    tx_next    = 1'b0;                     // arranca el bit de start
                end
            end

            ST_START: begin
                if (s_tick) begin
                    if (s_reg == 5'd15) begin
                        state_next = ST_DATA;
                        s_next     = 5'd0;
                        n_next     = 4'd0;
                        tx_next    = b_reg[0];             // primer bit de dato
                    end else begin
                        s_next = s_reg + 1'b1;
                    end
                end
            end

            ST_DATA: begin
                if (s_tick) begin
                    if (s_reg == 5'd15) begin
                        s_next = 5'd0;
                        b_next = {1'b0, b_reg[DBIT-1:1]};  // corre al proximo bit
                        if (n_reg == DBIT - 1) begin
                            state_next = ST_STOP;
                            tx_next    = 1'b1;             // bit de stop
                        end else begin
                            n_next  = n_reg + 1'b1;
                            tx_next = b_reg[1];
                        end
                    end else begin
                        s_next = s_reg + 1'b1;
                    end
                end
            end

            ST_STOP: begin
                tx_next = 1'b1;
                if (s_tick) begin
                    if (s_reg == SB_TICK - 1) state_next = ST_IDLE;
                    else                      s_next     = s_reg + 1'b1;
                end
            end

            default: state_next = ST_IDLE;                 // recuperacion de falla
        endcase
    end

    assign tx_done_tick = (state_reg == ST_STOP) && s_tick && (s_reg == SB_TICK - 1);
    assign tx           = tx_reg;

endmodule
