----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:22:05 04/30/2017 
-- Design Name: 
-- Module Name:    MUX3x16bits - Behavioral 
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

entity MUX3x16bits is
	 Port ( In0 : in  STD_LOGIC_VECTOR (15 downto 0);
           In1 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In2 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In3 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In4 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In5 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In6 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In7 : in  STD_LOGIC_VECTOR (15 downto 0);
           Sel : in  STD_LOGIC_VECTOR (2 downto 0);
           outdata : out  STD_LOGIC_VECTOR (15 downto 0));
end MUX3x16bits;

architecture Behavioral of MUX3x16bits is

begin
	process (Sel, In0, In1, In2, In3, In4, In5, In6, In7)
		begin
		case Sel is
			when "000" => outdata <= In0;
			when "001" => outdata <= In1;
			when "010" => outdata <= In2;
			when "011" => outdata <= In3;
			when "100" => outdata <= In4;
			when "101" => outdata <= In5;
			when "110" => outdata <= In6;
			when "111" => outdata <= In7;
			when others => outdata <= In0; ----Qual a necessidade????
		end case;
		
	end process;

end Behavioral;
