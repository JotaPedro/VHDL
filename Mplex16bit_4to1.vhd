----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:21:28 04/28/2016 
-- Design Name: 
-- Module Name:    Mplex16bit_4to1 - Behavioral 
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

entity Mplex16bit_4to1 is
    Port ( Input : in  bit_16_array(3 downto 0);
           Sel : in  STD_LOGIC_VECTOR(1 downto 0);
           Output : out  bit_16);
end Mplex16bit_4to1;

architecture Behavioral of Mplex16bit_4to1 is

begin
	process(Input,Sel)
		begin
			case Sel is
				when "00" => Output <= Input(0);
				when "01" => Output <= Input(1);
				when "10" => Output <= Input(2);
				when "11" => Output <= Input(3);
				when others => Output <= Input(0);
			end case;
	end process;

end Behavioral;

