----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:44:57 04/20/2016 
-- Design Name: 
-- Module Name:    Or_tree - Behavioral 
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

ENTITY TB_Or_tree IS
END TB_Or_tree;
 
ARCHITECTURE behavior OF TB_Or_tree IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Or_tree is
    Port ( Input : in  STD_LOGIC_VECTOR(15 downto 0);
           Output : buffer  STD_LOGIC_VECTOR(15 downto 0)
		);
    END COMPONENT;
    

   --Inputs
   signal Input1 : STD_LOGIC_VECTOR(15 downto 0);
	
	--Outputs
   signal Output1 : STD_LOGIC_VECTOR(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Or_tree Port map 
			( 	Input => Input1,
				Output => Output1
			 );
 
   -- Stimulus process
   stim_proc: process
   begin
		Input1 <= ("0001000000000000");--0
		wait;
   end process;
END;