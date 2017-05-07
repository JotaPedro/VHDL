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

entity Alu_Logico is
    Port ( OpA : in  STD_LOGIC_VECTOR(15 downto 0);
           OpB_Alu : in  STD_LOGIC_VECTOR(15 downto 0);
           Func : in  STD_LOGIC_VECTOR(1 downto 0); -- Func[3] = IR11, Func[4] = 12
           Result_logico : out  STD_LOGIC_VECTOR(15 downto 0)
			 );
end Alu_Logico;

architecture Behavioral of Alu_Logico is

begin
	process(OpB_Alu,OpA,Func)
		begin
				case Func is
					when "00" => Result_logico <= (OpA AND OpB_Alu); --ANL
					when "01" => Result_logico <= (OpA OR OpB_Alu);  --ORL
					when "10" => Result_logico <= (OpA XOR OpB_Alu); --XRL
					when "11" => Result_logico <= (NOT OpA);			 --NOT
					when others => Result_logico <= (OpA AND OpB_Alu);
				end case;
	end process;

end Behavioral;
