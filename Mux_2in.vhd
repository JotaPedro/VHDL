----------------------------------------------------------------------------------
-- Project Name: PDS16fpga
-- 	Autors:	  Jo�o Botelho n�31169
--					  Tiago Ramos  n�00000
-- Create Date:  18:59:41 04/27/2017 
-- Module Name:  Mux_2in - Descri��o Hardware
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
    Port ( Input: in  STD_LOGIC_VECTOR(1 downto 0);
			  Output: out  STD_LOGIC;
			  Sel: in  STD_LOGIC
			 );
end Mux_2in;

architecture Behavioral of Mux_2in is
begin
	process(Input,Sel)
	begin
	Output <= ((Input(0) and (not Sel)) or (Input(1) and Sel));
	end process;
end Behavioral;

