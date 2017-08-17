----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    23:34:16 08/16/2017 
-- Design Name: 
-- Module Name:    MUX4x1bit - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;


entity MUX4x1bit is
	Port ( Sel : in  STD_LOGIC_VECTOR (3 downto 0);
			 In0 : in  STD_LOGIC;
		    In1 : in  STD_LOGIC;
			 In2 : in  STD_LOGIC;
			 In3 : in  STD_LOGIC;
			 In4 : in  STD_LOGIC;
			 In5 : in  STD_LOGIC;
			 In6 : in  STD_LOGIC;
			 In7 : in  STD_LOGIC;
			 In8 : in  STD_LOGIC;
			 In9 : in  STD_LOGIC;
			 In10 : in  STD_LOGIC;
			 In11 : in  STD_LOGIC;
			 In12 : in  STD_LOGIC;
			 In13 : in  STD_LOGIC;
			 In14 : in  STD_LOGIC;
			 In15 : in  STD_LOGIC;
			 outdata : out  STD_LOGIC);
end MUX4x1bit;

architecture Behavioral of MUX4x1bit is

begin
	process (Sel, In0, In1, In2, In3, In4, In5, In6, In7, In8, In9, In10, In11, In12, In13, In14, In15)
		begin
		case Sel is
			when "0000" => outdata <= In0;
			when "0001" => outdata <= In1;
			when "0010" => outdata <= In2;
			when "0011" => outdata <= In3;
			when "0100" => outdata <= In4;
			when "0101" => outdata <= In5;
			when "0110" => outdata <= In6;
			when "0111" => outdata <= In7;
			when "1000" => outdata <= In8;
			when "1001" => outdata <= In9;
			when "1010" => outdata <= In10;
			when "1011" => outdata <= In11;
			when "1100" => outdata <= In12;
			when "1101" => outdata <= In13;
			when "1110" => outdata <= In14;
			when "1111" => outdata <= In15;
			when others => outdata <= In0;
		end case;
		
	end process;

end Behavioral;

