--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:14:52 05/07/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/Decoder_16out_TB.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder_16out
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
 
ENTITY Decoder_16out_TB IS
END Decoder_16out_TB;
 
ARCHITECTURE behavior OF Decoder_16out_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder_16out
    PORT(
         Enable : IN  std_logic;
         Sel : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Enable : std_logic := '0';
   signal Sel : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder_16out PORT MAP (
          Enable => Enable,
          Sel => Sel,
          Output => Output
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Enable <= '0';
      Sel <= "0000";
		wait for 100 ns;	
		Enable <= '1';
      Sel <= "0000";
		wait for 100 ns;
      Sel <= "1000";
		wait for 100 ns;
      Sel <= "0010";
		wait for 100 ns;
      Sel <= "1111";
		wait for 100 ns;
      Enable <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
