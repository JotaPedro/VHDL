----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    13:03:23 04/28/2016 
-- Design Name: 
-- Module Name:    DFlipFlop - Behavioral 
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


entity DFlipFlop is
    Port ( Clk : in  STD_LOGIC;
			  CL : in  STD_LOGIC;
			  D : in  STD_LOGIC;
           Q : out  STD_LOGIC );
end DFlipFlop;

architecture Behavioral of DFlipFlop is

begin
	process (Clk)
	begin
		if (rising_edge(Clk)) then
			if CL='0' then 			-- En????
				
				Q <= D;
				
			else
				Q <= '0';
				
			end if;
		end if; 
	end process;			
				
				
--		if CL='1' then 
--			Q <= '0';
--			else if (rising_edge(Clk)) then  
--				Q <= D;
--			end if;
--		end if;
--	end process;
 
end Behavioral;

