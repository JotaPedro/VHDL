----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:13:55 04/28/2016 
-- Design Name: 
-- Module Name:    ImmZeroFill - Behavioral 
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

entity ImmZeroFill is
    Port ( LSB : in  STD_LOGIC; --O QUE É ISTO?????
           SelImm : in  STD_LOGIC;
           Output : out  bit_16;
           Input : in  STD_LOGIC_VECTOR(7 downto 0)
	 );
end ImmZeroFill;

architecture Behavioral of ImmZeroFill is

begin


end Behavioral;

