----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    16:55:43 04/25/2016 
-- Design Name: 
-- Module Name:    Alu - Behavioral 
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
-- Para implementar (no register file):
-- Não afectar PSW quando se faz operações de processamento de dados e o bit "f" está activo. --IR10

-- Para implementar:
-- Flag de borrow, só activa quando não há borrow. Confirmar.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;


entity Alu is
    Port ( aluFunc : in STD_LOGIC_VECTOR(5 downto 0); -- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
			  CyBw : in STD_LOGIC; 
			  A : in STD_LOGIC_VECTOR(15 downto 0);
			  B : in STD_LOGIC_VECTOR(15 downto 0);
			  R : out STD_LOGIC_VECTOR(15 downto 0);
			  flags : out  STD_LOGIC_VECTOR(3 downto 0) -- 0-Zero 1-CyBw 2-GE 3-Parity 
		);
end Alu;

architecture Structural of Alu is

	Signal Output_shifter: STD_LOGIC_VECTOR(15 downto 0);
	Signal Output_shifter_Cy: STD_LOGIC;
	Signal Output_logico: STD_LOGIC_VECTOR(15 downto 0);
	Signal Output_aritmetico: STD_LOGIC_VECTOR(15 downto 0);
	Signal Output_aritmetico_Cy: STD_LOGIC;
	Signal Output_aritmetico_Cy: STD_LOGIC;
	Signal muxIR13out: STD_LOGIC_VECTOR(15 downto 0);
	Signal muxIR14out: STD_LOGIC_VECTOR(15 downto 0);

begin
	-----------------
	-- Logic	
	-----------------
	Logico: component Alu_logico PORT MAP(
		Input_A => A,
		Input_B => B,
		Op => (aluFunc(5) AND aluFunc(2)) & (aluFunc(5) AND aluFunc(1)),
		Output => Output_logico);								
		
	-----------------
	-- BarrelShifter
	-----------------
	Shifter: component Barrel_shift PORT MAP( 
		A => A,
		B => B(3 downto 0),
		Ctl_3bit => (aluFunc(5) AND aluFunc(2)) & (aluFunc(5) AND aluFunc(1)) & (aluFunc(5) AND aluFunc(0)), -- IR12 IR11 IR10
		Output => Output_shifter,
		Cy => Output_shifter_Cy);

	-----------------
	-- Aritmetic
	-----------------		
	Aritmetico: component Alu_aritmetico PORT MAP( 
		A => A,
		B => B,
		Cin => CyBw,													--op(0)=IR15 AND IR12 / op(1)=IR15 AND IR11
		Op => (aluFunc(5) AND aluFunc(2)) & (aluFunc(5) AND aluFunc(1)),
		Result => Output_aritmetico,
		Flags_out => Output_aritmetico_Cy & Output_aritmetico_GE); --Flags_out(0)=GE / Flags_out(1)=Cy
		
	-----------------
	-- Result
	-----------------
	muxIR13: component MUX1x16bits port map(
		Sel => aluFunc(3),
		In0 => Output_logico,
      In1 => Output_shifter,	
      outdata => muxIR13out);
		
	muxIR14: component MUX1x16bits port map(
		Sel => aluFunc(5) AND aluFunc(4), -- IR15 AND IR14
		In0 => Output_aritmetico,
      In1 => muxIR13out,	
      outdata => R);
		
	-----------------
	-- Flags
	-----------------	
		--zero
	flags(0) <= NOT(R(0) OR R(1) OR R(2) OR R(3) OR R(4) OR R(5) OR R(6) OR R(7) OR R(8) OR R(9) OR R(10) OR R(11) OR R(12) OR R(13) OR R(14) OR R(15));
		--carry/borrow
	muxCyBr: component MUX2x1bit PORT MAP(
		Sel => aluFunc (4 downto 3),
		In0 => Output_aritmetico_Cy,
		In1 => Output_aritmetico_Cy,
		In2 => CyBw,
		In3 => Output_shifter_Cy,
		outdata => flags(1));
		--GE
	flags(2) <= (Output_aritmetico_GE AND (NOT aluFunc(4)));
		--parity
	flags(3) <= R(0) XOR R(1) XOR R(2) XOR R(3) XOR R(4) XOR R(5) XOR R(6) XOR R(7) XOR R(8) XOR R(9) XOR R(10) XOR R(11) XOR R(12) XOR R(13) XOR R(14) XOR R(15);
	

end Structural;

