--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:14:02 05/24/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Sel_andgatesTree.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sel_andgatesTree
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
 
ENTITY TB_Sel_andgatesTree IS
END TB_Sel_andgatesTree;
 
ARCHITECTURE behavior OF TB_Sel_andgatesTree IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sel_andgatesTree
    PORT(
         Func : IN  std_logic_vector(5 downto 0);
         Oper : OUT  std_logic_vector(3 downto 0);
         LnA : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Func : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Oper : std_logic_vector(3 downto 0);
   signal LnA : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sel_andgatesTree PORT MAP (
          Func => Func,
          Oper => Oper,
          LnA => LnA
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		Func <= "000110"; --IR15...10
		wait for 100 ns;
		Func <= "010110"; --IR15...10
		wait for 100 ns;
		Func <= "100110"; --IR15...10
		wait for 100 ns;
		Func <= "111110"; --IR15...10
      -- insert stimulus here 

      wait;
   end process;

END;
