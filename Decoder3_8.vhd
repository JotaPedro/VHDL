----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:35 04/04/2016 
-- Design Name: 
-- Module Name:    Decoder3_8 - Behavioral 
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

entity Decoder3_8 is
    Port ( AddrSD_port : in  STD_LOGIC_VECTOR(2 downto 0);
           Enable_port : in  STD_LOGIC;
           Output_port : out  STD_LOGIC_VECTOR(7 downto 0));
end Decoder3_8;

architecture Behavioral of Decoder3_8 is
begin
	process(AddrSD_port,Enable_port)
		begin
			if Enable_port = '1' then
				case AddrSD_port is
					--Será que posso passar um array para uma variavel normal?
					when "000" => Output_port(0) <= '1';
					when "001" => Output_port(1) <= '1';
					when "010" => Output_port(2) <= '1';
					when "011" => Output_port(3) <= '1';
					when "100" => Output_port(4) <= '1';
					when "101" => Output_port(5) <= '1';
					when "110" => Output_port(6) <= '1';
					when "111" => Output_port(7) <= '1';
					when others => Output_port(0) <= '1';
					--este ultimo caso "others" é para contemplar os outros 8 casos por linha
					--que podem existir, pois o tipo STD_LOGIC pode ter 9 estados.
				end case;
			end if;
	end process;
end Behavioral;

