----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Block_MUX4x16bits - Descrição Hardware

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;


entity Block_MUX4x16bits is
	 Port ( Sel : in  STD_LOGIC_VECTOR(3 downto 0);
			  A : in  STD_LOGIC_VECTOR(15 downto 0);
           out_Block: out  STD_LOGIC_VECTOR(15 downto 0));
           
end Block_MUX4x16bits;

architecture Structural of Block_MUX4x16bits is

	Signal Block_input: bit_16_array(15 downto 0); 

begin
	process(A)
	begin
			---------------------Preparar input para os multiplexers------------------------------
			Block_input(15) <= A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15);
			Block_input(14) <= A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14);
			Block_input(13) <= A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13);
			Block_input(12) <= A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12);
			Block_input(11) <= A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11);
			Block_input(10) <= A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10);
			Block_input(9) <= A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9);
			Block_input(8)	<= A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8);
			Block_input(7)	<= A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7);
			Block_input(6)	<= A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6);
			Block_input(5)	<= A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4) & A(5);
			Block_input(4)	<= A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3) & A(4);
			Block_input(3)	<= A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2) & A(3);
			Block_input(2)	<= A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1) & A(2);
			Block_input(1)	<= A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0) & A(1);
			Block_input(0)	<= A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & A(0);
	
	end process;

			--MUXs--
			Mux_16in_15: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(15),
				outdata => out_Block(15)
			);
			Mux_16in_14: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(14),
				outdata => out_Block(14)
			);
			Mux_16in_13: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(13),
				outdata => out_Block(13)
			);
			Mux_16in_12: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(12),
				outdata => out_Block(12)
			);
			Mux_16in_11: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(11),
				outdata => out_Block(11)
			);
			Mux_16in_10: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(10),
				outdata => out_Block(10)
			);
			Mux_16in_9: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(9),
				outdata => out_Block(9)
			);
			Mux_16in_8: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(8),
				outdata => out_Block(8)
			);
			Mux_16in_7: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(7),
				outdata => out_Block(7)
			);
			Mux_16in_6: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(6),
				outdata => out_Block(6)
			);
			Mux_16in_5: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(5),
				outdata => out_Block(5)
			);
			Mux_16in_4: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(4),
				outdata => out_Block(4)
			);
			Mux_16in_3: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(3),
				outdata => out_Block(3)
			);
			Mux_16in_2: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(2),
				outdata => out_Block(2)
			);
			Mux_16in_1: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(1),
				outdata => out_Block(1)
			);
			Mux_16in_0: MUX4x1bit Port map( 
				Sel => Sel,
				Mux_In => Block_input(0),
				outdata => out_Block(0)
			);
end Structural;

