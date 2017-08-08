----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:21:58 04/27/2017 
-- Design Name: 
-- Module Name:    Mux_4in - Behavioral 
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

entity Mux_4in is
	Port ( Input : in  STD_LOGIC_VECTOR(3 downto 0);
          Sel : in  STD_LOGIC_VECTOR(1 downto 0);
          Output : out  STD_LOGIC);
end Mux_4in;

architecture Behavioral of Mux_4in is

begin

	Output <=	(Input(0)  and (not Sel(0)) and (not Sel(1)) )or
					(Input(1)  and (	   Sel(0)) and (not Sel(1)) )or
					(Input(2)  and (not Sel(0)) and (	  Sel(1)) )or
					(Input(3)  and (	   Sel(0)) and (	  Sel(1)) )
					;

end Behavioral;

