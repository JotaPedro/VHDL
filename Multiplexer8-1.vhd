----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:12:40 03/22/2016 
-- Design Name: 
-- Module Name:    Multiplexer8-1 - Behavioral 
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

entity Multiplexer8-1 is
    Port ( Input_port : in  STD_LOGIC_VECTOR(7 downto 0);
			  Ctl_sig_port : in STD_LOGIC_VECTOR(2 downto 0);
           Output_port : out  STD_LOGIC);
end Multiplexer8-1;

architecture Behavioral of Mplex16bit-8to1 is
begin
	process(Input_port,Ctl_sig_port)
		begin
			case Ctl_sig_port is
				when "000" => Output_port <= Input_port(0);
				when "001" => Output_port <= Input_port(1);
				when "010" => Output_port <= Input_port(2);
				when "011" => Output_port <= Input_port(3);
				when "100" => Output_port <= Input_port(4);
				when "101" => Output_port <= Input_port(5);
				when "110" => Output_port <= Input_port(6);
				when "111" => Output_port <= Input_port(7);
				when others => Output_port <= Input_port(0);
				--este ultimo caso "others" é para contemplar os outros 8 casos por linha
				--que podem existir, pois o tipo STD_LOGIC pode ter 9 estados.
			end case;
	end process;
end Behavioral;

