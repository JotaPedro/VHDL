----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:19:37 04/18/2016 
-- Design Name: 
-- Module Name:    Mplex4to1 - Behavioral 
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

ENTITY TB_Mplex16to1 IS
END TB_Mplex16to1;
 
ARCHITECTURE behavior OF TB_Mplex16to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mplex16to1 is
    Port ( Input : in  bit_16;
           Sel : in  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  STD_LOGIC
			 );
    END COMPONENT;
    

   --Inputs
   signal Input1 : bit_16;
   signal Sel1 : STD_LOGIC_VECTOR(3 downto 0);

 	--Outputs
   signal Output1 : STD_LOGIC;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mplex16to1 Port map 
			( Input => Input1,
           Sel => Sel1,
           Output => Output1
			 );
 
   -- Stimulus process
   stim_proc: process
   begin
		Input1 	<= ("0001000010001000");--0
		Sel1 		<= ("0011");--1
      wait for 2 ns;
		Sel1 		<= ("1001");--1
      wait for 2 ns;
		Sel1 		<= ("1001");--1
      wait for 2 ns;
		Sel1 		<= ("1001");--1
		wait;
   end process;
END;