--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:17:01 08/23/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Ram2.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Ram2
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
 
ENTITY TB_Ram2 IS
END TB_Ram2;
 
ARCHITECTURE behavior OF TB_Ram2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Ram2
    PORT(

         AD : IN  std_logic_vector(15 downto 0);
         DATA : INOUT  std_logic_vector(15 downto 0);
         nWR : IN  std_logic_vector(1 downto 0);
         nRD : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal AD : std_logic_vector(15 downto 0) := (others => '0');
   signal nWR : std_logic_vector(1 downto 0) := (others => '0');
   signal nRD : std_logic := '0';

	--BiDirs
   signal DATA : std_logic_vector(15 downto 0);
	

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Ram2 PORT MAP (

          AD => AD,
          DATA => DATA,
          nWR => nWR,
          nRD => nRD
        );

   -- Stimulus process
   stim_proc: process
   begin		
      
		AD	<= x"0000";
		DATA 		<= x"0101";
		wait for 50 ns;
		nWR 		<= "11";-- write word
--		wait for 50 ns;-- write byte high
--		nWR 		<= "10";
--		AD	<= x"0001";
--		DATA 		<= x"FF11";
		wait for 50 ns;-- write byte low
		DATA 		<= x"EE22";
		AD	<= x"0001";
		nWR 		<= "01";
		wait for 50 ns;
		DATA 		<= (others => 'Z');
		AD	<= x"0000";
		nWR 		<= "00";
		nRD 		<= '1';
		wait for 50 ns;
		AD	<= x"0001";
      wait;
		
      wait;
   end process;

END;
