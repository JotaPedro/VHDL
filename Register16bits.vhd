----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:00:01 04/30/2017 
-- Design Name: 
-- Module Name:    Register16bits - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Register16bits is
	Port ( D : in  STD_LOGIC_VECTOR (15 downto 0);
          Q : out  STD_LOGIC_VECTOR (15 downto 0);
          En : in  STD_LOGIC;
			 clkReg : in  STD_LOGIC);
	end Register16bits;

architecture behaviour of Register16bits is
begin
	process(clkReg)
	begin
		if(rising_edge(clkReg) and En='1') then
				Q <= D;
		end if;
	end process;
	
end behaviour;

