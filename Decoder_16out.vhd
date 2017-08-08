----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:43:40 04/30/2017 
-- Design Name: 
-- Module Name:    Decoder_16out - Behavioral 
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

entity Decoder_16out is
    Port ( Enable : in  STD_LOGIC;
			  Sel 	: in  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  STD_LOGIC_VECTOR(15 downto 0)
			 );
end Decoder_16out;

architecture Behavioral of Decoder_16out is
begin
		process(Enable,Sel)
		begin
		Output(0) <= ( Enable and (not Sel(0)) and (not Sel(1)) and (not Sel(2))and (not Sel(3)));
		Output(1) <= ( Enable and (	 Sel(0)) and (not Sel(1)) and (not Sel(2))and (not Sel(3)) );
		Output(2) <= ( Enable and (not Sel(0)) and (	   Sel(1)) and (not Sel(2))and (not Sel(3)) );
		Output(3) <= ( Enable and (    Sel(0)) and (	   Sel(1)) and (not Sel(2))and (not Sel(3)) );
		Output(4) <= ( Enable and (not Sel(0)) and (not Sel(1)) and (	  Sel(2))and (not Sel(3)) );
		Output(5) <= ( Enable and (    Sel(0)) and (not Sel(1)) and (	  Sel(2))and (not Sel(3)) );
		Output(6) <= ( Enable and (not Sel(0)) and (    Sel(1)) and (	  Sel(2))and (not Sel(3)) );
		Output(7) <= ( Enable and (    Sel(0)) and (	   Sel(1)) and (	  Sel(2))and (not Sel(3)) );
		Output(8) <= ( Enable and (not Sel(0)) and (not Sel(1)) and (not Sel(2))and (	   Sel(3)) );
		Output(9) <= ( Enable and (    Sel(0)) and (not Sel(1)) and (not Sel(2))and (	   Sel(3)) );
		Output(10)<= ( Enable and (not Sel(0)) and (	   Sel(1)) and (not Sel(2))and (	   Sel(3)) );
		Output(11)<= ( Enable and (    Sel(0)) and (	   Sel(1)) and (not Sel(2))and (	   Sel(3)) );
		Output(12)<= ( Enable and (not Sel(0)) and (not Sel(1)) and (	  Sel(2))and (	   Sel(3)) );
		Output(13)<= ( Enable and (    Sel(0)) and (not Sel(1)) and (	  Sel(2))and (	   Sel(3)) );
		Output(14)<= ( Enable and (not Sel(0)) and (	   Sel(1)) and (	  Sel(2))and (	   Sel(3)) );
		Output(15)<= ( Enable and (    Sel(0)) and (	   Sel(1)) and (	  Sel(2))and (	   Sel(3)) );
		end process;
		
end Behavioral;

