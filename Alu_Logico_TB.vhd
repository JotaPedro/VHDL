--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:41:02 05/07/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/Alu_Logico_TB.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Alu_Logico
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
 
ENTITY Alu_Logico_TB IS
END Alu_Logico_TB;
 
ARCHITECTURE behavior OF Alu_Logico_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu_Logico
    PORT(
         OpA : IN  std_logic_vector(15 downto 0);
         OpB_Alu : IN  std_logic_vector(15 downto 0);
         Func : IN  std_logic_vector(1 downto 0);
         Result_logico : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal OpA : std_logic_vector(15 downto 0) := (others => '0');
   signal OpB_Alu : std_logic_vector(15 downto 0) := (others => '0');
   signal Func : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Result_logico : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu_Logico PORT MAP (
          OpA => OpA,
          OpB_Alu => OpB_Alu,
          Func => Func,
          Result_logico => Result_logico
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		OpA 		<= "0000001000001001";
		OpB_Alu 	<= "0000000001011011";
      wait for 100 ns;
		Func 		<= "01";
		wait for 100 ns;
		Func 		<= "10";
		wait for 100 ns;
		Func 		<= "11";

      -- insert stimulus here 

      wait;
   end process;

END;
