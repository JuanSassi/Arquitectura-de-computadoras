// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
// Date        : Sun Sep 21 15:01:03 2025
// Host        : franco-HP-Pavilion-x360-Convertible-14-dy0xxx running 64-bit Ubuntu 24.04.3 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/franco/TP1/TP1.sim/sim_1/impl/func/xsim/top_func_impl.v
// Design      : top
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s100fgga676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module alu
   (carry_led_OBUF,
    O,
    \savedvalue_reg[7] ,
    \savedvalue_reg[3] ,
    \savedvalue_reg[7]_0 ,
    carry_led,
    \leds_OBUF[7]_inst_i_7 ,
    S,
    \leds_OBUF[4]_inst_i_2 ,
    Q,
    CO,
    \leds_OBUF[7]_inst_i_7_0 );
  output carry_led_OBUF;
  output [3:0]O;
  output [3:0]\savedvalue_reg[7] ;
  output [3:0]\savedvalue_reg[3] ;
  output [3:0]\savedvalue_reg[7]_0 ;
  input carry_led;
  input [7:0]\leds_OBUF[7]_inst_i_7 ;
  input [3:0]S;
  input [3:0]\leds_OBUF[4]_inst_i_2 ;
  input [0:0]Q;
  input [0:0]CO;
  input [7:0]\leds_OBUF[7]_inst_i_7_0 ;

  wire [0:0]CO;
  wire [3:0]O;
  wire [0:0]Q;
  wire [3:0]S;
  wire \carry0_inferred__0/i__carry__0_n_0 ;
  wire \carry0_inferred__0/i__carry__1_n_7 ;
  wire \carry0_inferred__0/i__carry_n_0 ;
  wire carry_led;
  wire carry_led_OBUF;
  wire carry_reg_i_1_n_0;
  wire [3:0]\leds_OBUF[4]_inst_i_2 ;
  wire [7:0]\leds_OBUF[7]_inst_i_7 ;
  wire [7:0]\leds_OBUF[7]_inst_i_7_0 ;
  wire [3:0]\savedvalue_reg[3] ;
  wire [3:0]\savedvalue_reg[7] ;
  wire [3:0]\savedvalue_reg[7]_0 ;
  wire [2:0]\NLW_carry0_inferred__0/i__carry_CO_UNCONNECTED ;
  wire [2:0]\NLW_carry0_inferred__0/i__carry__0_CO_UNCONNECTED ;
  wire [3:0]\NLW_carry0_inferred__0/i__carry__1_CO_UNCONNECTED ;
  wire [3:1]\NLW_carry0_inferred__0/i__carry__1_O_UNCONNECTED ;

  CARRY4 \carry0_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\carry0_inferred__0/i__carry_n_0 ,\NLW_carry0_inferred__0/i__carry_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b1),
        .DI(\leds_OBUF[7]_inst_i_7 [3:0]),
        .O(O),
        .S(S));
  CARRY4 \carry0_inferred__0/i__carry__0 
       (.CI(\carry0_inferred__0/i__carry_n_0 ),
        .CO({\carry0_inferred__0/i__carry__0_n_0 ,\NLW_carry0_inferred__0/i__carry__0_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI(\leds_OBUF[7]_inst_i_7 [7:4]),
        .O(\savedvalue_reg[7] ),
        .S(\leds_OBUF[4]_inst_i_2 ));
  CARRY4 \carry0_inferred__0/i__carry__1 
       (.CI(\carry0_inferred__0/i__carry__0_n_0 ),
        .CO(\NLW_carry0_inferred__0/i__carry__1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_carry0_inferred__0/i__carry__1_O_UNCONNECTED [3:1],\carry0_inferred__0/i__carry__1_n_7 }),
        .S({1'b0,1'b0,1'b0,1'b1}));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE GND:CLR" *) 
  LDCE #(
    .INIT(1'b0)) 
    carry_reg
       (.CLR(1'b0),
        .D(carry_reg_i_1_n_0),
        .G(carry_led),
        .GE(1'b1),
        .Q(carry_led_OBUF));
  LUT3 #(
    .INIT(8'hB8)) 
    carry_reg_i_1
       (.I0(\carry0_inferred__0/i__carry__1_n_7 ),
        .I1(Q),
        .I2(CO),
        .O(carry_reg_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    \leds_OBUF[3]_inst_i_10 
       (.I0(\leds_OBUF[7]_inst_i_7 [0]),
        .I1(\leds_OBUF[7]_inst_i_7_0 [0]),
        .O(\savedvalue_reg[3] [0]));
  LUT2 #(
    .INIT(4'h6)) 
    \leds_OBUF[3]_inst_i_7 
       (.I0(\leds_OBUF[7]_inst_i_7 [3]),
        .I1(\leds_OBUF[7]_inst_i_7_0 [3]),
        .O(\savedvalue_reg[3] [3]));
  LUT2 #(
    .INIT(4'h6)) 
    \leds_OBUF[3]_inst_i_8 
       (.I0(\leds_OBUF[7]_inst_i_7 [2]),
        .I1(\leds_OBUF[7]_inst_i_7_0 [2]),
        .O(\savedvalue_reg[3] [2]));
  LUT2 #(
    .INIT(4'h6)) 
    \leds_OBUF[3]_inst_i_9 
       (.I0(\leds_OBUF[7]_inst_i_7 [1]),
        .I1(\leds_OBUF[7]_inst_i_7_0 [1]),
        .O(\savedvalue_reg[3] [1]));
  LUT2 #(
    .INIT(4'h6)) 
    \leds_OBUF[7]_inst_i_10 
       (.I0(\leds_OBUF[7]_inst_i_7 [5]),
        .I1(\leds_OBUF[7]_inst_i_7_0 [5]),
        .O(\savedvalue_reg[7]_0 [1]));
  LUT2 #(
    .INIT(4'h6)) 
    \leds_OBUF[7]_inst_i_11 
       (.I0(\leds_OBUF[7]_inst_i_7 [4]),
        .I1(\leds_OBUF[7]_inst_i_7_0 [4]),
        .O(\savedvalue_reg[7]_0 [0]));
  LUT2 #(
    .INIT(4'h6)) 
    \leds_OBUF[7]_inst_i_8 
       (.I0(\leds_OBUF[7]_inst_i_7 [7]),
        .I1(\leds_OBUF[7]_inst_i_7_0 [7]),
        .O(\savedvalue_reg[7]_0 [3]));
  LUT2 #(
    .INIT(4'h6)) 
    \leds_OBUF[7]_inst_i_9 
       (.I0(\leds_OBUF[7]_inst_i_7 [6]),
        .I1(\leds_OBUF[7]_inst_i_7_0 [6]),
        .O(\savedvalue_reg[7]_0 [2]));
endmodule

module register
   (\savedvalue_reg[2]_0 ,
    \savedvalue_reg[7]_0 ,
    \savedvalue_reg[7]_1 ,
    \savedvalue_reg[7]_2 ,
    \savedvalue_reg[0]_0 ,
    \savedvalue_reg[1]_0 ,
    \savedvalue_reg[4]_0 ,
    \savedvalue_reg[5]_0 ,
    O,
    \savedvalue_reg[7]_3 ,
    CO,
    Q,
    \leds_OBUF[6]_inst_i_5 ,
    S,
    \leds_OBUF[4]_inst_i_3 ,
    E,
    D,
    CLK,
    AR);
  output \savedvalue_reg[2]_0 ;
  output [7:0]\savedvalue_reg[7]_0 ;
  output \savedvalue_reg[7]_1 ;
  output \savedvalue_reg[7]_2 ;
  output \savedvalue_reg[0]_0 ;
  output \savedvalue_reg[1]_0 ;
  output \savedvalue_reg[4]_0 ;
  output \savedvalue_reg[5]_0 ;
  output [3:0]O;
  output [3:0]\savedvalue_reg[7]_3 ;
  output [0:0]CO;
  input [2:0]Q;
  input [1:0]\leds_OBUF[6]_inst_i_5 ;
  input [3:0]S;
  input [3:0]\leds_OBUF[4]_inst_i_3 ;
  input [0:0]E;
  input [7:0]D;
  input CLK;
  input [0:0]AR;

  wire [0:0]AR;
  wire CLK;
  wire [0:0]CO;
  wire [7:0]D;
  wire [0:0]E;
  wire [3:0]O;
  wire [2:0]Q;
  wire [3:0]S;
  wire \leds_OBUF[0]_inst_i_7_n_0 ;
  wire \leds_OBUF[3]_inst_i_5_n_0 ;
  wire [3:0]\leds_OBUF[4]_inst_i_3 ;
  wire \leds_OBUF[4]_inst_i_6_n_0 ;
  wire [1:0]\leds_OBUF[6]_inst_i_5 ;
  wire \leds_OBUF[7]_inst_i_7_n_0 ;
  wire \savedvalue_reg[0]_0 ;
  wire \savedvalue_reg[1]_0 ;
  wire \savedvalue_reg[2]_0 ;
  wire \savedvalue_reg[4]_0 ;
  wire \savedvalue_reg[5]_0 ;
  wire [7:0]\savedvalue_reg[7]_0 ;
  wire \savedvalue_reg[7]_1 ;
  wire \savedvalue_reg[7]_2 ;
  wire [3:0]\savedvalue_reg[7]_3 ;
  wire [3:1]NLW_carry_reg_i_3_CO_UNCONNECTED;
  wire [3:0]NLW_carry_reg_i_3_O_UNCONNECTED;
  wire [2:0]\NLW_leds_OBUF[3]_inst_i_5_CO_UNCONNECTED ;
  wire [2:0]\NLW_leds_OBUF[7]_inst_i_7_CO_UNCONNECTED ;

  CARRY4 carry_reg_i_3
       (.CI(\leds_OBUF[7]_inst_i_7_n_0 ),
        .CO({NLW_carry_reg_i_3_CO_UNCONNECTED[3:1],CO}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_carry_reg_i_3_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,1'b0,1'b1}));
  LUT6 #(
    .INIT(64'h00000000FF00E2E2)) 
    \leds_OBUF[0]_inst_i_6 
       (.I0(\savedvalue_reg[7]_0 [0]),
        .I1(Q[2]),
        .I2(\savedvalue_reg[7]_0 [4]),
        .I3(\leds_OBUF[0]_inst_i_7_n_0 ),
        .I4(Q[1]),
        .I5(Q[0]),
        .O(\savedvalue_reg[0]_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \leds_OBUF[0]_inst_i_7 
       (.I0(\savedvalue_reg[7]_0 [6]),
        .I1(Q[2]),
        .I2(\savedvalue_reg[7]_0 [2]),
        .O(\leds_OBUF[0]_inst_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFCFCFA0A0C0CFA0A)) 
    \leds_OBUF[1]_inst_i_5 
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
    \leds_OBUF[2]_inst_i_6 
       (.I0(\savedvalue_reg[7]_0 [4]),
        .I1(Q[1]),
        .I2(\savedvalue_reg[7]_0 [6]),
        .I3(Q[2]),
        .I4(\savedvalue_reg[7]_0 [2]),
        .O(\savedvalue_reg[4]_0 ));
  LUT5 #(
    .INIT(32'h33B800B8)) 
    \leds_OBUF[3]_inst_i_11 
       (.I0(\savedvalue_reg[7]_0 [5]),
        .I1(Q[1]),
        .I2(\savedvalue_reg[7]_0 [3]),
        .I3(Q[2]),
        .I4(\savedvalue_reg[7]_0 [7]),
        .O(\savedvalue_reg[5]_0 ));
  CARRY4 \leds_OBUF[3]_inst_i_5 
       (.CI(1'b0),
        .CO({\leds_OBUF[3]_inst_i_5_n_0 ,\NLW_leds_OBUF[3]_inst_i_5_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI(\savedvalue_reg[7]_0 [3:0]),
        .O(O),
        .S(S));
  LUT5 #(
    .INIT(32'h0000F8F0)) 
    \leds_OBUF[4]_inst_i_5 
       (.I0(Q[2]),
        .I1(\savedvalue_reg[7]_0 [7]),
        .I2(\leds_OBUF[4]_inst_i_6_n_0 ),
        .I3(\leds_OBUF[6]_inst_i_5 [0]),
        .I4(\leds_OBUF[6]_inst_i_5 [1]),
        .O(\savedvalue_reg[2]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h00CA)) 
    \leds_OBUF[4]_inst_i_6 
       (.I0(\savedvalue_reg[7]_0 [4]),
        .I1(\savedvalue_reg[7]_0 [6]),
        .I2(Q[1]),
        .I3(Q[2]),
        .O(\leds_OBUF[4]_inst_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h00000000ABA80B08)) 
    \leds_OBUF[5]_inst_i_5 
       (.I0(\savedvalue_reg[7]_0 [7]),
        .I1(Q[1]),
        .I2(Q[2]),
        .I3(\savedvalue_reg[7]_0 [5]),
        .I4(\leds_OBUF[6]_inst_i_5 [0]),
        .I5(\leds_OBUF[6]_inst_i_5 [1]),
        .O(\savedvalue_reg[7]_1 ));
  LUT6 #(
    .INIT(64'h00000000ABA80300)) 
    \leds_OBUF[6]_inst_i_10 
       (.I0(\savedvalue_reg[7]_0 [7]),
        .I1(Q[1]),
        .I2(Q[2]),
        .I3(\savedvalue_reg[7]_0 [6]),
        .I4(\leds_OBUF[6]_inst_i_5 [0]),
        .I5(\leds_OBUF[6]_inst_i_5 [1]),
        .O(\savedvalue_reg[7]_2 ));
  CARRY4 \leds_OBUF[7]_inst_i_7 
       (.CI(\leds_OBUF[3]_inst_i_5_n_0 ),
        .CO({\leds_OBUF[7]_inst_i_7_n_0 ,\NLW_leds_OBUF[7]_inst_i_7_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI(\savedvalue_reg[7]_0 [7:4]),
        .O(\savedvalue_reg[7]_3 ),
        .S(\leds_OBUF[4]_inst_i_3 ));
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
   (\savedvalue_reg[2]_0 ,
    \savedvalue_reg[3]_0 ,
    \savedvalue_reg[7]_0 ,
    \savedvalue_reg[0]_0 ,
    \savedvalue_reg[0]_1 ,
    \savedvalue_reg[7]_1 ,
    \savedvalue_reg[2]_1 ,
    \savedvalue_reg[0]_2 ,
    \savedvalue_reg[1]_0 ,
    S,
    \savedvalue_reg[7]_2 ,
    \leds_OBUF[3]_inst_i_1 ,
    Q,
    \leds_OBUF[0]_inst_i_1 ,
    \leds_OBUF[0]_inst_i_1_0 ,
    \leds_OBUF[6]_inst_i_5_0 ,
    \leds_OBUF[1]_inst_i_4_0 ,
    \leds_OBUF[3]_inst_i_1_0 ,
    \leds_OBUF[2]_inst_i_4_0 ,
    \leds_OBUF[6]_inst_i_1 ,
    \leds_OBUF[6]_inst_i_1_0 ,
    \leds_OBUF[0]_inst_i_1_1 ,
    E,
    D,
    CLK,
    AR);
  output \savedvalue_reg[2]_0 ;
  output \savedvalue_reg[3]_0 ;
  output [7:0]\savedvalue_reg[7]_0 ;
  output \savedvalue_reg[0]_0 ;
  output \savedvalue_reg[0]_1 ;
  output \savedvalue_reg[7]_1 ;
  output \savedvalue_reg[2]_1 ;
  output \savedvalue_reg[0]_2 ;
  output \savedvalue_reg[1]_0 ;
  output [3:0]S;
  output [3:0]\savedvalue_reg[7]_2 ;
  input \leds_OBUF[3]_inst_i_1 ;
  input [1:0]Q;
  input \leds_OBUF[0]_inst_i_1 ;
  input \leds_OBUF[0]_inst_i_1_0 ;
  input [7:0]\leds_OBUF[6]_inst_i_5_0 ;
  input \leds_OBUF[1]_inst_i_4_0 ;
  input \leds_OBUF[3]_inst_i_1_0 ;
  input \leds_OBUF[2]_inst_i_4_0 ;
  input \leds_OBUF[6]_inst_i_1 ;
  input \leds_OBUF[6]_inst_i_1_0 ;
  input \leds_OBUF[0]_inst_i_1_1 ;
  input [0:0]E;
  input [7:0]D;
  input CLK;
  input [0:0]AR;

  wire [0:0]AR;
  wire CLK;
  wire [7:0]D;
  wire [0:0]E;
  wire [1:0]Q;
  wire [3:0]S;
  wire \leds_OBUF[0]_inst_i_1 ;
  wire \leds_OBUF[0]_inst_i_1_0 ;
  wire \leds_OBUF[0]_inst_i_1_1 ;
  wire \leds_OBUF[1]_inst_i_4_0 ;
  wire \leds_OBUF[2]_inst_i_4_0 ;
  wire \leds_OBUF[2]_inst_i_5_n_0 ;
  wire \leds_OBUF[3]_inst_i_1 ;
  wire \leds_OBUF[3]_inst_i_1_0 ;
  wire \leds_OBUF[3]_inst_i_6_n_0 ;
  wire \leds_OBUF[6]_inst_i_1 ;
  wire \leds_OBUF[6]_inst_i_1_0 ;
  wire [7:0]\leds_OBUF[6]_inst_i_5_0 ;
  wire \leds_OBUF[6]_inst_i_7_n_0 ;
  wire \savedvalue_reg[0]_0 ;
  wire \savedvalue_reg[0]_1 ;
  wire \savedvalue_reg[0]_2 ;
  wire \savedvalue_reg[1]_0 ;
  wire \savedvalue_reg[2]_0 ;
  wire \savedvalue_reg[2]_1 ;
  wire \savedvalue_reg[3]_0 ;
  wire [7:0]\savedvalue_reg[7]_0 ;
  wire \savedvalue_reg[7]_1 ;
  wire [3:0]\savedvalue_reg[7]_2 ;

  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_1
       (.I0(\savedvalue_reg[7]_0 [7]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [7]),
        .O(\savedvalue_reg[7]_2 [3]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_2
       (.I0(\savedvalue_reg[7]_0 [6]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [6]),
        .O(\savedvalue_reg[7]_2 [2]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_3
       (.I0(\savedvalue_reg[7]_0 [5]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [5]),
        .O(\savedvalue_reg[7]_2 [1]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_4
       (.I0(\savedvalue_reg[7]_0 [4]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [4]),
        .O(\savedvalue_reg[7]_2 [0]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_1
       (.I0(\savedvalue_reg[7]_0 [3]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [3]),
        .O(S[3]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_2
       (.I0(\savedvalue_reg[7]_0 [2]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [2]),
        .O(S[2]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_3
       (.I0(\savedvalue_reg[7]_0 [1]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [1]),
        .O(S[1]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_4
       (.I0(\savedvalue_reg[7]_0 [0]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [0]),
        .O(S[0]));
  LUT6 #(
    .INIT(64'h0808080808000000)) 
    \leds_OBUF[0]_inst_i_3 
       (.I0(\savedvalue_reg[3]_0 ),
        .I1(\leds_OBUF[0]_inst_i_1_0 ),
        .I2(Q[1]),
        .I3(\leds_OBUF[0]_inst_i_1 ),
        .I4(\savedvalue_reg[7]_0 [0]),
        .I5(\leds_OBUF[0]_inst_i_1_1 ),
        .O(\savedvalue_reg[2]_1 ));
  LUT6 #(
    .INIT(64'hFFAABAAAAAAABAAA)) 
    \leds_OBUF[1]_inst_i_4 
       (.I0(\leds_OBUF[3]_inst_i_1 ),
        .I1(Q[1]),
        .I2(\leds_OBUF[0]_inst_i_1 ),
        .I3(\savedvalue_reg[3]_0 ),
        .I4(\savedvalue_reg[7]_0 [0]),
        .I5(\leds_OBUF[2]_inst_i_5_n_0 ),
        .O(\savedvalue_reg[2]_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA8A008000)) 
    \leds_OBUF[2]_inst_i_4 
       (.I0(\leds_OBUF[0]_inst_i_1_0 ),
        .I1(\leds_OBUF[3]_inst_i_6_n_0 ),
        .I2(\savedvalue_reg[7]_0 [0]),
        .I3(\savedvalue_reg[3]_0 ),
        .I4(\leds_OBUF[2]_inst_i_5_n_0 ),
        .I5(\leds_OBUF[3]_inst_i_1 ),
        .O(\savedvalue_reg[0]_0 ));
  LUT6 #(
    .INIT(64'h00000000FF80FF00)) 
    \leds_OBUF[2]_inst_i_5 
       (.I0(\savedvalue_reg[7]_0 [1]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [7]),
        .I2(\savedvalue_reg[7]_0 [2]),
        .I3(\leds_OBUF[1]_inst_i_4_0 ),
        .I4(Q[0]),
        .I5(Q[1]),
        .O(\leds_OBUF[2]_inst_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAA0800080)) 
    \leds_OBUF[3]_inst_i_4 
       (.I0(\leds_OBUF[0]_inst_i_1_0 ),
        .I1(\leds_OBUF[3]_inst_i_6_n_0 ),
        .I2(\savedvalue_reg[3]_0 ),
        .I3(\savedvalue_reg[7]_0 [0]),
        .I4(\leds_OBUF[3]_inst_i_1_0 ),
        .I5(\leds_OBUF[3]_inst_i_1 ),
        .O(\savedvalue_reg[0]_1 ));
  LUT6 #(
    .INIT(64'h00000000FF80FF00)) 
    \leds_OBUF[3]_inst_i_6 
       (.I0(\savedvalue_reg[7]_0 [1]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [7]),
        .I2(\savedvalue_reg[7]_0 [2]),
        .I3(\leds_OBUF[2]_inst_i_4_0 ),
        .I4(Q[0]),
        .I5(Q[1]),
        .O(\leds_OBUF[3]_inst_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEAFFC0C0EA00C0C0)) 
    \leds_OBUF[6]_inst_i_5 
       (.I0(\leds_OBUF[6]_inst_i_7_n_0 ),
        .I1(\leds_OBUF[6]_inst_i_5_0 [7]),
        .I2(\leds_OBUF[6]_inst_i_1 ),
        .I3(\savedvalue_reg[7]_0 [0]),
        .I4(\savedvalue_reg[3]_0 ),
        .I5(\leds_OBUF[6]_inst_i_1_0 ),
        .O(\savedvalue_reg[7]_1 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \leds_OBUF[6]_inst_i_7 
       (.I0(Q[1]),
        .I1(\leds_OBUF[6]_inst_i_5_0 [7]),
        .I2(\savedvalue_reg[7]_0 [2]),
        .I3(\savedvalue_reg[7]_0 [1]),
        .O(\leds_OBUF[6]_inst_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \leds_OBUF[6]_inst_i_9 
       (.I0(\savedvalue_reg[7]_0 [3]),
        .I1(\savedvalue_reg[7]_0 [4]),
        .I2(\savedvalue_reg[7]_0 [5]),
        .I3(\savedvalue_reg[7]_0 [7]),
        .I4(\savedvalue_reg[7]_0 [6]),
        .O(\savedvalue_reg[3]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \leds_OBUF[7]_inst_i_5 
       (.I0(\savedvalue_reg[7]_0 [1]),
        .I1(\savedvalue_reg[7]_0 [2]),
        .O(\savedvalue_reg[1]_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \leds_OBUF[7]_inst_i_6 
       (.I0(\savedvalue_reg[7]_0 [0]),
        .I1(\savedvalue_reg[7]_0 [6]),
        .I2(\savedvalue_reg[7]_0 [7]),
        .I3(\savedvalue_reg[7]_0 [5]),
        .I4(\savedvalue_reg[7]_0 [4]),
        .I5(\savedvalue_reg[7]_0 [3]),
        .O(\savedvalue_reg[0]_2 ));
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
module register__parameterized0
   (leds_OBUF,
    \savedvalue_reg[5]_0 ,
    Q,
    \savedvalue_reg[7] ,
    \savedvalue_reg[5]_1 ,
    \savedvalue_reg[0]_0 ,
    \leds[1] ,
    \leds[2] ,
    \leds[3] ,
    \leds_OBUF[5]_inst_i_1_0 ,
    \leds_OBUF[7]_inst_i_1_0 ,
    \leds_OBUF[3]_inst_i_4 ,
    \leds_OBUF[4]_inst_i_1_0 ,
    \leds_OBUF[5]_inst_i_1_1 ,
    \leds[6] ,
    \leds[0] ,
    \leds_OBUF[3]_inst_i_4_0 ,
    O,
    \leds_OBUF[7]_inst_i_1_1 ,
    \leds_OBUF[3]_inst_i_1_0 ,
    \leds_OBUF[7]_inst_i_1_2 ,
    \leds_OBUF[7]_inst_i_1_3 ,
    \leds_OBUF[7]_inst_i_1_4 ,
    E,
    D,
    CLK,
    AR);
  output [7:0]leds_OBUF;
  output \savedvalue_reg[5]_0 ;
  output [2:0]Q;
  output \savedvalue_reg[7] ;
  output \savedvalue_reg[5]_1 ;
  output \savedvalue_reg[0]_0 ;
  input \leds[1] ;
  input \leds[2] ;
  input \leds[3] ;
  input \leds_OBUF[5]_inst_i_1_0 ;
  input [7:0]\leds_OBUF[7]_inst_i_1_0 ;
  input \leds_OBUF[3]_inst_i_4 ;
  input \leds_OBUF[4]_inst_i_1_0 ;
  input \leds_OBUF[5]_inst_i_1_1 ;
  input \leds[6] ;
  input \leds[0] ;
  input [7:0]\leds_OBUF[3]_inst_i_4_0 ;
  input [3:0]O;
  input [3:0]\leds_OBUF[7]_inst_i_1_1 ;
  input [3:0]\leds_OBUF[3]_inst_i_1_0 ;
  input [3:0]\leds_OBUF[7]_inst_i_1_2 ;
  input \leds_OBUF[7]_inst_i_1_3 ;
  input \leds_OBUF[7]_inst_i_1_4 ;
  input [0:0]E;
  input [5:0]D;
  input CLK;
  input [0:0]AR;

  wire [0:0]AR;
  wire CLK;
  wire [5:0]D;
  wire [0:0]E;
  wire [3:0]O;
  wire [5:3]Op;
  wire [2:0]Q;
  wire \leds[0] ;
  wire \leds[1] ;
  wire \leds[2] ;
  wire \leds[3] ;
  wire \leds[6] ;
  wire [7:0]leds_OBUF;
  wire \leds_OBUF[0]_inst_i_4_n_0 ;
  wire \leds_OBUF[0]_inst_i_5_n_0 ;
  wire \leds_OBUF[1]_inst_i_2_n_0 ;
  wire \leds_OBUF[1]_inst_i_3_n_0 ;
  wire \leds_OBUF[2]_inst_i_2_n_0 ;
  wire \leds_OBUF[2]_inst_i_3_n_0 ;
  wire [3:0]\leds_OBUF[3]_inst_i_1_0 ;
  wire \leds_OBUF[3]_inst_i_2_n_0 ;
  wire \leds_OBUF[3]_inst_i_3_n_0 ;
  wire \leds_OBUF[3]_inst_i_4 ;
  wire [7:0]\leds_OBUF[3]_inst_i_4_0 ;
  wire \leds_OBUF[4]_inst_i_1_0 ;
  wire \leds_OBUF[4]_inst_i_2_n_0 ;
  wire \leds_OBUF[4]_inst_i_3_n_0 ;
  wire \leds_OBUF[4]_inst_i_4_n_0 ;
  wire \leds_OBUF[5]_inst_i_1_0 ;
  wire \leds_OBUF[5]_inst_i_1_1 ;
  wire \leds_OBUF[5]_inst_i_2_n_0 ;
  wire \leds_OBUF[5]_inst_i_3_n_0 ;
  wire \leds_OBUF[5]_inst_i_4_n_0 ;
  wire \leds_OBUF[6]_inst_i_2_n_0 ;
  wire \leds_OBUF[6]_inst_i_3_n_0 ;
  wire \leds_OBUF[6]_inst_i_4_n_0 ;
  wire [7:0]\leds_OBUF[7]_inst_i_1_0 ;
  wire [3:0]\leds_OBUF[7]_inst_i_1_1 ;
  wire [3:0]\leds_OBUF[7]_inst_i_1_2 ;
  wire \leds_OBUF[7]_inst_i_1_3 ;
  wire \leds_OBUF[7]_inst_i_1_4 ;
  wire \leds_OBUF[7]_inst_i_2_n_0 ;
  wire \leds_OBUF[7]_inst_i_3_n_0 ;
  wire \leds_OBUF[7]_inst_i_4_n_0 ;
  wire \savedvalue_reg[0]_0 ;
  wire \savedvalue_reg[5]_0 ;
  wire \savedvalue_reg[5]_1 ;
  wire \savedvalue_reg[7] ;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    carry_reg_i_2
       (.I0(Op[5]),
        .I1(Op[3]),
        .I2(Op[4]),
        .I3(Q[0]),
        .I4(Q[2]),
        .O(\savedvalue_reg[5]_1 ));
  LUT6 #(
    .INIT(64'hFFFFFFF8F8F8F8F8)) 
    \leds_OBUF[0]_inst_i_1 
       (.I0(\savedvalue_reg[7] ),
        .I1(\savedvalue_reg[5]_0 ),
        .I2(\leds[0] ),
        .I3(\leds_OBUF[0]_inst_i_4_n_0 ),
        .I4(\leds_OBUF[0]_inst_i_5_n_0 ),
        .I5(\leds_OBUF[6]_inst_i_4_n_0 ),
        .O(leds_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0008)) 
    \leds_OBUF[0]_inst_i_2 
       (.I0(\leds_OBUF[3]_inst_i_4_0 [7]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(\leds_OBUF[3]_inst_i_4 ),
        .O(\savedvalue_reg[7] ));
  LUT6 #(
    .INIT(64'h1E0020F01E002000)) 
    \leds_OBUF[0]_inst_i_4 
       (.I0(\leds_OBUF[7]_inst_i_1_0 [0]),
        .I1(\leds_OBUF[3]_inst_i_4_0 [0]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(O[0]),
        .O(\leds_OBUF[0]_inst_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00F2000230020002)) 
    \leds_OBUF[0]_inst_i_5 
       (.I0(\leds_OBUF[3]_inst_i_1_0 [0]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(\leds_OBUF[3]_inst_i_4_0 [0]),
        .I5(\leds_OBUF[7]_inst_i_1_0 [0]),
        .O(\leds_OBUF[0]_inst_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFE0E0E0)) 
    \leds_OBUF[1]_inst_i_1 
       (.I0(\leds_OBUF[1]_inst_i_2_n_0 ),
        .I1(\leds_OBUF[1]_inst_i_3_n_0 ),
        .I2(\leds_OBUF[6]_inst_i_4_n_0 ),
        .I3(\leds[1] ),
        .I4(\savedvalue_reg[5]_0 ),
        .O(leds_OBUF[1]));
  LUT6 #(
    .INIT(64'h1E0020F01E002000)) 
    \leds_OBUF[1]_inst_i_2 
       (.I0(\leds_OBUF[7]_inst_i_1_0 [1]),
        .I1(\leds_OBUF[3]_inst_i_4_0 [1]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(O[1]),
        .O(\leds_OBUF[1]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00F2000230020002)) 
    \leds_OBUF[1]_inst_i_3 
       (.I0(\leds_OBUF[3]_inst_i_1_0 [1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(\leds_OBUF[3]_inst_i_4_0 [1]),
        .I5(\leds_OBUF[7]_inst_i_1_0 [1]),
        .O(\leds_OBUF[1]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000E0000)) 
    \leds_OBUF[2]_inst_i_1 
       (.I0(\leds_OBUF[2]_inst_i_2_n_0 ),
        .I1(\leds_OBUF[2]_inst_i_3_n_0 ),
        .I2(Op[4]),
        .I3(Op[3]),
        .I4(Op[5]),
        .I5(\leds[2] ),
        .O(leds_OBUF[2]));
  LUT6 #(
    .INIT(64'h1E0020F01E002000)) 
    \leds_OBUF[2]_inst_i_2 
       (.I0(\leds_OBUF[7]_inst_i_1_0 [2]),
        .I1(\leds_OBUF[3]_inst_i_4_0 [2]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(O[2]),
        .O(\leds_OBUF[2]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00F2000230020002)) 
    \leds_OBUF[2]_inst_i_3 
       (.I0(\leds_OBUF[3]_inst_i_1_0 [2]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(\leds_OBUF[3]_inst_i_4_0 [2]),
        .I5(\leds_OBUF[7]_inst_i_1_0 [2]),
        .O(\leds_OBUF[2]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000E0000)) 
    \leds_OBUF[3]_inst_i_1 
       (.I0(\leds_OBUF[3]_inst_i_2_n_0 ),
        .I1(\leds_OBUF[3]_inst_i_3_n_0 ),
        .I2(Op[4]),
        .I3(Op[3]),
        .I4(Op[5]),
        .I5(\leds[3] ),
        .O(leds_OBUF[3]));
  LUT6 #(
    .INIT(64'h1E0020F01E002000)) 
    \leds_OBUF[3]_inst_i_2 
       (.I0(\leds_OBUF[7]_inst_i_1_0 [3]),
        .I1(\leds_OBUF[3]_inst_i_4_0 [3]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(O[3]),
        .O(\leds_OBUF[3]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00F2000230020002)) 
    \leds_OBUF[3]_inst_i_3 
       (.I0(\leds_OBUF[3]_inst_i_1_0 [3]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(\leds_OBUF[3]_inst_i_4_0 [3]),
        .I5(\leds_OBUF[7]_inst_i_1_0 [3]),
        .O(\leds_OBUF[3]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000E0000)) 
    \leds_OBUF[4]_inst_i_1 
       (.I0(\leds_OBUF[4]_inst_i_2_n_0 ),
        .I1(\leds_OBUF[4]_inst_i_3_n_0 ),
        .I2(Op[4]),
        .I3(Op[3]),
        .I4(Op[5]),
        .I5(\leds_OBUF[4]_inst_i_4_n_0 ),
        .O(leds_OBUF[4]));
  LUT6 #(
    .INIT(64'h1E0020F01E002000)) 
    \leds_OBUF[4]_inst_i_2 
       (.I0(\leds_OBUF[7]_inst_i_1_0 [4]),
        .I1(\leds_OBUF[3]_inst_i_4_0 [4]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(\leds_OBUF[7]_inst_i_1_1 [0]),
        .O(\leds_OBUF[4]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00F2000230020002)) 
    \leds_OBUF[4]_inst_i_3 
       (.I0(\leds_OBUF[7]_inst_i_1_2 [0]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(\leds_OBUF[3]_inst_i_4_0 [4]),
        .I5(\leds_OBUF[7]_inst_i_1_0 [4]),
        .O(\leds_OBUF[4]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA8A008000)) 
    \leds_OBUF[4]_inst_i_4 
       (.I0(\savedvalue_reg[5]_0 ),
        .I1(\leds_OBUF[5]_inst_i_1_0 ),
        .I2(\leds_OBUF[7]_inst_i_1_0 [0]),
        .I3(\leds_OBUF[3]_inst_i_4 ),
        .I4(\leds_OBUF[4]_inst_i_1_0 ),
        .I5(\savedvalue_reg[7] ),
        .O(\leds_OBUF[4]_inst_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000E0000)) 
    \leds_OBUF[5]_inst_i_1 
       (.I0(\leds_OBUF[5]_inst_i_2_n_0 ),
        .I1(\leds_OBUF[5]_inst_i_3_n_0 ),
        .I2(Op[4]),
        .I3(Op[3]),
        .I4(Op[5]),
        .I5(\leds_OBUF[5]_inst_i_4_n_0 ),
        .O(leds_OBUF[5]));
  LUT6 #(
    .INIT(64'h1E0020F01E002000)) 
    \leds_OBUF[5]_inst_i_2 
       (.I0(\leds_OBUF[7]_inst_i_1_0 [5]),
        .I1(\leds_OBUF[3]_inst_i_4_0 [5]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(\leds_OBUF[7]_inst_i_1_1 [1]),
        .O(\leds_OBUF[5]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00F2000230020002)) 
    \leds_OBUF[5]_inst_i_3 
       (.I0(\leds_OBUF[7]_inst_i_1_2 [1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(\leds_OBUF[3]_inst_i_4_0 [5]),
        .I5(\leds_OBUF[7]_inst_i_1_0 [5]),
        .O(\leds_OBUF[5]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAA0800080)) 
    \leds_OBUF[5]_inst_i_4 
       (.I0(\savedvalue_reg[5]_0 ),
        .I1(\leds_OBUF[5]_inst_i_1_0 ),
        .I2(\leds_OBUF[3]_inst_i_4 ),
        .I3(\leds_OBUF[7]_inst_i_1_0 [0]),
        .I4(\leds_OBUF[5]_inst_i_1_1 ),
        .I5(\savedvalue_reg[7] ),
        .O(\leds_OBUF[5]_inst_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFE0E0E0)) 
    \leds_OBUF[6]_inst_i_1 
       (.I0(\leds_OBUF[6]_inst_i_2_n_0 ),
        .I1(\leds_OBUF[6]_inst_i_3_n_0 ),
        .I2(\leds_OBUF[6]_inst_i_4_n_0 ),
        .I3(\leds[6] ),
        .I4(\savedvalue_reg[5]_0 ),
        .O(leds_OBUF[6]));
  LUT6 #(
    .INIT(64'h1E0020F01E002000)) 
    \leds_OBUF[6]_inst_i_2 
       (.I0(\leds_OBUF[7]_inst_i_1_0 [6]),
        .I1(\leds_OBUF[3]_inst_i_4_0 [6]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(\leds_OBUF[7]_inst_i_1_1 [2]),
        .O(\leds_OBUF[6]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00F2000230020002)) 
    \leds_OBUF[6]_inst_i_3 
       (.I0(\leds_OBUF[7]_inst_i_1_2 [2]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(\leds_OBUF[3]_inst_i_4_0 [6]),
        .I5(\leds_OBUF[7]_inst_i_1_0 [6]),
        .O(\leds_OBUF[6]_inst_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h10)) 
    \leds_OBUF[6]_inst_i_4 
       (.I0(Op[4]),
        .I1(Op[3]),
        .I2(Op[5]),
        .O(\leds_OBUF[6]_inst_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \leds_OBUF[6]_inst_i_6 
       (.I0(Op[5]),
        .I1(Q[1]),
        .I2(Op[4]),
        .I3(Op[3]),
        .O(\savedvalue_reg[5]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \leds_OBUF[6]_inst_i_8 
       (.I0(Q[0]),
        .I1(Q[2]),
        .O(\savedvalue_reg[0]_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAFEAAAAAAAA)) 
    \leds_OBUF[7]_inst_i_1 
       (.I0(\leds_OBUF[7]_inst_i_2_n_0 ),
        .I1(\leds_OBUF[7]_inst_i_3_n_0 ),
        .I2(\leds_OBUF[7]_inst_i_4_n_0 ),
        .I3(Op[4]),
        .I4(Op[3]),
        .I5(Op[5]),
        .O(leds_OBUF[7]));
  LUT6 #(
    .INIT(64'h00F0001000000000)) 
    \leds_OBUF[7]_inst_i_2 
       (.I0(\leds_OBUF[7]_inst_i_1_3 ),
        .I1(\leds_OBUF[7]_inst_i_1_4 ),
        .I2(\savedvalue_reg[5]_0 ),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(\leds_OBUF[3]_inst_i_4_0 [7]),
        .O(\leds_OBUF[7]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h1E0020F01E002000)) 
    \leds_OBUF[7]_inst_i_3 
       (.I0(\leds_OBUF[7]_inst_i_1_0 [7]),
        .I1(\leds_OBUF[3]_inst_i_4_0 [7]),
        .I2(Q[1]),
        .I3(Q[2]),
        .I4(Q[0]),
        .I5(\leds_OBUF[7]_inst_i_1_1 [3]),
        .O(\leds_OBUF[7]_inst_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00F2000230020002)) 
    \leds_OBUF[7]_inst_i_4 
       (.I0(\leds_OBUF[7]_inst_i_1_2 [3]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[1]),
        .I4(\leds_OBUF[3]_inst_i_4_0 [7]),
        .I5(\leds_OBUF[7]_inst_i_1_0 [7]),
        .O(\leds_OBUF[7]_inst_i_4_n_0 ));
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
        .Q(Op[3]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[4] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[4]),
        .Q(Op[4]));
  FDCE #(
    .INIT(1'b0)) 
    \savedvalue_reg[5] 
       (.C(CLK),
        .CE(E),
        .CLR(AR),
        .D(D[5]),
        .Q(Op[5]));
endmodule

(* ECO_CHECKSUM = "6323154b" *) 
(* NotValidForBitStream *)
(* \DesignAttr:ENABLE_NOC_NETLIST_VIEW  *) 
(* \DesignAttr:ENABLE_AIE_NETLIST_VIEW  *) 
module top
   (clk,
    reset,
    enA,
    enB,
    enOp,
    switches,
    leds,
    zero_led,
    carry_led);
  input clk;
  input reset;
  input enA;
  input enB;
  input enOp;
  input [7:0]switches;
  output [7:0]leds;
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
  wire A_reg_n_9;
  wire [7:0]B;
  wire B_reg_n_0;
  wire B_reg_n_1;
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
  wire [2:0]Op;
  wire Op_reg_n_12;
  wire Op_reg_n_13;
  wire Op_reg_n_14;
  wire Op_reg_n_8;
  wire alu0_n_1;
  wire alu0_n_10;
  wire alu0_n_11;
  wire alu0_n_12;
  wire alu0_n_13;
  wire alu0_n_14;
  wire alu0_n_15;
  wire alu0_n_16;
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
  wire data0;
  wire enA;
  wire enA_IBUF;
  wire enB;
  wire enB_IBUF;
  wire enOp;
  wire enOp_IBUF;
  wire [7:0]leds;
  wire [7:0]leds_OBUF;
  wire reset;
  wire reset_IBUF;
  wire [7:0]switches;
  wire [7:0]switches_IBUF;
  wire zero_led;

  register A_reg
       (.AR(reset_IBUF),
        .CLK(clk_IBUF_BUFG),
        .CO(data0),
        .D(switches_IBUF),
        .E(enA_IBUF),
        .O({A_reg_n_15,A_reg_n_16,A_reg_n_17,A_reg_n_18}),
        .Q(B[2:0]),
        .S({alu0_n_9,alu0_n_10,alu0_n_11,alu0_n_12}),
        .\leds_OBUF[4]_inst_i_3 ({alu0_n_13,alu0_n_14,alu0_n_15,alu0_n_16}),
        .\leds_OBUF[6]_inst_i_5 ({Op[2],Op[0]}),
        .\savedvalue_reg[0]_0 (A_reg_n_11),
        .\savedvalue_reg[1]_0 (A_reg_n_12),
        .\savedvalue_reg[2]_0 (A_reg_n_0),
        .\savedvalue_reg[4]_0 (A_reg_n_13),
        .\savedvalue_reg[5]_0 (A_reg_n_14),
        .\savedvalue_reg[7]_0 (A),
        .\savedvalue_reg[7]_1 (A_reg_n_9),
        .\savedvalue_reg[7]_2 (A_reg_n_10),
        .\savedvalue_reg[7]_3 ({A_reg_n_19,A_reg_n_20,A_reg_n_21,A_reg_n_22}));
  register_0 B_reg
       (.AR(reset_IBUF),
        .CLK(clk_IBUF_BUFG),
        .D(switches_IBUF),
        .E(enB_IBUF),
        .Q({Op[2],Op[0]}),
        .S({B_reg_n_16,B_reg_n_17,B_reg_n_18,B_reg_n_19}),
        .\leds_OBUF[0]_inst_i_1 (A_reg_n_12),
        .\leds_OBUF[0]_inst_i_1_0 (Op_reg_n_8),
        .\leds_OBUF[0]_inst_i_1_1 (A_reg_n_11),
        .\leds_OBUF[1]_inst_i_4_0 (A_reg_n_13),
        .\leds_OBUF[2]_inst_i_4_0 (A_reg_n_14),
        .\leds_OBUF[3]_inst_i_1 (Op_reg_n_12),
        .\leds_OBUF[3]_inst_i_1_0 (A_reg_n_0),
        .\leds_OBUF[6]_inst_i_1 (Op_reg_n_14),
        .\leds_OBUF[6]_inst_i_1_0 (A_reg_n_10),
        .\leds_OBUF[6]_inst_i_5_0 (A),
        .\savedvalue_reg[0]_0 (B_reg_n_10),
        .\savedvalue_reg[0]_1 (B_reg_n_11),
        .\savedvalue_reg[0]_2 (B_reg_n_14),
        .\savedvalue_reg[1]_0 (B_reg_n_15),
        .\savedvalue_reg[2]_0 (B_reg_n_0),
        .\savedvalue_reg[2]_1 (B_reg_n_13),
        .\savedvalue_reg[3]_0 (B_reg_n_1),
        .\savedvalue_reg[7]_0 (B),
        .\savedvalue_reg[7]_1 (B_reg_n_12),
        .\savedvalue_reg[7]_2 ({B_reg_n_20,B_reg_n_21,B_reg_n_22,B_reg_n_23}));
  register__parameterized0 Op_reg
       (.AR(reset_IBUF),
        .CLK(clk_IBUF_BUFG),
        .D(switches_IBUF[5:0]),
        .E(enOp_IBUF),
        .O({alu0_n_1,alu0_n_2,alu0_n_3,alu0_n_4}),
        .Q(Op),
        .\leds[0] (B_reg_n_13),
        .\leds[1] (B_reg_n_0),
        .\leds[2] (B_reg_n_10),
        .\leds[3] (B_reg_n_11),
        .\leds[6] (B_reg_n_12),
        .leds_OBUF(leds_OBUF),
        .\leds_OBUF[3]_inst_i_1_0 ({A_reg_n_15,A_reg_n_16,A_reg_n_17,A_reg_n_18}),
        .\leds_OBUF[3]_inst_i_4 (B_reg_n_1),
        .\leds_OBUF[3]_inst_i_4_0 (A),
        .\leds_OBUF[4]_inst_i_1_0 (A_reg_n_0),
        .\leds_OBUF[5]_inst_i_1_0 (A_reg_n_9),
        .\leds_OBUF[5]_inst_i_1_1 (A_reg_n_10),
        .\leds_OBUF[7]_inst_i_1_0 (B),
        .\leds_OBUF[7]_inst_i_1_1 ({alu0_n_5,alu0_n_6,alu0_n_7,alu0_n_8}),
        .\leds_OBUF[7]_inst_i_1_2 ({A_reg_n_19,A_reg_n_20,A_reg_n_21,A_reg_n_22}),
        .\leds_OBUF[7]_inst_i_1_3 (B_reg_n_15),
        .\leds_OBUF[7]_inst_i_1_4 (B_reg_n_14),
        .\savedvalue_reg[0]_0 (Op_reg_n_14),
        .\savedvalue_reg[5]_0 (Op_reg_n_8),
        .\savedvalue_reg[5]_1 (Op_reg_n_13),
        .\savedvalue_reg[7] (Op_reg_n_12));
  alu alu0
       (.CO(data0),
        .O({alu0_n_1,alu0_n_2,alu0_n_3,alu0_n_4}),
        .Q(Op[1]),
        .S({B_reg_n_16,B_reg_n_17,B_reg_n_18,B_reg_n_19}),
        .carry_led(Op_reg_n_13),
        .carry_led_OBUF(carry_led_OBUF),
        .\leds_OBUF[4]_inst_i_2 ({B_reg_n_20,B_reg_n_21,B_reg_n_22,B_reg_n_23}),
        .\leds_OBUF[7]_inst_i_7 (A),
        .\leds_OBUF[7]_inst_i_7_0 (B),
        .\savedvalue_reg[3] ({alu0_n_9,alu0_n_10,alu0_n_11,alu0_n_12}),
        .\savedvalue_reg[7] ({alu0_n_5,alu0_n_6,alu0_n_7,alu0_n_8}),
        .\savedvalue_reg[7]_0 ({alu0_n_13,alu0_n_14,alu0_n_15,alu0_n_16}));
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
  OBUF \leds_OBUF[0]_inst 
       (.I(leds_OBUF[0]),
        .O(leds[0]));
  OBUF \leds_OBUF[1]_inst 
       (.I(leds_OBUF[1]),
        .O(leds[1]));
  OBUF \leds_OBUF[2]_inst 
       (.I(leds_OBUF[2]),
        .O(leds[2]));
  OBUF \leds_OBUF[3]_inst 
       (.I(leds_OBUF[3]),
        .O(leds[3]));
  OBUF \leds_OBUF[4]_inst 
       (.I(leds_OBUF[4]),
        .O(leds[4]));
  OBUF \leds_OBUF[5]_inst 
       (.I(leds_OBUF[5]),
        .O(leds[5]));
  OBUF \leds_OBUF[6]_inst 
       (.I(leds_OBUF[6]),
        .O(leds[6]));
  OBUF \leds_OBUF[7]_inst 
       (.I(leds_OBUF[7]),
        .O(leds[7]));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
  IBUF \switches_IBUF[0]_inst 
       (.I(switches[0]),
        .O(switches_IBUF[0]));
  IBUF \switches_IBUF[1]_inst 
       (.I(switches[1]),
        .O(switches_IBUF[1]));
  IBUF \switches_IBUF[2]_inst 
       (.I(switches[2]),
        .O(switches_IBUF[2]));
  IBUF \switches_IBUF[3]_inst 
       (.I(switches[3]),
        .O(switches_IBUF[3]));
  IBUF \switches_IBUF[4]_inst 
       (.I(switches[4]),
        .O(switches_IBUF[4]));
  IBUF \switches_IBUF[5]_inst 
       (.I(switches[5]),
        .O(switches_IBUF[5]));
  IBUF \switches_IBUF[6]_inst 
       (.I(switches[6]),
        .O(switches_IBUF[6]));
  IBUF \switches_IBUF[7]_inst 
       (.I(switches[7]),
        .O(switches_IBUF[7]));
  OBUFT zero_led_OBUF_inst
       (.I(1'b0),
        .O(zero_led),
        .T(1'b1));
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
