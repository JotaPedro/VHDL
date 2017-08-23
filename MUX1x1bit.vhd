----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    23:34:16 08/16/2017 
-- Design Name: 
-- Module Name:    MUX4x1bit - Behavioral 
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


entity MUX1x1bit is
	Port ( Sel : in  STD_LOGIC;
			 In0 : in  STD_LOGIC;
		    In1 : in  STD_LOGIC;
			 outdata : out  STD_LOGIC);
end MUX1x1bit;

architecture Behavioral of MUX1x1bit is

begin
	process (Sel, In0, In1)
		begin
		
		case Sel is
			when "0" => outdata <= In0;
			when "1" => outdata <= In1;
			when others => outdata <= In0;
		end case;
		
	end process;

end Behavioral;
