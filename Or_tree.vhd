----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:44:57 04/20/2016 
-- Design Name: 
-- Module Name:    Or_tree - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Or_tree is
    Port ( Input : in  STD_LOGIC_VECTOR(15 downto 0);
           Output : inout  STD_LOGIC_VECTOR(15 downto 0)
		);
end Or_tree;

architecture Behavioral of Or_tree is
begin
	process(Input)
		begin
				Output(15) <= Input(15);
				Output(14) <= Input(14) or Output(15);
				Output(13) <= Input(13) or Output(14);
				Output(12) <= Input(12) or Output(13);
				Output(11) <= Input(11) or Output(12);
				Output(10) <= Input(10) or Output(11);
				Output(9) <= Input(9) or Output(10);
				Output(8) <= Input(8) or Output(9);
				Output(7) <= Input(7) or Output(8);
				Output(6) <= Input(6) or Output(7);
				Output(5) <= Input(5) or Output(6);
				Output(4) <= Input(4) or Output(5);
				Output(3) <= Input(3) or Output(4);
				Output(2) <= Input(2) or Output(3);
				Output(1) <= Input(1) or Output(2);
				Output(0) <= '0';
	end process;
end Behavioral;

