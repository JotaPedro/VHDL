--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:37:12 07/29/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Sel_andgatesTree.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sel_andgatesTree
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
 
ENTITY TB_Sel_andgatesTree IS
END TB_Sel_andgatesTree;
 
ARCHITECTURE behavior OF TB_Sel_andgatesTree IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sel_andgatesTree
    PORT(
         Func : IN  std_logic_vector(5 downto 0);
         Oper : OUT  std_logic_vector(3 downto 0);
         LnA : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Func1 : std_logic_vector(5 downto 0);
	--bit 15= Func(0)
	--bit 14= Func(1)
	--bit 13= Func(2)
	--bit 12= Func(3)
	--bit 11= Func(4)
	--bit 10= Func(5)

 	--Outputs
   signal Oper1 : std_logic_vector(3 downto 0);
   signal LnA1 : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sel_andgatesTree PORT MAP (
          Func => Func1,
          Oper => Oper1,
          LnA => LnA1
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
		Func1(0)	<=	'1';
		Func1(1)	<=	'1';
		Func1(2)	<=	'1';
		Func1(3)	<=	'1';
		Func1(4)	<=	'1';
		Func1(5)	<=	'1';
		wait;
   end process;

END;
