----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:19:00 04/28/2016 
-- Design Name: 
-- Module Name:    InstReg - Behavioral 
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

entity InstReg is
    Port ( Input : in  STD_LOGIC_VECTOR(15 downto 0);
           EIR : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(15 downto 0);
           Clk : in  STD_LOGIC);
end InstReg;

architecture Behavioral of InstReg is

	component Register16bits is
	Port ( D : in  STD_LOGIC_VECTOR (15 downto 0);
          Q : out  STD_LOGIC_VECTOR (15 downto 0);
          En : in  STD_LOGIC;
			 clkReg : in  STD_LOGIC);
	end component;

begin
	
	IR: Register16bits port map(
		D => Input,
		En => EIR,
		Q => Output,
		clkReg => Clk
	);

end Behavioral;

