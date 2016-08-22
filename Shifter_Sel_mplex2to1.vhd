----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:36:33 08/10/2016 
-- Design Name: 
-- Module Name:    Shifter_Sel_mplex2to1 - Behavioral 
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

entity Shifter_Sel_mplex2to1 is
    Port ( Decoder_1 : in  STD_LOGIC_VECTOR(15 downto 0);
           Decoder_2 : in  STD_LOGIC_VECTOR(15 downto 0);
           Mp2to1_sel : out  STD_LOGIC_VECTOR(15 downto 0));
end Shifter_Sel_mplex2to1;

architecture Behavioral of Shifter_Sel_mplex2to1 is

Signal Or_tree_out_A: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
Signal Or_tree_out_B: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

begin

			---------------------Or tree------------------------------
			Or_tree_1: Or_tree PORT MAP( 
				Input => Decoder_1,
				Output => Or_tree_out_A
			); 
			Or_tree_2: Or_tree PORT MAP( 
				Input => Decoder_2,
				Output => Or_tree_out_B
			);
			
			---------------------Selector multiplexers 2para1------------------------------
			Mp2to1_sel(15) <= Or_tree_out_A(1);
			Mp2to1_sel(14) <= Or_tree_out_A(2) or Or_tree_out_B(15);
			Mp2to1_sel(13) <= Or_tree_out_A(3) or Or_tree_out_B(14);
			Mp2to1_sel(12) <= Or_tree_out_A(4) or Or_tree_out_B(13);
			Mp2to1_sel(11) <= Or_tree_out_A(5) or Or_tree_out_B(12);
			Mp2to1_sel(10) <= Or_tree_out_A(6) or Or_tree_out_B(11);
			Mp2to1_sel(9) <= Or_tree_out_A(7) or Or_tree_out_B(10);
			Mp2to1_sel(8) <= Or_tree_out_A(8) or Or_tree_out_B(9);
			Mp2to1_sel(7) <= Or_tree_out_A(9) or Or_tree_out_B(8);
			Mp2to1_sel(6) <= Or_tree_out_A(10) or Or_tree_out_B(7);
			Mp2to1_sel(5) <= Or_tree_out_A(11) or Or_tree_out_B(6);
			Mp2to1_sel(4) <= Or_tree_out_A(12) or Or_tree_out_B(5);
			Mp2to1_sel(3) <= Or_tree_out_A(13) or Or_tree_out_B(4);
			Mp2to1_sel(2) <= Or_tree_out_A(14) or Or_tree_out_B(3);
			Mp2to1_sel(1) <= Or_tree_out_A(15) or Or_tree_out_B(2);
			Mp2to1_sel(0) <= Or_tree_out_B(1);


end Behavioral;

