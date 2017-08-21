--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:49:26 08/21/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_MplexWrByte.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MplexWrByte
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
 
ENTITY TB_MplexWrByte IS
END TB_MplexWrByte;
 
ARCHITECTURE behavior OF TB_MplexWrByte IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MplexWrByte
    PORT(
         Input0 : IN  std_logic_vector(7 downto 0);
         Input1 : IN  std_logic_vector(7 downto 0);
         Sel 	 : IN  std_logic;
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input0 : std_logic_vector(7 downto 0) := (others => '0');
   signal Input1 : std_logic_vector(7 downto 0) := (others => '0');
   signal Sel : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MplexWrByte PORT MAP (
          Input0 => Input0,
          Input1 => Input1,
          Sel => Sel,
          Output => Output
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		Input0 <= x"F0";
		Input1 <= x"0F";
		Sel 	 <= '0';
		wait for 50 ns;
		Sel 	 <= '1';

      wait;
   end process;

END;
