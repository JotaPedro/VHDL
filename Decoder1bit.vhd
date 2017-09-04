----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Decoder1bit - Descrição Comportamental

-- Description: 
--
-- Additional Comments: 
--
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pds16_types.ALL;


entity Decoder1bit is
    Port ( E : in  STD_LOGIC;
           S : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (1 downto 0));
end Decoder1bit;

architecture Behavioral of Decoder1bit is

begin
process (S, E)
	begin
		if E = '1' then
			case S is
				when '0' => O <= "01";
				when '1' => O <= "10";
				when others => O <= "01";
			end case;
		else
			O <= "00";
		end if;
	end process;

end Behavioral;

