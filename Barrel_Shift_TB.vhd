--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:21:08 05/07/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/Barrel_Shift_TB.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Barrel_shift
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
 
ENTITY Barrel_Shift_TB IS
END Barrel_Shift_TB;
 
ARCHITECTURE behavior OF Barrel_Shift_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Barrel_shift
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(15 downto 0);
         Ctl_3bit : IN  std_logic_vector(2 downto 0);
         Cy : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal Ctl_3bit : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);
   signal Cy : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Barrel_shift PORT MAP (
          A => A,
          B => B,
          Output => Output,
          Ctl_3bit => Ctl_3bit,
          Cy => Cy
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		A 			<="0000000000000001";
      B 			<="0011"; 
      Ctl_3bit <="001";
		wait for 100 ns;	
		A 			<="0000000000000001";
      B 			<="0001"; 
      Ctl_3bit <="011";

      -- insert stimulus here 

      wait;
   end process;

END;
