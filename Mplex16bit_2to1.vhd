----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:17:00 04/04/2016 
-- Design Name: 
-- Module Name:    Mplex16bit_2to1 - Behavioral 
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
use work.pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mplex16bit_2to1 is

	--type 16bit is array(1 downto 0) of std_logic_vector(15 downto 0);--Para usar nas entradas dos multiplexers
	
    Port ( Input_port : in  bit_16_array(1 downto 0);
           Selector_MP : in  STD_LOGIC;
           Output_port : out  bit_16
			 );
end Mplex16bit_2to1;

architecture Behavioral of Mplex16bit_2to1 is

begin
	process(Input_port,Selector_MP)
		begin
			case Selector_MP is
				when '0' => Output_port <= Input_port(0);
				when '1' => Output_port <= Input_port(1);
				when others => Output_port <= Input_port(0);
				--este ultimo caso "others" é para contemplar os outros 8 casos por linha
				--que podem existir, pois o tipo STD_LOGIC pode ter 9 estados.
			end case;
	end process;

end Behavioral;

