--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:20:36 05/24/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Zero_Fill.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Zero_Fill
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
 
ENTITY TB_Zero_Fill IS
END TB_Zero_Fill;
 
ARCHITECTURE behavior OF TB_Zero_Fill IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Zero_Fill
    PORT(
         Const4bit : IN  std_logic_vector(3 downto 0);
         Output16bit : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Const4bit : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output16bit : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Zero_Fill PORT MAP (
          Const4bit => Const4bit,
          Output16bit => Output16bit
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Const4bit <= "0111";
		wait for 100 ns;	
		Const4bit <= "1011";
      wait;
   end process;

END;
