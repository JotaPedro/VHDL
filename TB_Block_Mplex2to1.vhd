--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:00:33 05/08/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Block_Mplex2to1.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Block_Mplex2to1
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
 
ENTITY TB_Block_Mplex2to1 IS
END TB_Block_Mplex2to1;
 
ARCHITECTURE behavior OF TB_Block_Mplex2to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Block_Mplex2to1
    PORT(
         Input1 : IN  std_logic_vector(15 downto 0);
         Input2 : IN  std_logic;
         Output : OUT  std_logic_vector(15 downto 0);
         Output_Carry : OUT  std_logic;
         Sel : IN  std_logic_vector(15 downto 0);
         ir11 : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Input1 : std_logic_vector(15 downto 0) := (others => '0');
   signal Input2 : std_logic := '0';
   signal Sel : std_logic_vector(15 downto 0) := (others => '0');
   signal ir11 : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);
   signal Output_Carry : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Block_Mplex2to1 PORT MAP (
          Input1 => Input1,
          Input2 => Input2,
          Output => Output,
          Output_Carry => Output_Carry,
          Sel => Sel,
          ir11 => ir11
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		Input1 	<= "0000000000000000";
		Input2 	<= '0';
		Sel 		<= "0000000000000000";
		ir11 		<= '0';
		wait for 100 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
