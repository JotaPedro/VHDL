----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:37:09 04/30/2017 
-- Design Name: 
-- Module Name:    Decoder3bits - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder3bits is
    Port ( E : in  STD_LOGIC;
	        S : in  STD_LOGIC_VECTOR (2 downto 0);
           O : out STD_LOGIC_VECTOR (7 downto 0));
end Decoder3bits;

architecture Behavioral of Decoder3bits is

begin
	process (S, E)
	begin
		if E = '1' then
			case S is
				when "000" => O <= "00000001";
				when "001" => O <= "00000010";
				when "010" => O <= "00000100";
				when "011" => O <= "00001000";
				when "100" => O <= "00010000";
				when "101" => O <= "00100000";
				when "110" => O <= "01000000";
				when "111" => O <= "10000000";
				when others => O <= "00000001";
			end case;
		else
			O <= "00000000";
		end if;
	end process;

end Behavioral;

