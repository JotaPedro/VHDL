----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Tristate - Descrição Comportamental

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


entity Tristate is
    Port ( Input : in  bit_16;
           Enable : in  STD_LOGIC;
           Output : out  bit_16);
end Tristate;

architecture Behavioral of Tristate is

begin

	Output	<= Input when (Enable='1') else (others=>'Z');

end Behavioral;

