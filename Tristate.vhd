----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:23 08/30/2016 
-- Design Name: 
-- Module Name:    Tristate - Behavioral 
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

entity Tristate is
    Port ( Input : in  bit_16;
           Enable : in  STD_LOGIC;
           Output : out  bit_16);
end Tristate;

architecture Behavioral of Tristate is

begin

	Output	<= Input when (Enable='1') else (others=>'Z');

end Behavioral;

