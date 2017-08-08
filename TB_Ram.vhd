--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:11:35 07/27/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Ram.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Ram
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
 
ENTITY TB_Ram IS
END TB_Ram;
 
ARCHITECTURE behavior OF TB_Ram IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Ram
    PORT(
         Clk : IN  std_logic;
         AD : IN  std_logic_vector(15 downto 0);
         nRD : IN  std_logic;
         nWRL : IN  std_logic;
         nWRH : IN  std_logic;
         DATA : INOUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal AD : std_logic_vector(15 downto 0) := (others => '0');
   signal nRD : std_logic := '0';
   signal nWRL : std_logic := '0';
   signal nWRH : std_logic := '0';

	--BiDirs
   signal DATA : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Ram PORT MAP (
          Clk => Clk,
          AD => AD,
          nRD => nRD,
          nWRL => nWRL,
          nWRH => nWRH,
          DATA => DATA
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
		AD 	<= "0000000000000000";
		nRD 	<= '0';
      wait for Clk_period*10;
		nRD 	<= '1';
		wait for Clk_period*10;
		AD 	<= "0000000000000001";
      -- insert stimulus here 

      wait;
   end process;

END;
