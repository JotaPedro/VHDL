----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    00:07:27 08/10/2017 
-- Design Name: 
-- Module Name:    MUX2x16bits - Behavioral 
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


entity MUX2x16bits is
Generic (
	WIDTH : NATURAL := 16 );
Port ( Sel : in  STD_LOGIC_VECTOR (1 downto 0);
	In0 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	In1 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	In2 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	In3 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	outdata : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end MUX2x16bits;

architecture Behavioral of MUX2x16bits is

begin
	process (Sel, In0, In1, In2, In3)
		begin
		case Sel is
			when "00" => outdata <= In0;
			when "01" => outdata <= In1;
			when "10" => outdata <= In2;
			when "11" => outdata <= In3;
			when others => outdata <= In0;
		end case;
		
	end process;

end Behavioral;

