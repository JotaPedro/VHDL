----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Register16bitsCL - Descrição Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Register16bitsCL is
	Port ( clkReg : in  STD_LOGIC;
	       En : in  STD_LOGIC;
			 Cl : in STD_LOGIC;
	       D : in  STD_LOGIC_VECTOR (15 downto 0);
          Q : out  STD_LOGIC_VECTOR (15 downto 0));
   end Register16bitsCL;

architecture Behavioral of Register16bitsCL is
	begin
		process(clkReg,Cl)
		begin
			if Cl = '1' then
				Q <= "0000000000000000";
				else if (rising_edge(clkReg)) then
					if En='1' then
					Q <= D;
					end if;
				end if;
			end if;
		end process;

	end Behavioral;

