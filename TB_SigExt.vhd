--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:18:10 05/24/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_SigExt.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SigExt
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
 
ENTITY TB_SigExt IS
END TB_SigExt;
 
ARCHITECTURE behavior OF TB_SigExt IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SigExt
    PORT(
         Const8x2 : IN  std_logic_vector(7 downto 0);
         Output16bit : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Const8x2 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Output16bit : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SigExt PORT MAP (
          Const8x2 => Const8x2,
          Output16bit => Output16bit
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Const8x2 <="00111001";
		wait for 100 ns;	
		Const8x2 <="10111001";

      -- insert stimulus here 

      wait;
   end process;

END;
