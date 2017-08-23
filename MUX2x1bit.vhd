----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  MUX2x1bit - Descrição Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX2x1bit is
    Port ( Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           In0 : in  STD_LOGIC;
           In1 : in  STD_LOGIC;
           In2 : in  STD_LOGIC;
           In3 : in  STD_LOGIC;
           outdata : out  STD_LOGIC);
end MUX2x1bit;

architecture Behavioral of MUX2x1bit is

begin
	process (Sel, In0, In1, In2, In3)
		begin
		case Sel is
			when "00" => outdata <= In0;
			when "01" => outdata <= In1;
			when "10" => outdata <= In2;
			when "11" => outdata <= In3;
			when others => outdata <= In0;
		end case;
		
	end process;

end Behavioral;

