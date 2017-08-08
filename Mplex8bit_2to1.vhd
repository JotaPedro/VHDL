----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:28:58 04/28/2016 
-- Design Name: 
-- Module Name:    Mplex8bit_2to1 - Behavioral 
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

entity Mplex8bit_2to1 is
    Port ( Input : in  bit_8_array(1 downto 0);
           Sel : in  STD_LOGIC;
           Output : out  std_logic_vector(7 downto 0));
end Mplex8bit_2to1;

architecture Behavioral of Mplex8bit_2to1 is

begin
	process(Input,Sel)
		begin
			case Sel is
				when '0' => Output <= Input(0);
				when '1' => Output <= Input(1);
				when others => Output <= Input(0);
			end case;
	end process;

end Behavioral;

