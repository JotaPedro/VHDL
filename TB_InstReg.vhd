--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:53:25 05/28/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_InstReg.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: InstReg
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
 
ENTITY TB_InstReg IS
END TB_InstReg;
 
ARCHITECTURE behavior OF TB_InstReg IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstReg
    PORT(
         Input : IN  std_logic_vector(15 downto 0);
         EIR : IN  std_logic;
         Output : OUT  std_logic_vector(15 downto 0);
         Clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(15 downto 0) := (others => '0');
   signal EIR : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstReg PORT MAP (
          Input => Input,
          EIR => EIR,
          Output => Output,
          Clk => Clk
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      Input <= "0000000000011111";
		EIR <= '0';
		wait for 15 ns;
		EIR <= '1';
      wait for 15 ns;
		Input <= "1111100000011111";
		wait for 15 ns;
		EIR <= '0';
		Input <= "0000000000011111";
		-- insert stimulus here 

      wait;
   end process;

END;
