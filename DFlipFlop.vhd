----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:03:23 04/28/2016 
-- Design Name: 
-- Module Name:    DFlipFlop - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DFlipFlop is
    Port ( D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Clk : in  STD_LOGIC;
           CL : in  STD_LOGIC);
end DFlipFlop;

architecture Behavioral of DFlipFlop is
begin

process (Clk,CL)
begin
	if CL='1' then
		Q <= '0';
		else if Clk'event and Clk='1' then  
			Q <= D;
		end if;
   end if;
end process;
 


end Behavioral;

