----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  Jo�o Botelho n�31169
--				  Tiago Ramos  n�32125

-- Module Name:  Data_Processor - Descri��o Hardware

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
use work.pds16_types.ALL;


entity Data_Processor is
    Port ( OpA : in  STD_LOGIC_VECTOR(15 downto 0);
			  OpB : in  STD_LOGIC_VECTOR(15 downto 0);
			  CYin : in  STD_LOGIC;
			  Func : in  STD_LOGIC_VECTOR(5 downto 0);		--IR10 , 11, 12, 13, 14, 15
			  Const : in  STD_LOGIC_VECTOR(7 downto 0);
           Ctr : in  STD_LOGIC_VECTOR(2 downto 0);			--OpB => 0-SigExt 1-ZeroFill 2-ZeroFillx2 3-OpB 4-OpBx2
			  Result : out  STD_LOGIC_VECTOR(15 downto 0);
           FlagsOut : out  STD_LOGIC_VECTOR(3 downto 0)	-- 0-Zero 1-CyBw 2-GE 3-Parity 
		);
end Data_Processor;

architecture Structural of Data_Processor is

	Signal B_sig: STD_LOGIC_VECTOR(15 downto 0);
	Signal SigExt_In: STD_LOGIC_VECTOR(8 downto 0);
	Signal SigExtOut: STD_LOGIC_VECTOR(15 downto 0);
	Signal ZeroFillOut: STD_LOGIC_VECTOR(15 downto 0);
	Signal muxOpB_In2: STD_LOGIC_VECTOR(15 downto 0);
	Signal muxOpB_In4: STD_LOGIC_VECTOR(15 downto 0);


begin

	-----------------
	-- Const
	-----------------
	ZeroFill: component Zero_Fill PORT MAP(
		Const4bit => Const (6 downto 3), --const4
		Output16bit => ZeroFillOut);
		
	
	SigExt_In <= Const(7 downto 0) & '0';		--shift offset8 de forma a apontar sempre p/ word
	
	SigExt: component Sig_Ext PORT MAP(
		Const8x2 => SigExt_In,
		Output16bit => SigExtOut);		 			--: out  bit_16
				
	-----------------
	-- OpB Selector
	-----------------	
	muxOpB_In2 <= ZeroFillOut (14 downto 0) & '0'; --x2 = shift
	muxOpB_In4 <= OpB (14 downto 0) & '0'; --x2 = shift,
			-- PERGUNTAR 
	
	
	
	muxOpB: component MUX3x16bits PORT MAP(
		Sel => Ctr,			--OpB => 0-SigExt 1-ZeroFill 2-ZeroFillx2 3-OpB 4-OpBx2
		In0 => SigExtOut,
      In1 => ZeroFillOut,
		In2 => muxOpB_In2,
		In3 => OpB,
		In4 => muxOpB_In4,
		In5 => "0000000000000000",	--entrada n�o utilizada
		In6 => "0000000000000000", --entrada n�o utilizada
		In7 => "0000000000000000", --entrada n�o utilizada
      outdata => B_sig);			
				
	-----------------
	-- ALU
	-----------------
	ALU_block: component Alu PORT MAP(
		aluFunc => Func,
		CyBw => CYin,
		A => OpA,
		B => B_sig,
		R => Result, 
		flags => FlagsOut);
	
	
end Structural;