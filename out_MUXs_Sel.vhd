----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Selector_mplex - Descrição Hardware

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

entity out_MUXs_Sel is
    Port ( Decoder_1 : in  STD_LOGIC_VECTOR(15 downto 0);
           Decoder_2 : in  STD_LOGIC_VECTOR(15 downto 0);
           selector : out  STD_LOGIC_VECTOR(15 downto 0));
end out_MUXs_Sel;

architecture Structural of out_MUXs_Sel is

	Signal Or_tree_out_A: STD_LOGIC_VECTOR(15 downto 0);
	Signal Or_tree_out_B: STD_LOGIC_VECTOR(15 downto 0);

begin

		--Or tree--
		Or_tree_1: Or_tree PORT MAP( 
			Input => Decoder_1,
			Output => Or_tree_out_A); 
			
		Or_tree_2: Or_tree PORT MAP( 
			Input => Decoder_2,
			Output => Or_tree_out_B);
			
		--Selector multiplexers saida de data--
		process(Or_tree_out_A,Or_tree_out_B)
		begin
			selector(15) <= Or_tree_out_A(1);
			selector(14) <= Or_tree_out_A(2) or Or_tree_out_B(15);
			selector(13) <= Or_tree_out_A(3) or Or_tree_out_B(14);
			selector(12) <= Or_tree_out_A(4) or Or_tree_out_B(13);
			selector(11) <= Or_tree_out_A(5) or Or_tree_out_B(12);
			selector(10) <= Or_tree_out_A(6) or Or_tree_out_B(11);
			selector(9) <= Or_tree_out_A(7) or Or_tree_out_B(10);
			selector(8) <= Or_tree_out_A(8) or Or_tree_out_B(9);
			selector(7) <= Or_tree_out_A(9) or Or_tree_out_B(8);
			selector(6) <= Or_tree_out_A(10) or Or_tree_out_B(7);
			selector(5) <= Or_tree_out_A(11) or Or_tree_out_B(6);
			selector(4) <= Or_tree_out_A(12) or Or_tree_out_B(5);
			selector(3) <= Or_tree_out_A(13) or Or_tree_out_B(4);
			selector(2) <= Or_tree_out_A(14) or Or_tree_out_B(3);
			selector(1) <= Or_tree_out_A(15) or Or_tree_out_B(2);
			selector(0) <= Or_tree_out_B(1);
		end process;

end Structural;

