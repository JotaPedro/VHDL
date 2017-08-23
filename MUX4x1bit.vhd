----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  MUX4x1bit - Descrição Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;


entity MUX4x1bit is
	Port ( Sel : in  STD_LOGIC_VECTOR (3 downto 0);
			 Mux_In : in  STD_LOGIC_VECTOR (15 downto 0);
			 outdata : out  STD_LOGIC);
end MUX4x1bit;

architecture Behavioral of MUX4x1bit is

begin
	process (Sel, Mux_In)
		begin
		case Sel is
			when "0000" => outdata <= Mux_In(0);
			when "0001" => outdata <= Mux_In(1);
			when "0010" => outdata <= Mux_In(2);
			when "0011" => outdata <= Mux_In(3);
			when "0100" => outdata <= Mux_In(4);
			when "0101" => outdata <= Mux_In(5);
			when "0110" => outdata <= Mux_In(6);
			when "0111" => outdata <= Mux_In(7);
			when "1000" => outdata <= Mux_In(8);
			when "1001" => outdata <= Mux_In(9);
			when "1010" => outdata <= Mux_In(10);
			when "1011" => outdata <= Mux_In(11);
			when "1100" => outdata <= Mux_In(12);
			when "1101" => outdata <= Mux_In(13);
			when "1110" => outdata <= Mux_In(14);
			when "1111" => outdata <= Mux_In(15);
			when others => outdata <= Mux_In(0);
		end case;
		
	end process;

end Behavioral;

