// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Wed Sep 24 09:29:43 2025
// Host        : DESKTOP-KPIS19S running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file C:/TP1/TP1.sim/sim_1/synth/func/xsim/sim_func_synth.v
// Design      : top
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module alu
   (\savedvalue_reg[3] ,
    \savedvalue_reg[6] ,
    \savedvalue_reg[6]_0 ,
    O,
    \savedvalue_reg[7] ,
    \savedvalue_reg[7]_0 ,
    \led_OBUF[4]_inst_i_3 ,
    S,
    DI,
    \led_OBUF[4]_inst_i_3_0 ,
    \led_OBUF[0]_inst_i_4 ,
    Q,
    \led_OBUF[4]_inst_i_2 );
  output [3:0]\savedvalue_reg[3] ;
  output [0:0]\savedvalue_reg[6] ;
  output [3:0]\savedvalue_reg[6]_0 ;
  output [3:0]O;
  output [0:0]\savedvalue_reg[7] ;
  output [3:0]\savedvalue_reg[7]_0 ;
  input [6:0]\led_OBUF[4]_inst_i_3 ;
  input [3:0]S;
  input [0:0]DI;
  input [3:0]\led_OBUF[4]_inst_i_3_0 ;
  input [3:0]\led_OBUF[0]_inst_i_4 ;
  input [0:0]Q;
  input [3:0]\led_OBUF[4]_inst_i_2 ;

  wire [0:0]DI;
  wire [3:0]O;
  wire [0:0]Q;
  wire [3:0]S;
  wire [3:0]\led_OBUF[0]_inst_i_4 ;
  wire [3:0]\led_OBUF[4]_inst_i_2 ;
  wire [6:0]\led_OBUF[4]_inst_i_3 ;
  wire [3:0]\led_OBUF[4]_inst_i_3_0 ;
  wire result0_carry__0_n_1;
  wire result0_carry__0_n_2;
  wire result0_carry__0_n_3;
  wire result0_carry_n_0;
  wire result0_carry_n_1;
  wire result0_carry_n_2;
  wire result0_carry_n_3;
  wire \result0_inferred__0/i__carry__0_n_1 ;
  wire \result0_inferred__0/i__carry__0_n_2 ;
  wire \result0_inferred__0/i__carry__0_n_3 ;
  wire \result0_inferred__0/i__carry_n_0 ;
  wire \result0_inferred__0/i__carry_n_1 ;
  wire \result0_inferred__0/i__carry_n_2 ;
  wire \result0_inferred__0/i__carry_n_3 ;
  wire [3:0]\savedvalue_reg[3] ;
  wire [0:0]\savedvalue_reg[6] ;
  wire [3:0]\savedvalue_reg[6]_0 ;
  wire [0:0]\savedvalue_reg[7] ;
  wire [3:0]\savedvalue_reg[7]_0 ;

  CARRY4 result0_carry
       (.CI(1'b0),
        .CO({result0_carry_n_0,result0_carry_n_1,result0_carry_n_2,result0_carry_n_3}),
        .CYINIT(1'b0),
        .DI(\led_OBUF[4]_inst_i_3 [3:0]),
        .O(\savedvalue_reg[3] ),
        .S(S));
  CARRY4 result0_carry__0
       (.CI(result0_carry_n_0),
        .CO({\savedvalue_reg[6] ,result0_carry__0_n_1,result0_carry__0_n_2,result0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({DI,\led_OBUF[4]_inst_i_3 [6:4]}),
        .O(\savedvalue_reg[6]_0 ),
        .S(\led_OBUF[4]_inst_i_3_0 ));
  CARRY4 \result0_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\result0_inferred__0/i__carry_n_0 ,\result0_inferred__0/i__carry_n_1 ,\result0_inferred__0/i__carry_n_2 ,\result0_inferred__0/i__carry_n_3 }),
        .CYINIT(1'b1),
        .DI(\led_OBUF[4]_inst_i_3 [3:0]),
        .O(O),
        .S(\led_OBUF[0]_inst_i_4 ));
  CARRY4 \result0_inferred__0/i__carry__0 
       (.CI(\result0_inferred__0/i__carry_n_0 ),
        .CO({\savedvalue_reg[7] ,\result0_inferred__0/i__carry__0_n_1 ,\result0_inferred__0/i__carry__0_n_2 ,\result0_inferred__0/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({Q,\led_OBUF[4]_inst_i_3 [6:4]}),
        .O(\savedvalue_reg[7]_0 ),
        .S(\led_OBUF[4]_inst_i_2 ));
endmodule

module register
   (\savedvalue_reg[2]_0 ,
    \savedvalue_reg[7]_0 ,
    \savedvalue_reg[0]_0 ,
    \savedvalue_reg[1]_0 ,
    \savedvalue_reg[7]_1 ,
    \savedvalue_reg[7]_2 ,
    \savedvalue_reg[3]_0 ,
    \savedvalue_reg[4]_0 ,
    DI,
    CO,
    S,
    \savedvalue_reg[7]_3 ,
    Q,
    \led_OBUF[5]_inst_i_4 ,
    carry_led_OBUF_inst_i_1,
    E,
    D,
    CLK,
    AR);
  output \savedvalue_reg[2]_0 ;
  output [7:0]\savedvalue_reg[7]_0 ;
  output \savedvalue_reg[0]_0 ;
  output \savedvalue_reg[1]_0 ;
  output \savedvalue_reg[7]_1 ;
  output \savedvalue_reg[7]_2 ;
  output \savedvalue_reg[3]_0 ;
  output \savedvalue_reg[4]_0 ;
  output [0:0]DI;
  output [0:0]CO;
  output [3:0]S;
  output [3:0]\savedvalue_reg[7]_3 ;
  input [7:0]Q;
  input [1:0]\led_OBUF[5]_inst_i_4 ;
  input [0:0]carry_led_OBUF_inst_i_1;
  input [0:0]E;
  input [7:0]D;
  input CLK;
  input [0:0]AR;

  wire [0:0]AR;
  wire CLK;
  wire [0:0]CO;
  wire [7:0]D;
  wire [0:0]DI;
  wire [0:0]E;
  wire [7:0]Q;
  wire [3:0]S;
  wire [0:0]carry_led_OBUF_inst_i_1;
  wire \led_OBUF[0]_inst_i_7_n_0 ;
  wire \led_OBUF[4]_inst_i_6_n_0 ;
  wire [1:0]\led_OBUF[5]_inst_i_4 ;
  wire \savedvalue_reg[0]_0 ;
  wire \savedvalue_reg[1]_0 ;
  wire \savedvalue_reg[2]_0 ;
  wire \savedvalue_reg[3]_0 ;
  wire \savedvalue_reg[4]_0 ;
  wire [7:0]\savedvalue_reg[7]_0 ;
  wire \savedvalue_reg[7]_1 ;
  wire \savedvalue_reg[7]_2 ;
  wire [3:0]\savedvalue_reg[7]_3 ;
  wire [3:1]NLW_carry_led_OBUF_inst_i_5_CO_UNCONNECTED;
  wire [3:0]NLW_carry_led_OBUF_inst_i_5_O_UNCONNECTED;

  CARRY4 carry_led_OBUF_inst_i_5
       (.CI(carry_led_OBUF_inst_i_1),
        .CO({NLW_carry_led_OBUF_inst_i_5_CO_UNCONNECTED[3:1],CO}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_carry_led_OBUF_inst_i_5_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,1'b0,1'b1}));
  LUT6 #(
    .INIT(64'h00000000FF00E2E2)) 
    \led_OBUF[0]_inst_i_6 
       (.I0(\savedvalue_reg[7]_0 [0]),
        .I1(Q[2]),
        .I2(\savedvalue_reg[7]_0 [4]),
        .I3(\led_OBUF[0]_inst_i_7_n_0 ),
        .I4(Q[1]),
        .I5(Q[0]),
        .O(\savedvalue_reg[0]_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \led_OBUF[0]_inst_i_7 
       (.I0(\savedvalue_reg[7]_0 [6]),
        .I1(Q[2]),
        .I2(\savedvalue_reg[7]_0 [2]),
        .O(\led_OBUF[0]_inst_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFCFCFA0A0C0CFA0A)) 
    \led_OBUF[1]_inst_i_5 
       (.I0(\savedvalue_reg[7]_0 [1]),
        .I1(\savedvalue_reg[7]_0 [5]),
        .I2(Q[1]),
        .I3(\savedvalue_reg[7]_0 [3]),
        .I4(Q[2]),
        .I5(\savedvalue_reg[7]_0 [7]),
        .O(\savedvalue_reg[1]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \led_OBUF[2]_inst_i_6 
       (.I0(\savedvalue_reg[7]_0 [4]),
        .I1(Q[1]),
        .I2(\savedvalue_reg[7]_0 [6]),
        .I3(Q[2]),
        .I4(\savedvalue_reg[7]_0 [2]),
        .O(\savedvalue_reg[4]_0 ));
  LUT5 #(
    .INIT(32'h00CCF0AA)) 
    \led_OBUF[3]_inst_i_6 
       (.I0(\savedvalue_reg[7]_0 [3]),
        .I1(\savedvalue_reg[7]_0 [7]),
        .I2(\savedvalue_reg[7]_0 [5]),
        .I3(Q[1]),
        .I4(Q[2]),
        .O(\savedvalue_reg[3]_0 ));
  LUT5 #(
    .INIT(32'h0000F8F0)) 
    \led_OBUF[4]_inst_i_5 
       (.I0(Q[2]),
        .I1(\savedvalue_reg[7]_0 [7]),
        .I2(\led_OBUF[4]_inst_i_6_n_0 ),
        .I3(\led_OBUF[5]_inst_i_4 [0]),
        .I4(\led_OBUF[5]_inst_i_4 [1]),
        .O(\savedvalue_reg[2]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h00CA)) 
    \led_OBUF[4]_inst_i_6 
       (.I0(\savedvalue_reg[7]_0 [4]),
        .I1(\savedvalue_reg[7]_0 [6]),
        .I2(Q[1]),
        .I3(Q[2]),
        .O(\led_OBUF[4]_inst_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h00000000ABA80B08)) 
    \led_OBUF[5]_inst_i_5 
       (.I0(\savedvalue_reg[7]_0 [7]),
        .I1(Q[1]),
        .I2(Q[2]),
        .I3(\savedvalue_reg[7]_0 [5]),
        .I4(\led_OBUF[5]_inst_i_4 [0]),
        .I5(\led_OBUF[5]_inst_i_4 [1]),
        .O(\savedvalue_reg[7]_2 ));
  LUT6 #(
    .INIT(64'h00000000ABA80300)) 
    \led_OBUF[6]_inst_i_10 
       (.I0(\savedvalue_reg[7]_0 [7]),
        .I1(Q[1]),
        .I2(Q[2]),
        .I3(\savedvalue_reg[7]_0 [6]),
        .I4(\led_OBUF[5]_inst_i_4 [0]),
        .I5(\led_OBUF[5]_inst_i_4 [1]),
        .O(\savedvalue_reg[7]_1 ));
  LUT1 #(
    .INIT(2'h1)) 
    result0_carry__0_i_1
       (.I0(\savedvalue_reg[7]_0 [7]),
        .O(DI));
  LUT2 #(
    .INIT(4'h6)) 
    result0_carry__0_i_2
       (.I0(\savedvalue_reg[7]_0 [7]),
        .I1(Q[7]),
        .O(\savedvalue_reg[7]_3 [3]));
  LUT2 #(
    .INIT(4'h6)) 
    result0_carry__0_i_3
       (.I0(\savedvalue_reg[7]_0 [6]),
        .I1(Q[6]),
        .O(\savedvalue_reg[7]_3 [2]));
  LUT2 #(
    .INIT(4'h6)) 
    result0_carry__0_i_4
       (.I0(\savedvalue_reg[7]_0 [5]),
        .I1(Q[5]),
        .O(\savedvalue_reg[7]_3 [1]));
  LUT2 #(
    .INIT(4'h6)) 
    result0_carry__0_i_5
       (.I0(\savedvalue_reg[7]_0 [4]),
        .I1(Q[4]),
        .O(\savedvalue_reg[7]_3 [0]));
  LUT2 #(
    .INIT(4'h6)) 
    result0_carry_i_1
       (.I0(\savedvalue_reg[7]_0 [3]),
        .I1(Q[3]),
        .O(S[3]));
  LUT2 #(
    .INIT(4'h6)) 
    result0_carry_i_2
       (.I0(\savedvalue_reg[7]_0 [2]),
        .I1(Q[2]),
        .O(S[2]));
  LUT2 #(
    .INIT(4'h6)) 
    result0_carry_i_3
       (.I0(\savedvalue_reg[7]_0 [1]),
        .I1(Q[1]),
        .O(S[1]));
  LUT2 #(
    .INIT(4'h6)) 
    result0_carry_i_4
       (.I0(\savedvalue_reg[7]_0 [0]),
        .I1(Q[0]),
        .O(S[0]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[0] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[0]),
        .Q(\savedvalue_reg[7]_0 [0]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[1] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[1]),
        .Q(\savedvalue_reg[7]_0 [1]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[2] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[2]),
        .Q(\savedvalue_reg[7]_0 [2]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[3] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[3]),
        .Q(\savedvalue_reg[7]_0 [3]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[4] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[4]),
        .Q(\savedvalue_reg[7]_0 [4]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[5] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[5]),
        .Q(\savedvalue_reg[7]_0 [5]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[6] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[6]),
        .Q(\savedvalue_reg[7]_0 [6]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[7] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[7]),
        .Q(\savedvalue_reg[7]_0 [7]));
endmodule

(* ORIG_REF_NAME = "register" *) 
module register_0
   (\savedvalue_reg[0]_0 ,
    Q,
    \savedvalue_reg[3]_0 ,
    \savedvalue_reg[0]_1 ,
    \savedvalue_reg[2]_0 ,
    \savedvalue_reg[7]_0 ,
    \savedvalue_reg[0]_2 ,
    \savedvalue_reg[1]_0 ,
    CO,
    S,
    \savedvalue_reg[7]_1 ,
    \led_OBUF[3]_inst_i_1 ,
    \led_OBUF[1]_inst_i_1 ,
    \led_OBUF[3]_inst_i_1_0 ,
    \led_OBUF[2]_inst_i_4_0 ,
    \led_OBUF[1]_inst_i_1_0 ,
    \result0_inferred__0/i__carry__0 ,
    \led_OBUF[6]_inst_i_1 ,
    \led_OBUF[6]_inst_i_1_0 ,
    \led_OBUF[2]_inst_i_4_1 ,
    \led_OBUF[2]_inst_i_4_2 ,
    carry_led_OBUF_inst_i_1,
    E,
    D,
    CLK,
    AR);
  output \savedvalue_reg[0]_0 ;
  output [7:0]Q;
  output \savedvalue_reg[3]_0 ;
  output \savedvalue_reg[0]_1 ;
  output \savedvalue_reg[2]_0 ;
  output \savedvalue_reg[7]_0 ;
  output \savedvalue_reg[0]_2 ;
  output \savedvalue_reg[1]_0 ;
  output [0:0]CO;
  output [3:0]S;
  output [3:0]\savedvalue_reg[7]_1 ;
  input \led_OBUF[3]_inst_i_1 ;
  input \led_OBUF[1]_inst_i_1 ;
  input \led_OBUF[3]_inst_i_1_0 ;
  input [1:0]\led_OBUF[2]_inst_i_4_0 ;
  input \led_OBUF[1]_inst_i_1_0 ;
  input [7:0]\result0_inferred__0/i__carry__0 ;
  input \led_OBUF[6]_inst_i_1 ;
  input \led_OBUF[6]_inst_i_1_0 ;
  input \led_OBUF[2]_inst_i_4_1 ;
  input \led_OBUF[2]_inst_i_4_2 ;
  input [0:0]carry_led_OBUF_inst_i_1;
  input [0:0]E;
  input [7:0]D;
  input CLK;
  input [0:0]AR;

  wire [0:0]AR;
  wire CLK;
  wire [0:0]CO;
  wire [7:0]D;
  wire [0:0]E;
  wire [7:0]Q;
  wire [3:0]S;
  wire [0:0]carry_led_OBUF_inst_i_1;
  wire \led_OBUF[1]_inst_i_1 ;
  wire \led_OBUF[1]_inst_i_1_0 ;
  wire [1:0]\led_OBUF[2]_inst_i_4_0 ;
  wire \led_OBUF[2]_inst_i_4_1 ;
  wire \led_OBUF[2]_inst_i_4_2 ;
  wire \led_OBUF[2]_inst_i_5_n_0 ;
  wire \led_OBUF[3]_inst_i_1 ;
  wire \led_OBUF[3]_inst_i_1_0 ;
  wire \led_OBUF[3]_inst_i_5_n_0 ;
  wire \led_OBUF[6]_inst_i_1 ;
  wire \led_OBUF[6]_inst_i_1_0 ;
  wire \led_OBUF[6]_inst_i_7_n_0 ;
  wire [7:0]\result0_inferred__0/i__carry__0 ;
  wire \savedvalue_reg[0]_0 ;
  wire \savedvalue_reg[0]_1 ;
  wire \savedvalue_reg[0]_2 ;
  wire \savedvalue_reg[1]_0 ;
  wire \savedvalue_reg[2]_0 ;
  wire \savedvalue_reg[3]_0 ;
  wire \savedvalue_reg[7]_0 ;
  wire [3:0]\savedvalue_reg[7]_1 ;
  wire [3:1]NLW_carry_led_OBUF_inst_i_2_CO_UNCONNECTED;
  wire [3:0]NLW_carry_led_OBUF_inst_i_2_O_UNCONNECTED;

  CARRY4 carry_led_OBUF_inst_i_2
       (.CI(carry_led_OBUF_inst_i_1),
        .CO({NLW_carry_led_OBUF_inst_i_2_CO_UNCONNECTED[3:1],CO}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_carry_led_OBUF_inst_i_2_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,1'b0,1'b1}));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_1
       (.I0(Q[7]),
        .I1(\result0_inferred__0/i__carry__0 [7]),
        .O(\savedvalue_reg[7]_1 [3]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_2
       (.I0(Q[6]),
        .I1(\result0_inferred__0/i__carry__0 [6]),
        .O(\savedvalue_reg[7]_1 [2]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_3
       (.I0(Q[5]),
        .I1(\result0_inferred__0/i__carry__0 [5]),
        .O(\savedvalue_reg[7]_1 [1]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_4
       (.I0(Q[4]),
        .I1(\result0_inferred__0/i__carry__0 [4]),
        .O(\savedvalue_reg[7]_1 [0]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_1
       (.I0(Q[3]),
        .I1(\result0_inferred__0/i__carry__0 [3]),
        .O(S[3]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_2
       (.I0(Q[2]),
        .I1(\result0_inferred__0/i__carry__0 [2]),
        .O(S[2]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_3
       (.I0(Q[1]),
        .I1(\result0_inferred__0/i__carry__0 [1]),
        .O(S[1]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_4
       (.I0(Q[0]),
        .I1(\result0_inferred__0/i__carry__0 [0]),
        .O(S[0]));
  LUT6 #(
    .INIT(64'hFFAABAAAAAAABAAA)) 
    \led_OBUF[1]_inst_i_4 
       (.I0(\led_OBUF[1]_inst_i_1 ),
        .I1(\led_OBUF[2]_inst_i_4_0 [1]),
        .I2(\led_OBUF[1]_inst_i_1_0 ),
        .I3(\savedvalue_reg[3]_0 ),
        .I4(Q[0]),
        .I5(\led_OBUF[2]_inst_i_5_n_0 ),
        .O(\savedvalue_reg[2]_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA8A008000)) 
    \led_OBUF[2]_inst_i_4 
       (.I0(\led_OBUF[3]_inst_i_1 ),
        .I1(\led_OBUF[3]_inst_i_5_n_0 ),
        .I2(Q[0]),
        .I3(\savedvalue_reg[3]_0 ),
        .I4(\led_OBUF[2]_inst_i_5_n_0 ),
        .I5(\led_OBUF[1]_inst_i_1 ),
        .O(\savedvalue_reg[0]_0 ));
  LUT6 #(
    .INIT(64'h00000000FF80FF00)) 
    \led_OBUF[2]_inst_i_5 
       (.I0(Q[1]),
        .I1(\result0_inferred__0/i__carry__0 [7]),
        .I2(Q[2]),
        .I3(\led_OBUF[2]_inst_i_4_2 ),
        .I4(\led_OBUF[2]_inst_i_4_0 [0]),
        .I5(\led_OBUF[2]_inst_i_4_0 [1]),
        .O(\led_OBUF[2]_inst_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAA0800080)) 
    \led_OBUF[3]_inst_i_4 
       (.I0(\led_OBUF[3]_inst_i_1 ),
        .I1(\led_OBUF[3]_inst_i_5_n_0 ),
        .I2(\savedvalue_reg[3]_0 ),
        .I3(Q[0]),
        .I4(\led_OBUF[3]_inst_i_1_0 ),
        .I5(\led_OBUF[1]_inst_i_1 ),
        .O(\savedvalue_reg[0]_1 ));
  LUT6 #(
    .INIT(64'h00000000FF80FF00)) 
    \led_OBUF[3]_inst_i_5 
       (.I0(Q[1]),
        .I1(\result0_inferred__0/i__carry__0 [7]),
        .I2(Q[2]),
        .I3(\led_OBUF[2]_inst_i_4_1 ),
        .I4(\led_OBUF[2]_inst_i_4_0 [0]),
        .I5(\led_OBUF[2]_inst_i_4_0 [1]),
        .O(\led_OBUF[3]_inst_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hEAFFC0C0EA00C0C0)) 
    \led_OBUF[6]_inst_i_5 
       (.I0(\led_OBUF[6]_inst_i_7_n_0 ),
        .I1(\result0_inferred__0/i__carry__0 [7]),
        .I2(\led_OBUF[6]_inst_i_1 ),
        .I3(Q[0]),
        .I4(\savedvalue_reg[3]_0 ),
        .I5(\led_OBUF[6]_inst_i_1_0 ),
        .O(\savedvalue_reg[7]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \led_OBUF[6]_inst_i_7 
       (.I0(\led_OBUF[2]_inst_i_4_0 [1]),
        .I1(\result0_inferred__0/i__carry__0 [7]),
        .I2(Q[2]),
        .I3(Q[1]),
        .O(\led_OBUF[6]_inst_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \led_OBUF[6]_inst_i_9 
       (.I0(Q[3]),
        .I1(Q[4]),
        .I2(Q[5]),
        .I3(Q[7]),
        .I4(Q[6]),
        .O(\savedvalue_reg[3]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \led_OBUF[7]_inst_i_5 
       (.I0(Q[1]),
        .I1(Q[2]),
        .O(\savedvalue_reg[1]_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \led_OBUF[7]_inst_i_6 
       (.I0(Q[0]),
        .I1(Q[6]),
        .I2(Q[7]),
        .I3(Q[5]),
        .I4(Q[4]),
        .I5(Q[3]),
        .O(\savedvalue_reg[0]_2 ));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[0] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[0]),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[1] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[1]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[2] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[2]),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[3] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[3]),
        .Q(Q[3]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[4] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[4]),
        .Q(Q[4]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[5] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[5]),
        .Q(Q[5]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[6] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[6]),
        .Q(Q[6]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[7] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[7]),
        .Q(Q[7]));
endmodule

(* ORIG_REF_NAME = "register" *) 
module register__parameterized0
   (zero_led_OBUF,
    led_OBUF,
    \savedvalue_reg[7] ,
    \savedvalue_reg[1]_0 ,
    Q,
    \savedvalue_reg[0]_0 ,
    carry_led_OBUF,
    \led_OBUF[1]_inst_i_4 ,
    \led_OBUF[0]_inst_i_1_0 ,
    \led_OBUF[7]_inst_i_1_0 ,
    \led_OBUF[0]_inst_i_1_1 ,
    \led[2] ,
    \led[3] ,
    \led_OBUF[5]_inst_i_1_0 ,
    \led_OBUF[4]_inst_i_1_0 ,
    \led[1] ,
    \led[6] ,
    \led_OBUF[5]_inst_i_1_1 ,
    \led_OBUF[7]_inst_i_1_1 ,
    \led_OBUF[7]_inst_i_1_2 ,
    \led_OBUF[7]_inst_i_1_3 ,
    CO,
    carry_led,
    O,
    \led_OBUF[7]_inst_i_1_4 ,
    \led_OBUF[3]_inst_i_1_0 ,
    \led_OBUF[7]_inst_i_1_5 ,
    E,
    D,
    CLK,
    AR);
  output zero_led_OBUF;
  output [7:0]led_OBUF;
  output \savedvalue_reg[7] ;
  output \savedvalue_reg[1]_0 ;
  output [1:0]Q;
  output \savedvalue_reg[0]_0 ;
  output carry_led_OBUF;
  input \led_OBUF[1]_inst_i_4 ;
  input \led_OBUF[0]_inst_i_1_0 ;
  input [7:0]\led_OBUF[7]_inst_i_1_0 ;
  input \led_OBUF[0]_inst_i_1_1 ;
  input \led[2] ;
  input \led[3] ;
  input \led_OBUF[5]_inst_i_1_0 ;
  input \led_OBUF[4]_inst_i_1_0 ;
  input \led[1] ;
  input \led[6] ;
  input \led_OBUF[5]_inst_i_1_1 ;
  input [7:0]\led_OBUF[7]_inst_i_1_1 ;
  input \led_OBUF[7]_inst_i_1_2 ;
  input \led_OBUF[7]_inst_i_1_3 ;
  input [0:0]CO;
  input [0:0]carry_led;
  input [3:0]O;
  input [3:0]\led_OBUF[7]_inst_i_1_4 ;
  input [3:0]\led_OBUF[3]_inst_i_1_0 ;
  input [3:0]\led_OBUF[7]_inst_i_1_5 ;
  input [0:0]E;
  input [5:0]D;
  input CLK;
  input [0:0]AR;

  wire [0:0]AR;
  wire CLK;
  wire [0:0]CO;
  wire [5:0]D;
  wire [0:0]E;
  wire [3:0]O;
  wire [1:0]Q;
  wire [0:0]carry_led;
  wire carry_led_OBUF;
  wire carry_led_OBUF_inst_i_3_n_0;
  wire carry_led_OBUF_inst_i_4_n_0;
  wire \led[1] ;
  wire \led[2] ;
  wire \led[3] ;
  wire \led[6] ;
  wire [7:0]led_OBUF;
  wire \led_OBUF[0]_inst_i_1_0 ;
  wire \led_OBUF[0]_inst_i_1_1 ;
  wire \led_OBUF[0]_inst_i_3_n_0 ;
  wire \led_OBUF[0]_inst_i_4_n_0 ;
  wire \led_OBUF[0]_inst_i_5_n_0 ;
  wire \led_OBUF[1]_inst_i_2_n_0 ;
  wire \led_OBUF[1]_inst_i_3_n_0 ;
  wire \led_OBUF[1]_inst_i_4 ;
  wire \led_OBUF[2]_inst_i_2_n_0 ;
  wire \led_OBUF[2]_inst_i_3_n_0 ;
  wire [3:0]\led_OBUF[3]_inst_i_1_0 ;
  wire \led_OBUF[3]_inst_i_2_n_0 ;
  wire \led_OBUF[3]_inst_i_3_n_0 ;
  wire \led_OBUF[4]_inst_i_1_0 ;
  wire \led_OBUF[4]_inst_i_2_n_0 ;
  wire \led_OBUF[4]_inst_i_3_n_0 ;
  wire \led_OBUF[4]_inst_i_4_n_0 ;
  wire \led_OBUF[5]_inst_i_1_0 ;
  wire \led_OBUF[5]_inst_i_1_1 ;
  wire \led_OBUF[5]_inst_i_2_n_0 ;
  wire \led_OBUF[5]_inst_i_3_n_0 ;
  wire \led_OBUF[5]_inst_i_4_n_0 ;
  wire \led_OBUF[6]_inst_i_2_n_0 ;
  wire \led_OBUF[6]_inst_i_3_n_0 ;
  wire \led_OBUF[6]_inst_i_4_n_0 ;
  wire [7:0]\led_OBUF[7]_inst_i_1_0 ;
  wire [7:0]\led_OBUF[7]_inst_i_1_1 ;
  wire \led_OBUF[7]_inst_i_1_2 ;
  wire \led_OBUF[7]_inst_i_1_3 ;
  wire [3:0]\led_OBUF[7]_inst_i_1_4 ;
  wire [3:0]\led_OBUF[7]_inst_i_1_5 ;
  wire \led_OBUF[7]_inst_i_2_n_0 ;
  wire \led_OBUF[7]_inst_i_3_n_0 ;
  wire \led_OBUF[7]_inst_i_4_n_0 ;
  wire \savedvalue_reg[0]_0 ;
  wire \savedvalue_reg[1]_0 ;
  wire \savedvalue_reg[7] ;
  wire \savedvalue_reg_n_0_[1] ;
  wire \savedvalue_reg_n_0_[3] ;
  wire \savedvalue_reg_n_0_[4] ;
  wire \savedvalue_reg_n_0_[5] ;
  wire zero_led_OBUF;
  wire zero_led_OBUF_inst_i_2_n_0;

  LUT6 #(
    .INIT(64'h4000000040C00000)) 
    carry_led_OBUF_inst_i_1
       (.I0(CO),
        .I1(carry_led_OBUF_inst_i_3_n_0),
        .I2(\savedvalue_reg_n_0_[5] ),
        .I3(\savedvalue_reg_n_0_[1] ),
        .I4(carry_led_OBUF_inst_i_4_n_0),
        .I5(carry_led),
        .O(carry_led_OBUF));
  LUT2 #(
    .INIT(4'h1)) 
    carry_led_OBUF_inst_i_3
       (.I0(\savedvalue_reg_n_0_[4] ),
        .I1(\savedvalue_reg_n_0_[3] ),
        .O(carry_led_OBUF_inst_i_3_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    carry_led_OBUF_inst_i_4
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(carry_led_OBUF_inst_i_4_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFF8F8F8F8F8)) 
    \led_OBUF[0]_inst_i_1 
       (.I0(\savedvalue_reg[7] ),
        .I1(\savedvalue_reg[1]_0 ),
        .I2(\led_OBUF[0]_inst_i_3_n_0 ),
        .I3(\led_OBUF[0]_inst_i_4_n_0 ),
        .I4(\led_OBUF[0]_inst_i_5_n_0 ),
        .I5(\led_OBUF[6]_inst_i_4_n_0 ),
        .O(led_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0008)) 
    \led_OBUF[0]_inst_i_2 
       (.I0(\led_OBUF[7]_inst_i_1_1 [7]),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(\led_OBUF[1]_inst_i_4 ),
        .O(\savedvalue_reg[7] ));
  LUT6 #(
    .INIT(64'h0808080808000000)) 
    \led_OBUF[0]_inst_i_3 
       (.I0(\savedvalue_reg[1]_0 ),
        .I1(\led_OBUF[1]_inst_i_4 ),
        .I2(Q[1]),
        .I3(\led_OBUF[0]_inst_i_1_0 ),
        .I4(\led_OBUF[7]_inst_i_1_0 [0]),
        .I5(\led_OBUF[0]_inst_i_1_1 ),
        .O(\led_OBUF[0]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h120FE0001200E000)) 
    \led_OBUF[0]_inst_i_4 
       (.I0(\led_OBUF[7]_inst_i_1_0 [0]),
        .I1(\led_OBUF[7]_inst_i_1_1 [0]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\savedvalue_reg_n_0_[1] ),
        .I5(O[0]),
        .O(\led_OBUF[0]_inst_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0C0E000200C20002)) 
    \led_OBUF[0]_inst_i_5 
       (.I0(\led_OBUF[3]_inst_i_1_0 [0]),
        .I1(Q[1]),
        .I2(\savedvalue_reg_n_0_[1] ),
        .I3(Q[0]),
        .I4(\led_OBUF[7]_inst_i_1_1 [0]),
        .I5(\led_OBUF[7]_inst_i_1_0 [0]),
        .O(\led_OBUF[0]_inst_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFE0E0E0)) 
    \led_OBUF[1]_inst_i_1 
       (.I0(\led_OBUF[1]_inst_i_2_n_0 ),
        .I1(\led_OBUF[1]_inst_i_3_n_0 ),
        .I2(\led_OBUF[6]_inst_i_4_n_0 ),
        .I3(\led[1] ),
        .I4(\savedvalue_reg[1]_0 ),
        .O(led_OBUF[1]));
  LUT6 #(
    .INIT(64'h140FE0001400E000)) 
    \led_OBUF[1]_inst_i_2 
       (.I0(\led_OBUF[7]_inst_i_1_1 [1]),
        .I1(\led_OBUF[7]_inst_i_1_0 [1]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\savedvalue_reg_n_0_[1] ),
        .I5(O[1]),
        .O(\led_OBUF[1]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0C0E000200C20002)) 
    \led_OBUF[1]_inst_i_3 
       (.I0(\led_OBUF[3]_inst_i_1_0 [1]),
        .I1(Q[1]),
        .I2(\savedvalue_reg_n_0_[1] ),
        .I3(Q[0]),
        .I4(\led_OBUF[7]_inst_i_1_1 [1]),
        .I5(\led_OBUF[7]_inst_i_1_0 [1]),
        .O(\led_OBUF[1]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000E0000)) 
    \led_OBUF[2]_inst_i_1 
       (.I0(\led_OBUF[2]_inst_i_2_n_0 ),
        .I1(\led_OBUF[2]_inst_i_3_n_0 ),
        .I2(\savedvalue_reg_n_0_[3] ),
        .I3(\savedvalue_reg_n_0_[4] ),
        .I4(\savedvalue_reg_n_0_[5] ),
        .I5(\led[2] ),
        .O(led_OBUF[2]));
  LUT6 #(
    .INIT(64'h120FE0001200E000)) 
    \led_OBUF[2]_inst_i_2 
       (.I0(\led_OBUF[7]_inst_i_1_0 [2]),
        .I1(\led_OBUF[7]_inst_i_1_1 [2]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\savedvalue_reg_n_0_[1] ),
        .I5(O[2]),
        .O(\led_OBUF[2]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0C0E000200C20002)) 
    \led_OBUF[2]_inst_i_3 
       (.I0(\led_OBUF[3]_inst_i_1_0 [2]),
        .I1(Q[1]),
        .I2(\savedvalue_reg_n_0_[1] ),
        .I3(Q[0]),
        .I4(\led_OBUF[7]_inst_i_1_1 [2]),
        .I5(\led_OBUF[7]_inst_i_1_0 [2]),
        .O(\led_OBUF[2]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000E0000)) 
    \led_OBUF[3]_inst_i_1 
       (.I0(\led_OBUF[3]_inst_i_2_n_0 ),
        .I1(\led_OBUF[3]_inst_i_3_n_0 ),
        .I2(\savedvalue_reg_n_0_[3] ),
        .I3(\savedvalue_reg_n_0_[4] ),
        .I4(\savedvalue_reg_n_0_[5] ),
        .I5(\led[3] ),
        .O(led_OBUF[3]));
  LUT6 #(
    .INIT(64'h140FE0001400E000)) 
    \led_OBUF[3]_inst_i_2 
       (.I0(\led_OBUF[7]_inst_i_1_1 [3]),
        .I1(\led_OBUF[7]_inst_i_1_0 [3]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\savedvalue_reg_n_0_[1] ),
        .I5(O[3]),
        .O(\led_OBUF[3]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0C0E000200C20002)) 
    \led_OBUF[3]_inst_i_3 
       (.I0(\led_OBUF[3]_inst_i_1_0 [3]),
        .I1(Q[1]),
        .I2(\savedvalue_reg_n_0_[1] ),
        .I3(Q[0]),
        .I4(\led_OBUF[7]_inst_i_1_1 [3]),
        .I5(\led_OBUF[7]_inst_i_1_0 [3]),
        .O(\led_OBUF[3]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000E0000)) 
    \led_OBUF[4]_inst_i_1 
       (.I0(\led_OBUF[4]_inst_i_2_n_0 ),
        .I1(\led_OBUF[4]_inst_i_3_n_0 ),
        .I2(\savedvalue_reg_n_0_[3] ),
        .I3(\savedvalue_reg_n_0_[4] ),
        .I4(\savedvalue_reg_n_0_[5] ),
        .I5(\led_OBUF[4]_inst_i_4_n_0 ),
        .O(led_OBUF[4]));
  LUT6 #(
    .INIT(64'h140FE0001400E000)) 
    \led_OBUF[4]_inst_i_2 
       (.I0(\led_OBUF[7]_inst_i_1_1 [4]),
        .I1(\led_OBUF[7]_inst_i_1_0 [4]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\savedvalue_reg_n_0_[1] ),
        .I5(\led_OBUF[7]_inst_i_1_4 [0]),
        .O(\led_OBUF[4]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0C0E000200C20002)) 
    \led_OBUF[4]_inst_i_3 
       (.I0(\led_OBUF[7]_inst_i_1_5 [0]),
        .I1(Q[1]),
        .I2(\savedvalue_reg_n_0_[1] ),
        .I3(Q[0]),
        .I4(\led_OBUF[7]_inst_i_1_1 [4]),
        .I5(\led_OBUF[7]_inst_i_1_0 [4]),
        .O(\led_OBUF[4]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA8A008000)) 
    \led_OBUF[4]_inst_i_4 
       (.I0(\savedvalue_reg[1]_0 ),
        .I1(\led_OBUF[5]_inst_i_1_0 ),
        .I2(\led_OBUF[7]_inst_i_1_0 [0]),
        .I3(\led_OBUF[1]_inst_i_4 ),
        .I4(\led_OBUF[4]_inst_i_1_0 ),
        .I5(\savedvalue_reg[7] ),
        .O(\led_OBUF[4]_inst_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000E0000)) 
    \led_OBUF[5]_inst_i_1 
       (.I0(\led_OBUF[5]_inst_i_2_n_0 ),
        .I1(\led_OBUF[5]_inst_i_3_n_0 ),
        .I2(\savedvalue_reg_n_0_[3] ),
        .I3(\savedvalue_reg_n_0_[4] ),
        .I4(\savedvalue_reg_n_0_[5] ),
        .I5(\led_OBUF[5]_inst_i_4_n_0 ),
        .O(led_OBUF[5]));
  LUT6 #(
    .INIT(64'h140FE0001400E000)) 
    \led_OBUF[5]_inst_i_2 
       (.I0(\led_OBUF[7]_inst_i_1_1 [5]),
        .I1(\led_OBUF[7]_inst_i_1_0 [5]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\savedvalue_reg_n_0_[1] ),
        .I5(\led_OBUF[7]_inst_i_1_4 [1]),
        .O(\led_OBUF[5]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0C0E000200C20002)) 
    \led_OBUF[5]_inst_i_3 
       (.I0(\led_OBUF[7]_inst_i_1_5 [1]),
        .I1(Q[1]),
        .I2(\savedvalue_reg_n_0_[1] ),
        .I3(Q[0]),
        .I4(\led_OBUF[7]_inst_i_1_1 [5]),
        .I5(\led_OBUF[7]_inst_i_1_0 [5]),
        .O(\led_OBUF[5]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAA0800080)) 
    \led_OBUF[5]_inst_i_4 
       (.I0(\savedvalue_reg[1]_0 ),
        .I1(\led_OBUF[5]_inst_i_1_0 ),
        .I2(\led_OBUF[1]_inst_i_4 ),
        .I3(\led_OBUF[7]_inst_i_1_0 [0]),
        .I4(\led_OBUF[5]_inst_i_1_1 ),
        .I5(\savedvalue_reg[7] ),
        .O(\led_OBUF[5]_inst_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFE0E0E0)) 
    \led_OBUF[6]_inst_i_1 
       (.I0(\led_OBUF[6]_inst_i_2_n_0 ),
        .I1(\led_OBUF[6]_inst_i_3_n_0 ),
        .I2(\led_OBUF[6]_inst_i_4_n_0 ),
        .I3(\led[6] ),
        .I4(\savedvalue_reg[1]_0 ),
        .O(led_OBUF[6]));
  LUT6 #(
    .INIT(64'h140FE0001400E000)) 
    \led_OBUF[6]_inst_i_2 
       (.I0(\led_OBUF[7]_inst_i_1_1 [6]),
        .I1(\led_OBUF[7]_inst_i_1_0 [6]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\savedvalue_reg_n_0_[1] ),
        .I5(\led_OBUF[7]_inst_i_1_4 [2]),
        .O(\led_OBUF[6]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0C0E000200C20002)) 
    \led_OBUF[6]_inst_i_3 
       (.I0(\led_OBUF[7]_inst_i_1_5 [2]),
        .I1(Q[1]),
        .I2(\savedvalue_reg_n_0_[1] ),
        .I3(Q[0]),
        .I4(\led_OBUF[7]_inst_i_1_1 [6]),
        .I5(\led_OBUF[7]_inst_i_1_0 [6]),
        .O(\led_OBUF[6]_inst_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \led_OBUF[6]_inst_i_4 
       (.I0(\savedvalue_reg_n_0_[3] ),
        .I1(\savedvalue_reg_n_0_[4] ),
        .I2(\savedvalue_reg_n_0_[5] ),
        .O(\led_OBUF[6]_inst_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    \led_OBUF[6]_inst_i_6 
       (.I0(\savedvalue_reg_n_0_[1] ),
        .I1(\savedvalue_reg_n_0_[4] ),
        .I2(\savedvalue_reg_n_0_[3] ),
        .I3(\savedvalue_reg_n_0_[5] ),
        .O(\savedvalue_reg[1]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \led_OBUF[6]_inst_i_8 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\savedvalue_reg[0]_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAFEAAAAAAAA)) 
    \led_OBUF[7]_inst_i_1 
       (.I0(\led_OBUF[7]_inst_i_2_n_0 ),
        .I1(\led_OBUF[7]_inst_i_3_n_0 ),
        .I2(\led_OBUF[7]_inst_i_4_n_0 ),
        .I3(\savedvalue_reg_n_0_[3] ),
        .I4(\savedvalue_reg_n_0_[4] ),
        .I5(\savedvalue_reg_n_0_[5] ),
        .O(led_OBUF[7]));
  LUT6 #(
    .INIT(64'h00F0001000000000)) 
    \led_OBUF[7]_inst_i_2 
       (.I0(\led_OBUF[7]_inst_i_1_2 ),
        .I1(\led_OBUF[7]_inst_i_1_3 ),
        .I2(\savedvalue_reg[1]_0 ),
        .I3(Q[1]),
        .I4(Q[0]),
        .I5(\led_OBUF[7]_inst_i_1_1 [7]),
        .O(\led_OBUF[7]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h140FE0001400E000)) 
    \led_OBUF[7]_inst_i_3 
       (.I0(\led_OBUF[7]_inst_i_1_1 [7]),
        .I1(\led_OBUF[7]_inst_i_1_0 [7]),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(\savedvalue_reg_n_0_[1] ),
        .I5(\led_OBUF[7]_inst_i_1_4 [3]),
        .O(\led_OBUF[7]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0C0E000200C20002)) 
    \led_OBUF[7]_inst_i_4 
       (.I0(\led_OBUF[7]_inst_i_1_5 [3]),
        .I1(Q[1]),
        .I2(\savedvalue_reg_n_0_[1] ),
        .I3(Q[0]),
        .I4(\led_OBUF[7]_inst_i_1_1 [7]),
        .I5(\led_OBUF[7]_inst_i_1_0 [7]),
        .O(\led_OBUF[7]_inst_i_4_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[0] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[0]),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[1] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[1]),
        .Q(\savedvalue_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[2] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[2]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[3] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[3]),
        .Q(\savedvalue_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[4] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[4]),
        .Q(\savedvalue_reg_n_0_[4] ));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[5] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[5]),
        .Q(\savedvalue_reg_n_0_[5] ));
  LUT3 #(
    .INIT(8'h10)) 
    zero_led_OBUF_inst_i_1
       (.I0(led_OBUF[3]),
        .I1(led_OBUF[2]),
        .I2(zero_led_OBUF_inst_i_2_n_0),
        .O(zero_led_OBUF));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    zero_led_OBUF_inst_i_2
       (.I0(led_OBUF[1]),
        .I1(led_OBUF[4]),
        .I2(led_OBUF[5]),
        .I3(led_OBUF[7]),
        .I4(led_OBUF[6]),
        .I5(led_OBUF[0]),
        .O(zero_led_OBUF_inst_i_2_n_0));
endmodule

(* NotValidForBitStream *)
module top
   (clk,
    reset,
    enA,
    enB,
    enOp,
    sw,
    led,
    zero_led,
    carry_led);
  input clk;
  input reset;
  input enA;
  input enB;
  input enOp;
  input [7:0]sw;
  output [7:0]led;
  output zero_led;
  output carry_led;

  wire [7:0]A;
  wire A_reg_n_0;
  wire A_reg_n_10;
  wire A_reg_n_11;
  wire A_reg_n_12;
  wire A_reg_n_13;
  wire A_reg_n_14;
  wire A_reg_n_15;
  wire A_reg_n_16;
  wire A_reg_n_17;
  wire A_reg_n_18;
  wire A_reg_n_19;
  wire A_reg_n_20;
  wire A_reg_n_21;
  wire A_reg_n_22;
  wire A_reg_n_23;
  wire A_reg_n_24;
  wire A_reg_n_9;
  wire [7:0]B;
  wire B_reg_n_0;
  wire B_reg_n_10;
  wire B_reg_n_11;
  wire B_reg_n_12;
  wire B_reg_n_13;
  wire B_reg_n_14;
  wire B_reg_n_15;
  wire B_reg_n_16;
  wire B_reg_n_17;
  wire B_reg_n_18;
  wire B_reg_n_19;
  wire B_reg_n_20;
  wire B_reg_n_21;
  wire B_reg_n_22;
  wire B_reg_n_23;
  wire B_reg_n_9;
  wire Op_reg_n_10;
  wire Op_reg_n_11;
  wire Op_reg_n_12;
  wire Op_reg_n_13;
  wire Op_reg_n_9;
  wire alu0_n_0;
  wire alu0_n_1;
  wire alu0_n_10;
  wire alu0_n_11;
  wire alu0_n_12;
  wire alu0_n_13;
  wire alu0_n_14;
  wire alu0_n_15;
  wire alu0_n_16;
  wire alu0_n_17;
  wire alu0_n_2;
  wire alu0_n_3;
  wire alu0_n_4;
  wire alu0_n_5;
  wire alu0_n_6;
  wire alu0_n_7;
  wire alu0_n_8;
  wire alu0_n_9;
  wire carry_led;
  wire carry_led_OBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire enA;
  wire enA_IBUF;
  wire enB;
  wire enB_IBUF;
  wire enOp;
  wire enOp_IBUF;
  wire [7:0]led;
  wire [7:0]led_OBUF;
  wire reset;
  wire reset_IBUF;
  wire [7:0]sw;
  wire [7:0]sw_IBUF;
  wire zero_led;
  wire zero_led_OBUF;

  register A_reg
       (.AR(reset_IBUF),
        .CLK(clk_IBUF_BUFG),
        .CO(A_reg_n_16),
        .D(sw_IBUF),
        .DI(A_reg_n_15),
        .E(enA_IBUF),
        .Q(B),
        .S({A_reg_n_17,A_reg_n_18,A_reg_n_19,A_reg_n_20}),
        .carry_led_OBUF_inst_i_1(alu0_n_4),
        .\led_OBUF[5]_inst_i_4 ({Op_reg_n_11,Op_reg_n_12}),
        .\savedvalue_reg[0]_0 (A_reg_n_9),
        .\savedvalue_reg[1]_0 (A_reg_n_10),
        .\savedvalue_reg[2]_0 (A_reg_n_0),
        .\savedvalue_reg[3]_0 (A_reg_n_13),
        .\savedvalue_reg[4]_0 (A_reg_n_14),
        .\savedvalue_reg[7]_0 (A),
        .\savedvalue_reg[7]_1 (A_reg_n_11),
        .\savedvalue_reg[7]_2 (A_reg_n_12),
        .\savedvalue_reg[7]_3 ({A_reg_n_21,A_reg_n_22,A_reg_n_23,A_reg_n_24}));
  register_0 B_reg
       (.AR(reset_IBUF),
        .CLK(clk_IBUF_BUFG),
        .CO(B_reg_n_15),
        .D(sw_IBUF),
        .E(enB_IBUF),
        .Q(B),
        .S({B_reg_n_16,B_reg_n_17,B_reg_n_18,B_reg_n_19}),
        .carry_led_OBUF_inst_i_1(alu0_n_13),
        .\led_OBUF[1]_inst_i_1 (Op_reg_n_9),
        .\led_OBUF[1]_inst_i_1_0 (A_reg_n_10),
        .\led_OBUF[2]_inst_i_4_0 ({Op_reg_n_11,Op_reg_n_12}),
        .\led_OBUF[2]_inst_i_4_1 (A_reg_n_13),
        .\led_OBUF[2]_inst_i_4_2 (A_reg_n_14),
        .\led_OBUF[3]_inst_i_1 (Op_reg_n_10),
        .\led_OBUF[3]_inst_i_1_0 (A_reg_n_0),
        .\led_OBUF[6]_inst_i_1 (Op_reg_n_13),
        .\led_OBUF[6]_inst_i_1_0 (A_reg_n_11),
        .\result0_inferred__0/i__carry__0 (A),
        .\savedvalue_reg[0]_0 (B_reg_n_0),
        .\savedvalue_reg[0]_1 (B_reg_n_10),
        .\savedvalue_reg[0]_2 (B_reg_n_13),
        .\savedvalue_reg[1]_0 (B_reg_n_14),
        .\savedvalue_reg[2]_0 (B_reg_n_11),
        .\savedvalue_reg[3]_0 (B_reg_n_9),
        .\savedvalue_reg[7]_0 (B_reg_n_12),
        .\savedvalue_reg[7]_1 ({B_reg_n_20,B_reg_n_21,B_reg_n_22,B_reg_n_23}));
  register__parameterized0 Op_reg
       (.AR(reset_IBUF),
        .CLK(clk_IBUF_BUFG),
        .CO(B_reg_n_15),
        .D(sw_IBUF[5:0]),
        .E(enOp_IBUF),
        .O({alu0_n_9,alu0_n_10,alu0_n_11,alu0_n_12}),
        .Q({Op_reg_n_11,Op_reg_n_12}),
        .carry_led(A_reg_n_16),
        .carry_led_OBUF(carry_led_OBUF),
        .\led[1] (B_reg_n_11),
        .\led[2] (B_reg_n_0),
        .\led[3] (B_reg_n_10),
        .\led[6] (B_reg_n_12),
        .led_OBUF(led_OBUF),
        .\led_OBUF[0]_inst_i_1_0 (A_reg_n_10),
        .\led_OBUF[0]_inst_i_1_1 (A_reg_n_9),
        .\led_OBUF[1]_inst_i_4 (B_reg_n_9),
        .\led_OBUF[3]_inst_i_1_0 ({alu0_n_0,alu0_n_1,alu0_n_2,alu0_n_3}),
        .\led_OBUF[4]_inst_i_1_0 (A_reg_n_0),
        .\led_OBUF[5]_inst_i_1_0 (A_reg_n_12),
        .\led_OBUF[5]_inst_i_1_1 (A_reg_n_11),
        .\led_OBUF[7]_inst_i_1_0 (B),
        .\led_OBUF[7]_inst_i_1_1 (A),
        .\led_OBUF[7]_inst_i_1_2 (B_reg_n_14),
        .\led_OBUF[7]_inst_i_1_3 (B_reg_n_13),
        .\led_OBUF[7]_inst_i_1_4 ({alu0_n_14,alu0_n_15,alu0_n_16,alu0_n_17}),
        .\led_OBUF[7]_inst_i_1_5 ({alu0_n_5,alu0_n_6,alu0_n_7,alu0_n_8}),
        .\savedvalue_reg[0]_0 (Op_reg_n_13),
        .\savedvalue_reg[1]_0 (Op_reg_n_10),
        .\savedvalue_reg[7] (Op_reg_n_9),
        .zero_led_OBUF(zero_led_OBUF));
  alu alu0
       (.DI(A_reg_n_15),
        .O({alu0_n_9,alu0_n_10,alu0_n_11,alu0_n_12}),
        .Q(B[7]),
        .S({A_reg_n_17,A_reg_n_18,A_reg_n_19,A_reg_n_20}),
        .\led_OBUF[0]_inst_i_4 ({B_reg_n_16,B_reg_n_17,B_reg_n_18,B_reg_n_19}),
        .\led_OBUF[4]_inst_i_2 ({B_reg_n_20,B_reg_n_21,B_reg_n_22,B_reg_n_23}),
        .\led_OBUF[4]_inst_i_3 (A[6:0]),
        .\led_OBUF[4]_inst_i_3_0 ({A_reg_n_21,A_reg_n_22,A_reg_n_23,A_reg_n_24}),
        .\savedvalue_reg[3] ({alu0_n_0,alu0_n_1,alu0_n_2,alu0_n_3}),
        .\savedvalue_reg[6] (alu0_n_4),
        .\savedvalue_reg[6]_0 ({alu0_n_5,alu0_n_6,alu0_n_7,alu0_n_8}),
        .\savedvalue_reg[7] (alu0_n_13),
        .\savedvalue_reg[7]_0 ({alu0_n_14,alu0_n_15,alu0_n_16,alu0_n_17}));
  OBUF carry_led_OBUF_inst
       (.I(carry_led_OBUF),
        .O(carry_led));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF enA_IBUF_inst
       (.I(enA),
        .O(enA_IBUF));
  IBUF enB_IBUF_inst
       (.I(enB),
        .O(enB_IBUF));
  IBUF enOp_IBUF_inst
       (.I(enOp),
        .O(enOp_IBUF));
  OBUF \led_OBUF[0]_inst 
       (.I(led_OBUF[0]),
        .O(led[0]));
  OBUF \led_OBUF[1]_inst 
       (.I(led_OBUF[1]),
        .O(led[1]));
  OBUF \led_OBUF[2]_inst 
       (.I(led_OBUF[2]),
        .O(led[2]));
  OBUF \led_OBUF[3]_inst 
       (.I(led_OBUF[3]),
        .O(led[3]));
  OBUF \led_OBUF[4]_inst 
       (.I(led_OBUF[4]),
        .O(led[4]));
  OBUF \led_OBUF[5]_inst 
       (.I(led_OBUF[5]),
        .O(led[5]));
  OBUF \led_OBUF[6]_inst 
       (.I(led_OBUF[6]),
        .O(led[6]));
  OBUF \led_OBUF[7]_inst 
       (.I(led_OBUF[7]),
        .O(led[7]));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
  IBUF \sw_IBUF[0]_inst 
       (.I(sw[0]),
        .O(sw_IBUF[0]));
  IBUF \sw_IBUF[1]_inst 
       (.I(sw[1]),
        .O(sw_IBUF[1]));
  IBUF \sw_IBUF[2]_inst 
       (.I(sw[2]),
        .O(sw_IBUF[2]));
  IBUF \sw_IBUF[3]_inst 
       (.I(sw[3]),
        .O(sw_IBUF[3]));
  IBUF \sw_IBUF[4]_inst 
       (.I(sw[4]),
        .O(sw_IBUF[4]));
  IBUF \sw_IBUF[5]_inst 
       (.I(sw[5]),
        .O(sw_IBUF[5]));
  IBUF \sw_IBUF[6]_inst 
       (.I(sw[6]),
        .O(sw_IBUF[6]));
  IBUF \sw_IBUF[7]_inst 
       (.I(sw[7]),
        .O(sw_IBUF[7]));
  OBUF zero_led_OBUF_inst
       (.I(zero_led_OBUF),
        .O(zero_led));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
