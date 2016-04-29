----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:38:48 04/28/2016 
-- Design Name: 
-- Module Name:    DirZeroFill - Behavioral 
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

entity DirZeroFill is
    Port ( Input : in  STD_LOGIC_VECTOR(6 downto 0);
           Output : out  bit_16);
end DirZeroFill;

architecture Behavioral of DirZeroFill is
begin
	process(Input)
		begin
		Output <= (15 downto 7 => '0') & Input;
	end process;

end Behavioral;

