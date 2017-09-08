----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  DFlipFlop - Descrição Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity DFlipFlop is
    Port ( Clk : in  STD_LOGIC;
			  CL : in  STD_LOGIC;
			  D : in  STD_LOGIC;
           Q : out  STD_LOGIC );
end DFlipFlop;

architecture Behavioral of DFlipFlop is

begin
	process(Clk,CL)
		begin
		if CL='1' then 
			Q <= '0';
			else if (rising_edge(Clk)) then  
				Q <= D;
			end if;
		end if;
	end process;
 
end Behavioral;

