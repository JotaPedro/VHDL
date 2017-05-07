--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:44:23 05/07/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/Block_Mplex16to1_TB.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Block_Mplex16to1
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
 
ENTITY Block_Mplex16to1_TB IS
END Block_Mplex16to1_TB;
 
ARCHITECTURE behavior OF Block_Mplex16to1_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Block_Mplex16to1
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         Mp2to1_in : OUT  std_logic_vector(15 downto 0);
         B_negativo : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B_negativo : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Mp2to1_in : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Block_Mplex16to1 PORT MAP (
          A => A,
          Mp2to1_in => Mp2to1_in,
          B_negativo => B_negativo
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		A 				<= "0000000000001111";
		B_negativo 	<= "1000";
		wait for 100 ns;
		B_negativo 	<= "0000";
		wait for 100 ns;
		B_negativo 	<= "1111";
		wait for 100 ns;
		B_negativo 	<= "0100";
		wait for 100 ns;
		B_negativo 	<= "0101";
		wait for 100 ns;
		B_negativo 	<= "0110";
		wait for 100 ns;
		B_negativo 	<= "0111";

      -- insert stimulus here 

      wait;
   end process;

END;
