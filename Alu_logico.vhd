----------------------------------------------------------------------------------
-- Project Name: PDS16fpga
-- 	Autors:	  João Botelho nº31169
--					  Tiago Ramos  nº00000
-- Create Date:  18:59:41 04/27/2017 
-- Module Name:  Alu_Logico - Descrição Hardware
-- Target Devices: 
-- Version: V.0.1
-- Description: 
-- Este modulo é referente ao bloco existente na ALU do PDS16 com o nome "Lógico".
-- Tem como objetivo diponibilizar as seguintes funções lógicas.
-- Operações Lógicas AND, OR, XOR e NOT
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;

entity Alu_Logico is
    Port ( Input_B : in  bit_16;
           Input_A : in  bit_16;
           Op : in  STD_LOGIC_VECTOR(1 downto 0);
           Output : out  bit_16
--			  OpA : in  STD_LOGIC_VECTOR(15 downto 0);
--         OpB_Alu : in  STD_LOGIC_VECTOR(15 downto 0);
--         Func : in  STD_LOGIC_VECTOR(1 downto 0); -- Func[3] = IR11, Func[4] = 12
--         Result_logico : out  STD_LOGIC_VECTOR(15 downto 0)
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
					when others => Output <= (Input_A AND Input_B);
				end case;
	end process;

end Behavioral;
