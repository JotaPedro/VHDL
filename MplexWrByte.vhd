----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  MplexWrByte - Descrição Comportamental

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


entity MplexWrByte is
    Port ( 	Input0 : in  std_logic_vector(7 downto 0); -- Parte Alta
				Input1 : in  std_logic_vector(7 downto 0); -- Parte Baixa
				Sel : in  STD_LOGIC;
				Output : out  std_logic_vector(15 downto 0));
end MplexWrByte;

architecture Behavioral of MplexWrByte is

begin
	process(Input0, Input1 ,Sel)
		begin
			case Sel is
				when '0' => Output <= Input0 & Input1;
				when '1' => Output <= Input1 & Input1;
				when others => Output <= (others => 'Z');
			end case;
	end process;

end Behavioral;