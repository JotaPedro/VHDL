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
	process(A)
	begin
			---------------------Preparar input para os multiplexers------------------------------
			Mplex16to1_input(15)	<= A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15);
			Mplex16to1_input(14)	<= A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14);
			Mplex16to1_input(13)	<= A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13);
			Mplex16to1_input(12)	<= A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12);
			Mplex16to1_input(11)	<= A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11);
			Mplex16to1_input(10)	<= A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10);
			Mplex16to1_input(9)	<= A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9);
			Mplex16to1_input(8)	<= A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8);
			Mplex16to1_input(7)	<= A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7);
			Mplex16to1_input(6)	<= A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6);
			Mplex16to1_input(5)	<= A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5);
			Mplex16to1_input(4)	<= A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4);
			Mplex16to1_input(3)	<= A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3);
			Mplex16to1_input(2)	<= A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2);
			Mplex16to1_input(1)	<= A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1);
			Mplex16to1_input(0)	<= A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0);
	end process;
--			Mplex16to1_input(15)	<= A(15 downto 0);
--			Mplex16to1_input(14)	<= A(14 downto 0) & A(15);
--			Mplex16to1_input(13)	<= A(13 downto 0) & A(15 downto 14);
--			Mplex16to1_input(12)	<= A(12 downto 0) & A(15 downto 13);
--			Mplex16to1_input(11)	<= A(11 downto 0) & A(15 downto 12);
--			Mplex16to1_input(10)	<= A(10 downto 0) & A(15 downto 11);
--			Mplex16to1_input(9)	<= A(9 downto 0) & A(15 downto 10);
--			Mplex16to1_input(8)	<= A(8 downto 0) & A(15 downto 9);
--			Mplex16to1_input(7)	<= A(7 downto 0) & A(15 downto 8);
--			Mplex16to1_input(6)	<= A(6 downto 0) & A(15 downto 7);
--			Mplex16to1_input(5)	<= A(5 downto 0) & A(15 downto 6);
--			Mplex16to1_input(4)	<= A(4 downto 0) & A(15 downto 5);
--			Mplex16to1_input(3)	<= A(3 downto 0) & A(15 downto 4);
--			Mplex16to1_input(2)	<= A(2 downto 0) & A(15 downto 3);
--			Mplex16to1_input(1)	<= A(1 downto 0) & A(15 downto 2);
--			Mplex16to1_input(0)	<= A(0) & A(15 downto 1);
			--Loop para gerar input de 1 até ao 13
--			Mplex16to1_input_for:
--			for i in 2 to 14 generate
--				Mplex16to1_input(i-1) <=(A(i-1 downto 0) & A(15 downto i));
--			end generate;
			--------------------------------------------------------------------------------------

--			Mplex16to1_generate:
--			for i in 0 to 15 generate
--				Mp_intermedios: Mux_16in PORT MAP(
--					Input => Mplex16to1_input(i),
--					Sel => B_negativo,
--					Output => Mp2to1_in(i)
--				);
--			end generate;

			-----------------------multiplexers------------------------------
			---------MUX 16 entradas e 1 bit saída----------
			Mux_16in_15: Mux_16in Port map( 
				In0 => Mplex16to1_input(15),
				Sel => B_negativo,
				Output => Mp2to1_in(15)
			);
			Mux_16in_14: Mux_16in Port map( 
				In0 => Mplex16to1_input(14),
				Sel => B_negativo,
				Output => Mp2to1_in(14)
			);
			Mux_16in_13: Mux_16in Port map( 
				In0 => Mplex16to1_input(13),
				Sel => B_negativo,
				Output => Mp2to1_in(13)
			);
			Mux_16in_12: Mux_16in Port map( 
				In0 => Mplex16to1_input(12),
				Sel => B_negativo,
				Output => Mp2to1_in(12)
			);
			Mux_16in_11: Mux_16in Port map( 
				In0 => Mplex16to1_input(11),
				Sel => B_negativo,
				Output => Mp2to1_in(11)
			);
			Mux_16in_10: Mux_16in Port map( 
				In0 => Mplex16to1_input(10),
				Sel => B_negativo,
				Output => Mp2to1_in(10)
			);
			Mux_16in_9: Mux_16in Port map( 
				In0 => Mplex16to1_input(9),
				Sel => B_negativo,
				Output => Mp2to1_in(9)
			);
			Mux_16in_8: Mux_16in Port map( 
				In0 => Mplex16to1_input(8),
				Sel => B_negativo,
				Output => Mp2to1_in(8)
			);
			Mux_16in_7: Mux_16in Port map( 
				In0 => Mplex16to1_input(7),
				Sel => B_negativo,
				Output => Mp2to1_in(7)
			);
			Mux_16in_6: Mux_16in Port map( 
				In0 => Mplex16to1_input(6),
				Sel => B_negativo,
				Output => Mp2to1_in(6)
			);
			Mux_16in_5: Mux_16in Port map( 
				In0 => Mplex16to1_input(5),
				Sel => B_negativo,
				Output => Mp2to1_in(5)
			);
			Mux_16in_4: Mux_16in Port map( 
				In0 => Mplex16to1_input(4),
				Sel => B_negativo,
				Output => Mp2to1_in(4)
			);
			Mux_16in_3: Mux_16in Port map( 
				In0 => Mplex16to1_input(3),
				Sel => B_negativo,
				Output => Mp2to1_in(3)
			);
			Mux_16in_2: Mux_16in Port map( 
				In0 => Mplex16to1_input(2),
				Sel => B_negativo,
				Output => Mp2to1_in(2)
			);
			Mux_16in_1: Mux_16in Port map( 
				In0 => Mplex16to1_input(1),
				Sel => B_negativo,
				Output => Mp2to1_in(1)
			);
			Mux_16in_0: Mux_16in Port map( 
				In0 => Mplex16to1_input(0),
				Sel => B_negativo,
				Output => Mp2to1_in(0)
			);
-------------------------------------------------------

end Behavioral;

