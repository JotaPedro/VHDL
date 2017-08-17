----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    16:13:55 04/28/2016 
-- Design Name: 
-- Module Name:    ImmZeroFill - Behavioral 
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


entity ImmZeroFill is
    Port ( SelImm : in  STD_LOGIC;
			  LSB : in  STD_LOGIC_VECTOR(7 downto 0);
			  Input : in  STD_LOGIC_VECTOR(7 downto 0);
			  Output : out  STD_LOGIC_VECTOR( 15 downto 0 )    
	 );
end ImmZeroFill;

architecture Behavioral of ImmZeroFill is
begin

	process(Input, SelImm)
	begin
		if SelImm = '0' then
			Output <= (15 downto 8 => '0') & Input; --LDI	[& == concatenação ?????]
			else if SelImm = '1' then
				Output <= Input & LSB; --LDIH
			end if;
		end if;
	end process;

end Behavioral;

