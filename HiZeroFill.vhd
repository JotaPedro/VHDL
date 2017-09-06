----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  HiZeroFill - Descrição Comportamental

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
			  --A0 : in STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (15 downto 0));
end HiZeroFill;

architecture Behavioral of HiZeroFill is
begin
	
--	process(Input,A0)
--		begin
--			case A0 is
--				when '0' => Output <= Input & "00000000";
--				when '1' => Output <= "00000000" & Input;
--				when others => Output <= Input & "00000000";
--			end case;
--	end process;

	process(Input)
		begin
		Output <= "00000000" & Input;
	end process;

end Behavioral;

