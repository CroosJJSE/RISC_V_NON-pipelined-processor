// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Sun Mar  3 11:50:42 2024
// Host        : kobal running 64-bit Ubuntu 22.04.4 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/subi/codes/vscode/vivado/finalRISCV/finalRISCV.gen/sources_1/bd/design_1/ip/design_1_risc_0_0/design_1_risc_0_0_stub.v
// Design      : design_1_risc_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "risc,Vivado 2022.2" *)
module design_1_risc_0_0(clk, reset, instruction, aluOut, PC, led1, led2, led3, 
  led4)
/* synthesis syn_black_box black_box_pad_pin="clk,reset,instruction[31:0],aluOut[31:0],PC[31:0],led1,led2,led3,led4" */;
  input clk;
  input reset;
  output [31:0]instruction;
  output [31:0]aluOut;
  output [31:0]PC;
  output led1;
  output led2;
  output led3;
  output led4;
endmodule
