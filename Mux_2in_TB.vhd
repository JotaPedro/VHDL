--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:16:11 05/07/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/Mux_2in_TB.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mux_2in
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
 
ENTITY Mux_2in_TB IS
END Mux_2in_TB;
 
ARCHITECTURE behavior OF Mux_2in_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux_2in
    PORT(
         Input : IN  std_logic_vector(1 downto 0);
         Output : OUT  std_logic;
         Sel : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(1 downto 0) := (others => '0');
   signal Sel : std_logic := '0';

 	--Outputs
   signal Output : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux_2in PORT MAP (
          Input => Input,
          Output => Output,
          Sel => Sel
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		Input <= "01";
		Sel	<= '0';
		wait for 100 ns;
		Input <= "01";
		Sel	<= '1';
		wait for 100 ns;
		Input <= "10";
		Sel	<= '0';
		wait for 100 ns;
		Input <= "10";
		Sel	<= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
