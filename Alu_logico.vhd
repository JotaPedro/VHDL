----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Alu_Logico - Descrição Hardware

-- Description: 
-- Este modulo é referente ao bloco existente na ALU do PDS16 com o nome "Lógico".
-- Tem como objetivo diponibilizar as seguintes funções lógicas.
-- Operações Lógicas AND, OR, XOR e NOT
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;

entity Alu_Logico is
    Port ( Input_A : in  STD_LOGIC_VECTOR(15 downto 0);
           Input_B : in  STD_LOGIC_VECTOR(15 downto 0);
           Op : in  STD_LOGIC_VECTOR(1 downto 0); -- IR12 IR11
           Output : out  STD_LOGIC_VECTOR(15 downto 0)
			 );
end Alu_Logico;

architecture Behavioral of Alu_Logico is

begin
	process(Input_B,Input_A,Op)
		begin
				case Op is
					when "00" => Output <= (Input_A AND Input_B); --ANL
					when "01" => Output <= (Input_A OR Input_B);  --ORL
					when "10" => Output <= (Input_A XOR Input_B); --XRL
					when "11" => Output <= (NOT Input_A);			 --NOT
					when others => Output <= "0000000000000000";
				end case;
	end process;

end Behavioral;
