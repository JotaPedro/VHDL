--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:14:52 05/13/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/PFC16_17/FPGA_PDS/MUX1x3_TB.vhd
-- Project Name:  FPGA_PDS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX1x3bits
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
 
ENTITY MUX1x3_TB IS
END MUX1x3_TB;
 
ARCHITECTURE behavior OF MUX1x3_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX1x3bits
    PORT(
         In0 : IN  std_logic_vector(2 downto 0);
         In1 : IN  std_logic_vector(2 downto 0);
         Sel : IN  std_logic;
         outdata : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal In0 : std_logic_vector(2 downto 0) := (others => '0');
   signal In1 : std_logic_vector(2 downto 0) := (others => '0');
   signal Sel : std_logic := '0';

 	--Outputs
   signal outdata : std_logic_vector(2 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX1x3bits PORT MAP (
          In0 => In0,
          In1 => In1,
          Sel => Sel,
          outdata => outdata
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      --wait for <clock>_period*10;

      -- insert stimulus here 
		In0 <= "111";
		In1 <= "010";
		wait for 12 ns;
		sel <= '1';
		wait for 12 ns;
		sel <= '0';

      wait;
   end process;

END;
