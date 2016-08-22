----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:55 04/18/2016 
-- Design Name: 
-- Module Name:    Mplex2to1 - Behavioral 
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

ENTITY TB_Mplex2to1 IS
END TB_Mplex2to1;
 
ARCHITECTURE behavior OF TB_Mplex2to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mplex2to1 is
    Port ( Input : in STD_LOGIC_VECTOR(1 downto 0);
           Output : out  STD_LOGIC;
           Sel : in  STD_LOGIC
			 );
    END COMPONENT;
    

   --Inputs
   signal Input1 : STD_LOGIC_VECTOR(1 downto 0);
   signal Sel1 : STD_LOGIC;

 	--Outputs
   signal Output1 : STD_LOGIC;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mplex2to1 Port map 
			( Input => Input1,
           Sel => Sel1,
           Output => Output1
			 );
 
   -- Stimulus process
   stim_proc: process
   begin
		Input1 	<= ("01");--0
		Sel1 		<= '0';--1
      wait for 2 ns;
		Sel1 		<= '1';--1
		wait;
   end process;
END;