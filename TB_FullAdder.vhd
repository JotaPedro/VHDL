--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:57:38 07/23/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_FullAdder.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FullAdder
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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY TB_FullAdder IS
END TB_FullAdder;
 
ARCHITECTURE behavior OF TB_FullAdder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FullAdder
    PORT(
         Ax : IN  std_logic;
         Bx : IN  std_logic;
         Cin : IN  std_logic;
         Sx : OUT  std_logic;
         Cout : OUT  std_logic;
         Op : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic;
   signal B : std_logic;
   signal C : std_logic;
   signal Op1 : std_logic;

 	--Outputs
   signal S : std_logic;
   signal Co : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FullAdder PORT MAP (
          Ax => A,
          Bx => B,
          Cin => C,
          Sx => S,
          Cout => Co,
          Op => Op1
        );
 
	
   -- Stimulus process
   stim_proc: process
   begin		
      A <= '0';
		B <= '1';
		C <= '0';
		Op1 <= '0';
		wait for 2 ns;
		A <= '0';
		B <= '0';
		C <= '1';
		wait for 2 ns;
		A <= '1';
		B <= '0';
		C <= '0';
		wait for 2 ns;
		A <= '1';
		B <= '1';
		C <= '0';
		wait for 2 ns;
		A <= '1';
		B <= '0';
		C <= '1';
		wait for 2 ns;
		A <= '1';
		B <= '1';
		C <= '1';
		wait for 2 ns;
      wait;
   end process;

END;
