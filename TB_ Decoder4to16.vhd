----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:25:31 04/18/2016 
-- Design Name: 
-- Module Name:    Decoder2to4 - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;

ENTITY TB_Decoder4to16 IS
END TB_Decoder4to16;
 
ARCHITECTURE behavior OF TB_Decoder4to16 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder4to16 is
    Port ( Sel : in  STD_LOGIC_VECTOR(3 downto 0);
           Enable : in  STD_LOGIC;
           decoder_out : out  STD_LOGIC_VECTOR(15 downto 0)
	 );
    END COMPONENT;
    

   --Inputs
   signal Sel1 : STD_LOGIC_VECTOR(3 downto 0);
   signal Enable1 : STD_LOGIC;
	
 	--Outputs
   signal decoder_out1 : STD_LOGIC_VECTOR(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder4to16 Port map( 
			Sel => Sel1,
			Enable => Enable1,
			decoder_out => decoder_out1
	 );
 
   -- Stimulus process
   stim_proc: process
   begin
		Sel1 		<= "0000";
		Enable1 	<= '1';
		wait for 2 ns;
		Sel1 		<= "1010";
		Enable1 	<= '0';
		wait for 2 ns;
		Sel1 		<= "1010";
		Enable1 	<= '1';
		wait for 2 ns;
		Sel1 		<= "1111";
		Enable1 	<= '1';
		wait;
   end process;
END;