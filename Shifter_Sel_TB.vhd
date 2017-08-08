--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:21:19 05/07/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/Shifter_Sel_TB.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Shifter_Sel_mplex2to1
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
 
ENTITY Shifter_Sel_TB IS
END Shifter_Sel_TB;
 
ARCHITECTURE behavior OF Shifter_Sel_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Shifter_Sel_mplex2to1
    PORT(
         Decoder_1 : IN  std_logic_vector(15 downto 0);
         Decoder_2 : IN  std_logic_vector(15 downto 0);
         Mp2to1_sel : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Decoder_1 : std_logic_vector(15 downto 0) := (others => '0');
   signal Decoder_2 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Mp2to1_sel : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Shifter_Sel_mplex2to1 PORT MAP (
          Decoder_1 => Decoder_1,
          Decoder_2 => Decoder_2,
          Mp2to1_sel => Mp2to1_sel
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Decoder_1 <= "1000000000000000";
		Decoder_2 <= "0000000000000000";
		wait for 100 ns;
		Decoder_1 <= "1000000000000000";
		Decoder_2 <= "1000000000000000";

      -- insert stimulus here 

      wait;
   end process;

END;
