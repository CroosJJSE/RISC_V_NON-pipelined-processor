-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Sun Mar  3 11:50:42 2024
-- Host        : kobal running 64-bit Ubuntu 22.04.4 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/subi/codes/vscode/vivado/finalRISCV/finalRISCV.gen/sources_1/bd/design_1/ip/design_1_risc_0_0/design_1_risc_0_0_stub.vhdl
-- Design      : design_1_risc_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_risc_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    instruction : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aluOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PC : out STD_LOGIC_VECTOR ( 31 downto 0 );
    led1 : out STD_LOGIC;
    led2 : out STD_LOGIC;
    led3 : out STD_LOGIC;
    led4 : out STD_LOGIC
  );

end design_1_risc_0_0;

architecture stub of design_1_risc_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,reset,instruction[31:0],aluOut[31:0],PC[31:0],led1,led2,led3,led4";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "risc,Vivado 2022.2";
begin
end;
