--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:28:36 04/30/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/PDS16fpga/Mux_16in_TB.vhd
-- Project Name:  PDS16fpga
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mux_16in
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
 
ENTITY Mux_16in_TB IS
END Mux_16in_TB;
 
ARCHITECTURE behavior OF Mux_16in_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux_16in
    PORT(
         In0 : IN  std_logic_vector(15 downto 0);
         Sel : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal In0 : std_logic_vector(15 downto 0) := (others => '0');
   signal Sel : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux_16in PORT MAP (
          In0 => In0,
          Sel => Sel,
          Output => Output
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;
		In0 <= "0000000000000001";
		Sel <= "0000";
		wait for 10 ns;
		Sel <= "0101";
		wait for 10 ns;
		Sel <= "1101";

      -- insert stimulus here 

      wait;
   end process;

END;
