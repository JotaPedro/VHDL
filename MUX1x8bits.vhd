----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    23:33:37 08/09/2017 
-- Design Name: 
-- Module Name:    MUX1x8bits - Behavioral 
-- Project Name: PDS16fpga
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


entity MUX1x8bits is
	 Port ( Sel : in  STD_LOGIC;
	        In0 : in  STD_LOGIC_VECTOR (7 downto 0);
           In1 : in  STD_LOGIC_VECTOR (7 downto 0);
           outdata : out  STD_LOGIC_VECTOR (7 downto 0));
end MUX1x8bits;

architecture Behavioral of MUX1x8bits is

begin
		process (Sel, In0, In1)
		begin
			if Sel='0' then
				outdata <= In0;
				else
					outdata <= In1;
			end if;
		end process;

end Behavioral;

