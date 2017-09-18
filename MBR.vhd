----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  Jo�o Botelho n�31169
--				  Tiago Ramos  n�32125

-- Module Name:  MBR - Descri��o Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MBR is
    Port ( enable : in  STD_LOGIC;
			  d : in  STD_LOGIC_VECTOR (15 downto 0);
           q : out  STD_LOGIC_VECTOR (15 downto 0));
end MBR;

architecture Behavioral of MBR is
begin
	process(enable,d)
		begin
			if enable = '1' then
				q <= d;
			end if;
	end process;

end Behavioral;

