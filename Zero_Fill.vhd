----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    21:28:42 04/07/2016 
-- Design Name: 
-- Module Name:    Zero_Fill - Behavioral 
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


entity Zero_Fill is
    Port ( Const4bit : in  STD_LOGIC_VECTOR(3 downto 0);
           Output16bit : out  STD_LOGIC_VECTOR(15 downto 0));
end Zero_Fill;

architecture Behavioral of Zero_Fill is

begin

	Output16bit <= (15 downto 4 => '0') & Const4bit;

end Behavioral;

