--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:00:52 08/29/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_Alu_logico.vhd
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
 
ENTITY TB_Alu_logico IS
END TB_Alu_logico;
 
ARCHITECTURE behavior OF TB_Alu_logico IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu_Logico
    PORT(
         Input_A : IN  std_logic_vector(15 downto 0);
         Input_B : IN  std_logic_vector(15 downto 0);
         Op : IN  std_logic_vector(1 downto 0);
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input_A : std_logic_vector(15 downto 0) := (others => '0');
   signal Input_B : std_logic_vector(15 downto 0) := (others => '0');
   signal Op : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu_Logico PORT MAP (
          Input_A => Input_A,
          Input_B => Input_B,
          Op => Op,
          Output => Output
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
			
		Input_A 	<= ("0001000000001000");--0
		Input_B 	<= ("0000000000001001");--1
		Op	<= "00";--ANL
      wait for 2 ns;

		Op	<= "01";--OR
      wait for 2 ns;

		Op	<= "10";--XOR
      wait for 2 ns;

		Op	<= "11";--NOT

      wait;
   end process;

END;
