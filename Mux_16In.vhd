----------------------------------------------------------------------------------
-- Project Name: PDS16fpga
-- 	Autors:	  João Botelho nº31169
--					  Tiago Ramos  nº00000
-- Create Date:  18:59:41 04/27/2017 
-- Module Name:  Mux_16in - Descrição Hardware
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

entity Mux_16in is
    Port ( In0 : in  STD_LOGIC_VECTOR(15 downto 0);
			  Sel : in  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  STD_LOGIC
			 );
end Mux_16in;

architecture Behavioral of Mux_16in is
begin

	Output <= 	(In0(0)  and (not Sel(0)) and (not Sel(1)) and (not Sel(2))and (not Sel(3)) )or
					(In0(1)  and (	   Sel(0)) and (not Sel(1)) and (not Sel(2))and (not Sel(3)) )or
					(In0(2)  and (not Sel(0)) and (	  Sel(1)) and (not Sel(2))and (not Sel(3)) )or
					(In0(3)  and (	   Sel(0)) and (	  Sel(1)) and (not Sel(2))and (not Sel(3)) )or
					(In0(4)  and (not Sel(0)) and (not Sel(1)) and (	 Sel(2))and (not Sel(3)) )or
					(In0(5)  and (	   Sel(0)) and (not Sel(1)) and (	 Sel(2))and (not Sel(3)) )or
					(In0(6)  and (not Sel(0)) and ( 	  Sel(1)) and (	 Sel(2))and (not Sel(3)) )or
					(In0(7)  and (	   Sel(0)) and (	  Sel(1)) and (	 Sel(2))and (not Sel(3)) )or
					(In0(8)  and (not Sel(0)) and (not Sel(1)) and (not Sel(2))and (	  Sel(3)) )or
					(In0(9)  and (	   Sel(0)) and (not Sel(1)) and (not Sel(2))and (	  Sel(3)) )or
					(In0(10) and (not Sel(0)) and (	  Sel(1)) and (not Sel(2))and (	  Sel(3)) )or
					(In0(11) and (	   Sel(0)) and (	  Sel(1)) and (not Sel(2))and (	  Sel(3)) )or
					(In0(12) and (not Sel(0)) and (not Sel(1)) and (	 Sel(2))and (	  Sel(3)) )or
					(In0(13) and (	   Sel(0)) and (not Sel(1)) and (	 Sel(2))and (	  Sel(3)) )or
					(In0(14) and (not Sel(0)) and (	  Sel(1)) and (	 Sel(2))and (	  Sel(3)) )or
					(In0(15) and (	   Sel(0)) and (	  Sel(1)) and (	 Sel(2))and (	  Sel(3)) )
					;

end Behavioral;

