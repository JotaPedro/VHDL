----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:19:37 04/18/2016 
-- Design Name: 
-- Module Name:    Mplex4to1 - Behavioral 
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

entity Mplex16to1 is
    Port ( Input : in  bit_16;
           Sel : in  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  STD_LOGIC);
end Mplex16to1;

architecture Behavioral of Mplex16to1 is
begin
	process (Sel,Input)
	begin
		case Sel is
			when "0000" => Output <= Input(15);
			when "0001" => Output <= Input(14);
			when "0010" => Output <= Input(13);
			when "0011" => Output <= Input(12);
			when "0100" => Output <= Input(11);
			when "0101" => Output <= Input(10);
			when "0110" => Output <= Input(9);
			when "0111" => Output <= Input(8);
			when "1000" => Output <= Input(7);
			when "1001" => Output <= Input(6);
			when "1010" => Output <= Input(5);
			when "1011" => Output <= Input(4);
			when "1100" => Output <= Input(3);
			when "1101" => Output <= Input(2);
			when "1110" => Output <= Input(1);
			when "1111" => Output <= Input(0);
			when others => Output <= Input(0);
		end case;
	end process;
end Behavioral;

