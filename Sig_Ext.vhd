----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  Jo�o Botelho n�31169
--				  Tiago Ramos  n�32125

-- Module Name:  Sig_Ext - Descri��o Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pds16_types.ALL;


entity Sig_Ext is
    Port ( Const8x2 : in  STD_LOGIC_VECTOR(7 downto 0);
           Output16bit : out  STD_LOGIC_VECTOR(15 downto 0));
end Sig_Ext;

architecture Behavioral of Sig_Ext is

begin

--	process(Const8x2)
--		begin
--			Output16bit <= SXT(Const8x2, Output16bit'LENGTH);
--	end process;
--	
--	Output16bit <= SXT(Const8x2, Output16bit'LENGTH);

	Output16bit(15 downto 8) <= (others => Const8x2(7));
	Output16bit(7 downto 0)  <= Const8x2;

end Behavioral;

