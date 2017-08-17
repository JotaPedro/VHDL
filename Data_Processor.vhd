----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    21:13:18 04/07/2016 
-- Design Name: 
-- Module Name:    Data_Processor - Behavioral 
-- Project Name: PDS16fpga
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
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
	Signal SigExtOut: STD_LOGIC_VECTOR(15 downto 0);
	Signal ZeroFillOut: STD_LOGIC_VECTOR(15 downto 0);

begin

	-----------------
	-- ALU
	-----------------
	ALU: component Alu PORT MAP(
		aluFunc => Func,
		CyBw => CYin,
		A => OpA,
		B => B_sig,
		R => Result,
		flags => FlagsOut);
	
	-----------------
	-- OpB Selector
	-----------------	
	muxOpB: component MUX3x16bits PORT MAP(
		Sel => Ctr,			--OpB => 0-SigExt 1-ZeroFill 2-ZeroFillx2 3-OpB 4-OpBx2
		In0 => SigExtOut,
      In1 => ZeroFillOut,
		In2 => ZeroFillOut (14 downto 0) & '0', --x2 = shift
		In3 => OpB,
		In4 => OpB (14 downto 0) & '0', --x2 = shift,
		In5 => "0000000000000000",	--entrada não utilizada
		In6 => "0000000000000000", --entrada não utilizada
		In7 => "0000000000000000", --entrada não utilizada
      outdata => B_sig);

	-----------------
	-- Const
	-----------------
	ZeroFill: component Zero_Fill PORT MAP(
		Const4bit => Const (6 downto 3), --const4
		Output16bit => Zero_Fill_out);
		
	SigExt: component  Sig_Ext PORT MAP(
		Const8x2 => Const,		--offset8
		Output16bit => SigExtOut);--: out  bit_16
			--onde se faz a multiplicaçao por 2?????
				--no interior do sigExt ou antes??????
		
	

end Behavioral;

