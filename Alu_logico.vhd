----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:27:17 04/09/2016 
-- Design Name: 
-- Module Name:    Alu_logico - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--Operações Lógicas AND, OR, XOR e NOT

entity Alu_logico is
    Port ( Input_B : in  bit_16;
           Input_A : in  bit_16;
           Op : in  STD_LOGIC_VECTOR(1 downto 0);--IR11, 12
           Output : out  bit_16
		);
end Alu_logico;

architecture Behavioral of Alu_logico is

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

