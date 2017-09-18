----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  Jo�o Botelho n�31169
--				  Tiago Ramos  n�32125

-- Module Name:  HiZeroFill - Descri��o Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity HiZeroFill is
    Port ( Input : in  STD_LOGIC_VECTOR (7 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0));
end HiZeroFill;

architecture Behavioral of HiZeroFill is
begin

	process(Input)
		begin
		Output <= "00000000" & Input;
	end process;

end Behavioral;

