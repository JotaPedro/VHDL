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

entity Decoder4to16 is
    Port ( Sel : in  STD_LOGIC_VECTOR(3 downto 0);
           Enable : in  STD_LOGIC;
           decoder_out : out  STD_LOGIC_VECTOR(15 downto 0)
	 );
end Decoder4to16;

architecture Behavioral of Decoder4to16 is

begin
	process(Enable)
	begin
		if ( Enable'event and Enable ='1') then 
			case Sel is
				when X"0"   => decoder_out <= X"0001";
				when X"1"   => decoder_out <= X"0002";
            when X"2"   => decoder_out <= X"0004";
            when X"3"   => decoder_out <= X"0008";
            when X"4"   => decoder_out <= X"0010";
            when X"5"   => decoder_out <= X"0020";
            when X"6"   => decoder_out <= X"0040";
            when X"7"   => decoder_out <= X"0080";
            when X"8"   => decoder_out <= X"0100";
            when X"9"   => decoder_out <= X"0200";
            when X"A"   => decoder_out <= X"0400";
            when X"B"   => decoder_out <= X"0800";
            when X"C"   => decoder_out <= X"1000";
            when X"D"   => decoder_out <= X"2000";
            when X"E"   => decoder_out <= X"4000";
            when X"F"   => decoder_out <= X"8000";
            when others => decoder_out <= X"0000";
			end case;
		end if;
	end process;
end Behavioral;

