----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  FullAdder - Descrição Hardware

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FullAdder is
    Port ( Ax : in  STD_LOGIC;
           Bx : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sx : out  STD_LOGIC;
           Cout : out  STD_LOGIC
			  );
end FullAdder;

architecture structural of FullAdder is

begin
	Sx		 <= ((Ax xor Bx) xor Cin);
	Cout	 <= ((Ax and Bx) or ((Ax xor Bx) and Cin));
	--Cout	 <= ((Ax and Bx) or (Cin and Ax) or (Cin and Bx));
end structural;

