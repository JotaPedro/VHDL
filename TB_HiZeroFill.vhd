--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:35:57 05/28/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_HiZeroFill.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: HiZeroFill
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
 
ENTITY TB_HiZeroFill IS
END TB_HiZeroFill;
 
ARCHITECTURE behavior OF TB_HiZeroFill IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HiZeroFill
    PORT(
         Input : IN  std_logic_vector(7 downto 0);
         A0 : IN  std_logic;
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(7 downto 0) := (others => '0');
   signal A0 : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HiZeroFill PORT MAP (
          Input => Input,
          A0 => A0,
          Output => Output
        );

   -- Stimulus process
   stim_proc: process
   begin		
		Input <= "01010101";
		A0 <= '0';
		wait for 100 ns;
		A0 <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
