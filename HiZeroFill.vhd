----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:19:49 04/28/2016 
-- Design Name: 
-- Module Name:    HiZeroFill - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HiZeroFill is
    Port ( Input : in  STD_LOGIC_VECTOR(7 downto 0);
			  A0 : in STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(15 downto 0));
end HiZeroFill;

architecture Behavioral of HiZeroFill is

begin
	
	process(Input,A0)
		begin
			case A0 is
				when '0' => Output <= Input & "00000000";
				when '1' => Output <= "00000000" & Input;
				when others => Output <= Input & "00000000";
			end case;
	end process;

end Behavioral;

