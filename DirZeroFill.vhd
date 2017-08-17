----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    16:38:48 04/28/2016 
-- Design Name: 
-- Module Name:    DirZeroFill - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;


entity DirZeroFill is
    Port ( Input : in  STD_LOGIC_VECTOR(6 downto 0);
           Output : out  STD_LOGIC_VECTOR(15 downto 0));
end DirZeroFill;

architecture Behavioral of DirZeroFill is
begin
	process(Input)
		begin
		Output <= (15 downto 7 => '0') & Input;
	end process;

end Behavioral;

