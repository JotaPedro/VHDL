----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    13:00:01 04/30/2017 
-- Design Name: 
-- Module Name:    Register16bits - Behavioral 
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


entity Register16bits is

Port ( clkReg : in  STD_LOGIC;
       En : in  STD_LOGIC;
       D : in  STD_LOGIC_VECTOR (15 downto 0);
       Q : out  STD_LOGIC_VECTOR (15 downto 0));
       
end Register16bits;

architecture Behavioural of Register16bits is
begin

	process(clkReg)
	begin
		if(rising_edge(clkReg)) then
			if(En='1') then
				
				Q <= D;

			end if;
		end if;
	end process;
	
end Behavioural;

