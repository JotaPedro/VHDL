----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  ALU - Descrição Hardware

-- Description: 
--
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
	
	Signal op_logico: STD_LOGIC_VECTOR (1 downto 0);
	Signal op_shifter: STD_LOGIC_VECTOR (2 downto 0);
	Signal op_aritmetico: STD_LOGIC_VECTOR (1 downto 0);
	Signal Output_shifter: STD_LOGIC_VECTOR(15 downto 0);
	Signal shift_flag: STD_LOGIC;
	Signal Output_logico: STD_LOGIC_VECTOR(15 downto 0);
	Signal Output_aritmetico: STD_LOGIC_VECTOR(15 downto 0);
	Signal alu_flags: STD_LOGIC_VECTOR (1 downto 0);
	Signal muxIR13out: STD_LOGIC_VECTOR(15 downto 0);
	Signal sel_muxIR14: STD_LOGIC;
	Signal muxIR14out: STD_LOGIC_VECTOR(15 downto 0);
	Signal muxCyBr_out: STD_LOGIC;
	

begin
	-----------------
	-- Logic	
	-----------------
	op_logico <= (aluFunc(5) AND aluFunc(2)) & (aluFunc(5) AND aluFunc(1));
	
	Logico: component Alu_logico PORT MAP(
		Input_A => A,
		Input_B => B,
		Op => op_logico,
		Output => Output_logico);								
		
	-----------------
	-- BarrelShifter
	-----------------
	op_shifter <= (aluFunc(5) AND aluFunc(2)) & (aluFunc(5) AND aluFunc(1)) & (aluFunc(5) AND aluFunc(0)); -- IR12 IR11 IR10
	
	Shifter: component Barrel_shift PORT MAP( 
		A => A,
		B => B(3 downto 0),
		Cyin => CyBw,
		Shifter_Ctrl => op_shifter,
		Output => Output_shifter,
		Cy => shift_flag);			--Cy/Bw


	-----------------
	-- Aritmetic
	-----------------							--op(0)=IR15 AND IR12 / op(1)=IR15 AND IR11
	op_aritmetico <= (aluFunc(5) AND aluFunc(2)) & (aluFunc(5) AND aluFunc(1));
		
	Aritmetico: component Alu_aritmetico PORT MAP( 
		A => A,
		B => B,
		Cin => CyBw,			 										
		Op => op_aritmetico, 
		Result => Output_aritmetico,
		Flags_out => alu_flags);		-- 0-GE, 1-Carry
		
	-----------------
	-- Result
	-----------------
	muxIR13: component MUX1x16bits port map(
		Sel => aluFunc(3),
		In0 => Output_logico,
      In1 => Output_shifter,	
      outdata => muxIR13out);
		
		sel_muxIR14 <= aluFunc(5) AND aluFunc(4); -- IR15 AND IR14
		
	muxIR14: component MUX1x16bits port map(
		Sel => sel_muxIR14, -- IR15 AND IR14
		In0 => Output_aritmetico,
      In1 => muxIR13out,	
      outdata => muxIR14out);
		
	R <= muxIR14out;
	-----------------
	-- Flags
	-----------------	
		--zero
	flags(0) <= NOT(muxIR14out(0) OR muxIR14out(1) OR muxIR14out(2) OR muxIR14out(3) OR muxIR14out(4) OR muxIR14out(5) OR muxIR14out(6) OR muxIR14out(7) OR muxIR14out(8) OR muxIR14out(9) OR muxIR14out(10) OR muxIR14out(11) OR muxIR14out(12) OR muxIR14out(13) OR muxIR14out(14) OR muxIR14out(15));
		--carry/borrow
	muxCyBr: component MUX2x1bit PORT MAP(
		Sel => aluFunc (4 downto 3),
		In0 => alu_flags(1),		
		In1 => alu_flags(1),		
		In2 => CyBw,
		In3 => shift_flag,
		outdata => muxCyBr_out);
		
	flags(1) <= (muxCyBr_out AND (NOT aluFunc(4)));
		--GE
	flags(2) <= (alu_flags(0) AND (NOT aluFunc(4)));
		--parity
	flags(3) <= muxIR14out(0) XOR muxIR14out(1) XOR muxIR14out(2) XOR muxIR14out(3) XOR muxIR14out(4) XOR muxIR14out(5) XOR muxIR14out(6) XOR muxIR14out(7) XOR muxIR14out(8) XOR muxIR14out(9) XOR muxIR14out(10) XOR muxIR14out(11) XOR muxIR14out(12) XOR muxIR14out(13) XOR muxIR14out(14) XOR muxIR14out(15);
	

end Structural;

