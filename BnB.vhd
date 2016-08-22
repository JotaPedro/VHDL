----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:02:40 08/10/2016 
-- Design Name: 
-- Module Name:    BnB - Behavioral 
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

entity BnB is
    Port ( B : in  STD_LOGIC_VECTOR(3 downto 0);
           IR11 : in  STD_LOGIC;
           B_negativo : out  STD_LOGIC_VECTOR(3 downto 0));
end BnB;

architecture Behavioral of BnB is

begin

	process(B,IR11)	
		begin
			if (IR11 = '1') then
				--B <= not B_negativo;
				B_negativo <= unsigned(not(B)) + 1;
			else if (IR11 = '0') then
				--B <= not B_negativo;
				B_negativo <= B;
				end if;
			end if;
	end process;

end Behavioral;

