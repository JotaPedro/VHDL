--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:16:29 05/07/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/BnB_TB.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BnB
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY BnB_TB IS
END BnB_TB;
 
ARCHITECTURE behavior OF BnB_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BnB
    PORT(
         B : IN  std_logic_vector(3 downto 0);
         IR11 : IN  std_logic;
         B_negativo : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal IR11 : std_logic := '0';

 	--Outputs
   signal B_negativo : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BnB PORT MAP (
          B => B,
          IR11 => IR11,
          B_negativo => B_negativo
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		IR11 	<= '1';
      wait for 100 ns;
		B 		<= "0000";
		IR11 	<= '1';
      wait for 100 ns;
		B 		<= "0001";

      -- insert stimulus here 

      wait;
   end process;

END;
