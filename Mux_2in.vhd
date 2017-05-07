----------------------------------------------------------------------------------
-- Project Name: PDS16fpga
-- 	Autors:	  João Botelho nº31169
--					  Tiago Ramos  nº00000
-- Create Date:  18:59:41 04/27/2017 
-- Module Name:  Mux_2in - Descrição Hardware
-- Target Devices: 
-- Version: V.0.1
-- Description: 
-- 
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

entity Mux_2in is
    Port ( In0 : in  STD_LOGIC;
           In1 : in  STD_LOGIC;
			  Sel : in  STD_LOGIC;
           Output : out  STD_LOGIC
			 );
end Mux_2in;

architecture Behavioral of Mux_2in is
begin

	Output <= ((In0 and (not Sel)) or (In1 and Sel));

end Behavioral;

