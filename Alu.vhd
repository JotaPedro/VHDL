----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:43 04/25/2016 
-- Design Name: 
-- Module Name:    Alu - Behavioral 
-- Project Name: 
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
use work.pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Alu is
    Port ( Oper : in  STD_LOGIC_VECTOR(3 downto 0); -- 0-IR10 1-IR11 2-IR12 3-IR13
           LnA : in  STD_LOGIC; --IR14
           B : in  bit_16; 
           A : in  bit_16;
           CyBw : in  STD_LOGIC;
           R : out  bit_16;
           flags : out  STD_LOGIC_VECTOR(3 downto 0) -- 0-Zero 1-CyBw 2-GE 3-Parity 
		);
end Alu;

architecture Behavioral of Alu is

Signal Output_shifter: bit_16;
Signal Output_shifter_Cy: STD_LOGIC;
Signal Output_logico: bit_16;
Signal Output_aritmetico: bit_16;
Signal Output_aritmetico_Cy: STD_LOGIC;
Signal Input_mp_carry: STD_LOGIC_VECTOR(3 downto 0);
Signal Mp_IR14_input: bit_16;
Signal Mp_IR14_output: bit_16;
Signal GE : STD_LOGIC;
Signal Sel_mp_carry: STD_LOGIC_VECTOR(1 downto 0);
Signal CyBw_aritm_in: STD_LOGIC;

begin
		Logico: Alu_logico PORT MAP(
			Input_B => B,
			Input_A => A,
			Op => Oper(2 downto 1),-- 1-IR11 2-IR12
			Output => Output_logico
		);
		Shifter: Barrel_shift PORT MAP( 
			A => A,
			B => B(3 downto 0),
			Output => Output_shifter,
			Ctl_3bit => Oper(2 downto 0), -- 0-IR10 1-IR11 2-IR12
			Cy => Output_shifter_Cy
		);
		
		CyBw_aritm_in <= CyBw and Oper(2); -- Se a opera��o n�o for ADDC ou SBB ent�o o carry que entra no bloco aritmetico � sempre zero.
		
		aritmetico: Alu_aritmetico PORT MAP( 
			A => A,
			B => B,
			Cin => CyBw_aritm_in,
			Result => Output_aritmetico,
			Flags_out(1) => Output_aritmetico_Cy,
			Flags_out(0) => GE,
			Op => Oper(1)
		);
		
		Input_mp_carry(0) <= Output_aritmetico_Cy;
		Input_mp_carry(1) <= Output_aritmetico_Cy;
		Input_mp_carry(2) <= CyBw;
		Input_mp_carry(3) <= Output_shifter_Cy;
		Sel_mp_carry <= LnA & Oper(3);
		Mp_carry: Mplex4to1 PORT MAP(
			Input => Input_mp_carry,
			Sel => Sel_mp_carry,-- IR14, 13
			Output => flags(1) --CyBw
		);
		--GE
		flags(2) <= (GE and (not Oper(0))); --Carry in AND (NOT IR14)
		
		Mp_IR13: Mplex16bit_2to1 PORT MAP(
			Input_port(0) => Output_logico,
			Input_port(1) => Output_shifter,
			Selector_MP => Oper(3),--IR13
			Output_port => Mp_IR14_input
		);
		Mp_IR14: Mplex16bit_2to1 PORT MAP(
			Input_port(0) => Output_aritmetico,
			Input_port(1) => Mp_IR14_input,
			Selector_MP => LnA,--IR14
			Output_port => Mp_IR14_output
		);
		--Paridade
		flags(3) <= Mp_IR14_output(0) XOR Mp_IR14_output(1) XOR Mp_IR14_output(2) XOR Mp_IR14_output(3) XOR Mp_IR14_output(4) XOR Mp_IR14_output(5) XOR Mp_IR14_output(6) XOR Mp_IR14_output(7) XOR Mp_IR14_output(8) XOR Mp_IR14_output(9) XOR Mp_IR14_output(10) XOR Mp_IR14_output(11) XOR Mp_IR14_output(12) XOR Mp_IR14_output(13) XOR Mp_IR14_output(14) XOR Mp_IR14_output(15);
		--Zero
		flags(0) <= NOT(Mp_IR14_output(0) OR Mp_IR14_output(1) OR Mp_IR14_output(2) OR Mp_IR14_output(3) OR Mp_IR14_output(4) OR Mp_IR14_output(5) OR Mp_IR14_output(6) OR Mp_IR14_output(7) OR Mp_IR14_output(8) OR Mp_IR14_output(9) OR Mp_IR14_output(10) OR Mp_IR14_output(11) OR Mp_IR14_output(12) OR Mp_IR14_output(13) OR Mp_IR14_output(14) OR Mp_IR14_output(15)); 
		
		R <= Mp_IR14_output;


end Behavioral;

