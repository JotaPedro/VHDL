----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  BnB - Descrição Hardware

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


entity BnB is
    Port ( IR11 : in  STD_LOGIC;
			  B : in  STD_LOGIC_VECTOR(3 downto 0);
           B_negativo : out  STD_LOGIC_VECTOR(3 downto 0));
end BnB;

architecture Behavioral of BnB is

begin

	process(B,IR11)	
		begin
			if (IR11 = '1') then
				B_negativo <= unsigned(not(B)) + 1;
			else 
				B_negativo <= B;
			end if;
	end process;

end Behavioral;

