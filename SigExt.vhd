----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:43:47 04/07/2016 
-- Design Name: 
-- Module Name:    SigExt - Behavioral 
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
use pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SigExt is
    Port ( Const8x2 : in  STD_LOGIC_VECTOR(7 downto 0);
           Output16bit : out  bit_16);
end SigExt;

architecture Behavioral of SigExt is

begin
	process(Const8x2)
		begin
			Output16bit <= SXT(Const8x2, Output16bit'LENGTH);
	end process;
end Behavioral;

