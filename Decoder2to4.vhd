----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:25:31 04/18/2016 
-- Design Name: 
-- Module Name:    Decoder2to4 - Behavioral 
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

entity Decoder2to4 is
    Port ( Sel : in  STD_LOGIC_VECTOR(1 downto 0);
           Enable : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(3 downto 0);
end Decoder2to4;

architecture Behavioral of Decoder2to4 is
begin
	process(Enable)
	begin
		if ( Enable'event and Enable ='1') then 
			case Sel is
				when "00" => Output <= "0001";
				when "01" => Output <= "0010";
				when "10" => Output <= "0100";
				when "11" => Output <= "1000";
				when others => Output <= "0000";
			end case;
		end if;
	end process;
end Behavioral;

