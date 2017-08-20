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

entity Latch16bits is

Port ( --clkReg : in  STD_LOGIC;
       En : in  STD_LOGIC;
       D : in  STD_LOGIC_VECTOR (15 downto 0);
       Q : out  STD_LOGIC_VECTOR (14 downto 0);
		 A0: out STD_LOGIC);
       
end Latch16bits;

architecture Behavioural of Latch16bits is
begin

	process(En)
	begin
		if(En='1') then
			
			Q <= D(15 downto 1);
			A0<= D(0);

		end if;
	end process;

--	process(clkReg)
--	begin
--		if(rising_edge(clkReg)) then
--			if(En='1') then
--				
--				Q <= D(15 downto 1);
--				A0<= D(0);
--
--			end if;
--		end if;
--	end process;
	
end Behavioural;