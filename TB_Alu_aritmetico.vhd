--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:58:44 05/10/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Alu_aritmetico.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Alu_aritmetico
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
 
ENTITY TB_Alu_aritmetico IS
END TB_Alu_aritmetico;
 
ARCHITECTURE behavior OF TB_Alu_aritmetico IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu_aritmetico
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         Cin : IN  std_logic;
         Result : OUT  std_logic_vector(15 downto 0);
         Flags_out : OUT  std_logic_vector(1 downto 0);
         Op : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal Cin : std_logic := '0';
   signal Op : std_logic := '0';

 	--Outputs
   signal Result : std_logic_vector(15 downto 0);
   signal Flags_out : std_logic_vector(1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu_aritmetico PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
          Result => Result,
          Flags_out => Flags_out,
          Op => Op
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		-- Soma sem carry in, sem carry out
		A 		<= "0000000000000001";
		B 		<= "0000000000000010";
		Cin 	<= '0';
		Op 	<= '0';
		wait for 100 ns;
		-- Soma com carry in, sem carry out
		A 		<= "0000000000000001";
		B 		<= "0000000000000010";
		Cin 	<= '1';
		Op 	<= '0';
		wait for 100 ns;
		-- Soma sem carry in, com carry out
		A 		<= "1111111111111111";
		B 		<= "0000000000000010";
		Cin 	<= '0';
		Op 	<= '0';
		wait for 100 ns;
		-- Soma com carry in, com carry out
		A 		<= "1111111111111101";
		B 		<= "0000000000000010";
		Cin 	<= '1';
		Op 	<= '0';
		wait for 100 ns;
		-- subtração sem carry in, sem carry out
		A 		<= "0000000000000010";
		B 		<= "0000000000000001";
		Cin 	<= '0';
		Op 	<= '1';
		wait for 100 ns;
		-- subtração com carry in, sem carry out
		A 		<= "0000000000000011";
		B 		<= "0000000000000001";
		Cin 	<= '1';
		Op 	<= '1';
		wait for 100 ns;
		-- subtração sem carry in, com carry out
		A 		<= "0000000000000000";
		B 		<= "0000000000000001";
		Cin 	<= '0';
		Op 	<= '1';
		wait for 100 ns;
		-- subtração com carry in, com carry out
		A 		<= "0000000000000001";
		B 		<= "0000000000000001";
		Cin 	<= '1';
		Op 	<= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
