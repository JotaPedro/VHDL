----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:43:33 08/10/2016 
-- Design Name: 
-- Module Name:    Block_Mplex16to1 - Behavioral 
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

entity Block_Mplex16to1 is
	 Port ( A : in  bit_16;
           Mp2to1_in : out  bit_16;
           B_negativo : in  STD_LOGIC_VECTOR(3 downto 0));
end Block_Mplex16to1;

architecture Behavioral of Block_Mplex16to1 is

Signal Mplex16to1_input: bit_16_array(15 downto 0); --array de 2D 16x16 - entradas dos multiplexers 16to1

begin

			---------------------Preparar input para os multiplexers------------------------------
			Mplex16to1_input(15)	<= A;
			Mplex16to1_input(14)	<= A(14 downto 0) & A(15);
			Mplex16to1_input(0)	<= A(0) & A(15 downto 1);
			--Loop para gerar input de 1 até ao 13
			Mplex16to1_input_for:
			for i in 2 to 14 generate
				Mplex16to1_input(i-1) <=(A(i-1 downto 0) & A(15 downto i));
			end generate;
			--------------------------------------------------------------------------------------

			-----------------------multiplexers------------------------------
--			Mp0: Mplex16to1 PORT MAP(
--				Input => Mplex16to1_input(0),
--				Sel => B_negativo,
--				Output => Mp2to1_in(0)
--			);
--			Mp1: Mplex16to1 PORT MAP(
--				Input => Mplex16to1_input(1),
--				Sel => B_negativo,
--				Output => Mp2to1_in(1)
--			);
--			Mp15: Mplex16to1 PORT MAP(
--				Input => Mplex16to1_input(15),
--				Sel => B_negativo,
--				Output => Mp2to1_in(15)
--			);	
			Mplex16to1_generate:
			for i in 0 to 15 generate
				Mp_intermedios: Mplex16to1 PORT MAP(
					Input => Mplex16to1_input(i),
					Sel => B_negativo,
					Output => Mp2to1_in(i)
				);
			end generate;

end Behavioral;

