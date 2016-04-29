----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:17:14 04/07/2016 
-- Design Name: 
-- Module Name:    Mplex16bit_5to1 - Behavioral 
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
use pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mplex16bit_5to1 is
    Port ( Input_port : in  bit_16_array(4 downto 0);
			  Selector_MP: in STD_LOGIC_VECTOR(2 downto 0);
           Output_port : out  bit_16
			 );
end Mplex16bit_5to1;

architecture Behavioral of Mplex16bit_5to1 is

begin

	process(Input_port,Selector_MP)
		begin
			case Selector_MP is
				when "000" => Output_port <= Input_port(0);
				when "001" => Output_port <= Input_port(1);
				when "010" => Output_port <= Input_port(2);
				when "011" => Output_port <= Input_port(3);
				when "100" => Output_port <= Input_port(4);
				when others => Output_port <= Input_port(0);
				--este ultimo caso "others" é para contemplar os outros 8 casos por linha
				--que podem existir, pois o tipo STD_LOGIC pode ter 9 estados.
			end case;
	end process;

end Behavioral;

