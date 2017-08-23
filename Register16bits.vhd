----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  Jo�o Botelho n�31169
--				  Tiago Ramos  n�32125

-- Module Name:  Register16bits - Descri��o Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Register16bits is

Port ( clkReg : in  STD_LOGIC;
       En : in  STD_LOGIC;
       D : in  STD_LOGIC_VECTOR (15 downto 0);
       Q : out  STD_LOGIC_VECTOR (15 downto 0));
       
end Register16bits;

architecture Behavioural of Register16bits is
begin

	process(clkReg)
	begin
		if(rising_edge(clkReg)) then
			if(En='1') then
				
				Q <= D;

			end if;
		end if;
	end process;
	
end Behavioural;

