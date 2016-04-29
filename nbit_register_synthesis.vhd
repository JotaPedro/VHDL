--------------------------------------------------------------------------------
-- Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: K.39
--  \   \         Application: netgen
--  /   /         Filename: nbit_register_synthesis.vhd
-- /___/   /\     Timestamp: Sat Mar 19 15:55:52 2016
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -ar Structure -tm nbit_register -w -dir netgen/synthesis -ofmt vhdl -sim nbit_register.ngc nbit_register_synthesis.vhd 
-- Device	: xc4vlx15-12-sf363
-- Input file	: nbit_register.ngc
-- Output file	: C:\Documents and Settings\Administrator\My Documents\Dropbox\Documentos Universidade\SV1516\projecto\Trabalho\vhdl1\netgen\synthesis\nbit_register_synthesis.vhd
-- # of Entities	: 1
-- Design Name	: nbit_register
-- Xilinx	: C:\Xilinx\10.1\ISE
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Development System Reference Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity nbit_register is
  port (
    clk : in STD_LOGIC := 'X'; 
    clr : in STD_LOGIC := 'X'; 
    load : in STD_LOGIC := 'X'; 
    q : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    d : in STD_LOGIC_VECTOR ( 7 downto 0 ) 
  );
end nbit_register;

architecture Structure of nbit_register is
  signal clk_BUFGP_1 : STD_LOGIC; 
  signal clr_IBUF_3 : STD_LOGIC; 
  signal d_0_IBUF_12 : STD_LOGIC; 
  signal d_1_IBUF_13 : STD_LOGIC; 
  signal d_2_IBUF_14 : STD_LOGIC; 
  signal d_3_IBUF_15 : STD_LOGIC; 
  signal d_4_IBUF_16 : STD_LOGIC; 
  signal d_5_IBUF_17 : STD_LOGIC; 
  signal d_6_IBUF_18 : STD_LOGIC; 
  signal d_7_IBUF_19 : STD_LOGIC; 
  signal load_IBUF_21 : STD_LOGIC; 
  signal q_0_30 : STD_LOGIC; 
  signal q_1_31 : STD_LOGIC; 
  signal q_2_32 : STD_LOGIC; 
  signal q_3_33 : STD_LOGIC; 
  signal q_4_34 : STD_LOGIC; 
  signal q_5_35 : STD_LOGIC; 
  signal q_6_36 : STD_LOGIC; 
  signal q_7_37 : STD_LOGIC; 
begin
  q_0 : FDCE
    port map (
      C => clk_BUFGP_1,
      CE => load_IBUF_21,
      CLR => clr_IBUF_3,
      D => d_0_IBUF_12,
      Q => q_0_30
    );
  q_1 : FDCE
    port map (
      C => clk_BUFGP_1,
      CE => load_IBUF_21,
      CLR => clr_IBUF_3,
      D => d_1_IBUF_13,
      Q => q_1_31
    );
  q_2 : FDCE
    port map (
      C => clk_BUFGP_1,
      CE => load_IBUF_21,
      CLR => clr_IBUF_3,
      D => d_2_IBUF_14,
      Q => q_2_32
    );
  q_3 : FDCE
    port map (
      C => clk_BUFGP_1,
      CE => load_IBUF_21,
      CLR => clr_IBUF_3,
      D => d_3_IBUF_15,
      Q => q_3_33
    );
  q_4 : FDCE
    port map (
      C => clk_BUFGP_1,
      CE => load_IBUF_21,
      CLR => clr_IBUF_3,
      D => d_4_IBUF_16,
      Q => q_4_34
    );
  q_5 : FDCE
    port map (
      C => clk_BUFGP_1,
      CE => load_IBUF_21,
      CLR => clr_IBUF_3,
      D => d_5_IBUF_17,
      Q => q_5_35
    );
  q_6 : FDCE
    port map (
      C => clk_BUFGP_1,
      CE => load_IBUF_21,
      CLR => clr_IBUF_3,
      D => d_6_IBUF_18,
      Q => q_6_36
    );
  q_7 : FDCE
    port map (
      C => clk_BUFGP_1,
      CE => load_IBUF_21,
      CLR => clr_IBUF_3,
      D => d_7_IBUF_19,
      Q => q_7_37
    );
  clr_IBUF : IBUF
    port map (
      I => clr,
      O => clr_IBUF_3
    );
  load_IBUF : IBUF
    port map (
      I => load,
      O => load_IBUF_21
    );
  d_7_IBUF : IBUF
    port map (
      I => d(7),
      O => d_7_IBUF_19
    );
  d_6_IBUF : IBUF
    port map (
      I => d(6),
      O => d_6_IBUF_18
    );
  d_5_IBUF : IBUF
    port map (
      I => d(5),
      O => d_5_IBUF_17
    );
  d_4_IBUF : IBUF
    port map (
      I => d(4),
      O => d_4_IBUF_16
    );
  d_3_IBUF : IBUF
    port map (
      I => d(3),
      O => d_3_IBUF_15
    );
  d_2_IBUF : IBUF
    port map (
      I => d(2),
      O => d_2_IBUF_14
    );
  d_1_IBUF : IBUF
    port map (
      I => d(1),
      O => d_1_IBUF_13
    );
  d_0_IBUF : IBUF
    port map (
      I => d(0),
      O => d_0_IBUF_12
    );
  q_7_OBUF : OBUF
    port map (
      I => q_7_37,
      O => q(7)
    );
  q_6_OBUF : OBUF
    port map (
      I => q_6_36,
      O => q(6)
    );
  q_5_OBUF : OBUF
    port map (
      I => q_5_35,
      O => q(5)
    );
  q_4_OBUF : OBUF
    port map (
      I => q_4_34,
      O => q(4)
    );
  q_3_OBUF : OBUF
    port map (
      I => q_3_33,
      O => q(3)
    );
  q_2_OBUF : OBUF
    port map (
      I => q_2_32,
      O => q(2)
    );
  q_1_OBUF : OBUF
    port map (
      I => q_1_31,
      O => q(1)
    );
  q_0_OBUF : OBUF
    port map (
      I => q_0_30,
      O => q(0)
    );
  clk_BUFGP : BUFGP
    port map (
      I => clk,
      O => clk_BUFGP_1
    );

end Structure;

