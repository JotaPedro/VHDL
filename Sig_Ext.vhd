----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Sig_Ext - Descrição Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pds16_types.ALL;


entity Sig_Ext is
    Port ( Const8x2 : in  STD_LOGIC_VECTOR(8 downto 0);
           Output16bit : out  STD_LOGIC_VECTOR(15 downto 0));
end Sig_Ext;

architecture Behavioral of Sig_Ext is

begin

	Output16bit(15 downto 8) <= (others => Const8x2(8));
	Output16bit(7 downto 0)  <= Const8x2(7 downto 0);

end Behavioral;

