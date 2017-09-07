--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:24:01 08/13/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_DFlipFlop.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DFlipFlop
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
 
ENTITY TB_DFlipFlop IS
END TB_DFlipFlop;
 
ARCHITECTURE behavior OF TB_DFlipFlop IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DFlipFlop
    PORT(
         Clk : IN  std_logic;
         CL : IN  std_logic;
         D : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal CL : std_logic := '0';
   signal D : std_logic := '0';

 	--Outputs
   signal Q : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DFlipFlop PORT MAP (
          Clk => Clk,
          CL => CL,
          D => D,
          Q => Q
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;

      CL <= '0';
		D <= '1';
		wait for 12 ns;
		D <= '0';
		wait for 12 ns;
		CL <= '1';
		wait for 12 ns;
		D <= '1';
		wait for 12 ns;
		CL <= '0';

      wait;
   end process;

END;
