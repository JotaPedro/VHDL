----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  RegisterBank0_5 - Descrição Estrutural

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pds16_types.ALL;


entity RegisterBank0_5 is
    Port ( clk : in  STD_LOGIC;
			  enable : in STD_LOGIC_VECTOR (5 downto 0);
           dataIn : in bit_16_array(5 downto 0);	
			  dataOut: out bit_16_array(5 downto 0));		
end RegisterBank0_5;

architecture Structural of RegisterBank0_5 is

begin

	--------------------------
	-- Banco de 5 Registos
	--------------------------
	R0: component Register16bits port map(
		clkReg => clk,
		En => enable(0),
		D => dataIn(0),
      Q => dataOut(0));
      
	R1: component Register16bits port map(
		clkReg => clk,
		En => enable(1),
		D => dataIn(1),
      Q => dataOut(1));
		
	R2: component Register16bits port map(
		clkReg => clk,
		En =>enable(2),
		D => dataIn(2),
      Q => dataOut(2));
      
	R3: component Register16bits port map(
		clkReg => clk,
		En => enable(3),
		D => dataIn(3),
      Q => dataOut(3));

	R4: component Register16bits port map(
		clkReg => clk,
		En => enable(4),
		D => dataIn(4),
      Q => dataOut(4));
		
	R5: component Register16bits port map(
		clkReg => clk,
		En => enable(5),
		D => dataIn(5),
      Q => dataOut(5));

end Structural;

