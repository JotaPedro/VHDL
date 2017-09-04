----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Decoder3bits - Descrição Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pds16_types.ALL;

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

