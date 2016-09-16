--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:52:39 08/25/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Data_Processor.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Data_Processor
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
 
ENTITY TB_Data_Processor IS
END TB_Data_Processor;
 
ARCHITECTURE behavior OF TB_Data_Processor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Data_Processor
    PORT(
         Const : IN  std_logic_vector(7 downto 0);
         OpB : IN  std_logic_vector(15 downto 0);
         OpA : IN  std_logic_vector(15 downto 0);
         CYin : IN  std_logic;
         Ctr : IN  std_logic_vector(2 downto 0);
         Func : IN  std_logic_vector(5 downto 0);
         Result : OUT  std_logic_vector(15 downto 0);
         FlagsOut : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    --AS OPERAÇÕES RRH e RRL não estão a funcionar!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

   --Inputs
   signal Const1 : std_logic_vector(7 downto 0) := (others => '0');
   signal OpB1 : std_logic_vector(15 downto 0) := (others => '0');
   signal OpA1 : std_logic_vector(15 downto 0) := (others => '0');
   signal CYin1 : std_logic := '0';
   signal Ctr1 : std_logic_vector(2 downto 0) := (others => '0');
   signal Func1 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Result1 : std_logic_vector(15 downto 0);
   signal FlagsOut1 : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Data_Processor PORT MAP (
          Const => Const1,
          OpB => OpB1,
          OpA => OpA1,
          CYin => CYin1,
          Ctr => Ctr1,
          Func => Func1,--IR10 , 11, 12, 13, 14, 15
          Result => Result1,
          FlagsOut => FlagsOut1-- 0-Zero 1-CyBw 2-GE 3-Parity 
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      OpB1 	<= "0000000000000001";
		OpA1 	<= "0000000000000001";
		Const1<= "00000001";
		CYin1 <= '1';
		Ctr1	<= "011";
		Func1	<= "100000";-- ADD A/B
		wait for 1 ns;
		Ctr1	<= "011";
		Func1	<= "100100";-- ADD A/B/Cy
		wait for 1 ns;
		Ctr1	<= "000";
		Func1	<= "101000";-- ADD A/const
		wait for 1 ns;
		Ctr1	<= "001";
		Func1	<= "101100";-- ADD A/const/cy
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "100010";-- SUB A/B
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "100110";-- SUB A/B/Cy
--		wait for 1 ns;
--		Ctr1	<= "001";
--		Func1	<= "101010";-- SUB A/const
--		wait for 1 ns;
--		Ctr1	<= "001";
--		Func1	<= "101110";-- SUB A/const/cy
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "110000";-- ANL A/B
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "110010";-- ORL A/B
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "110100";-- XRL A/B
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "110110";-- NOT A
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "111000";-- SHL A/const
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "111010";-- SHR A/const
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "111100";-- RRL A/const
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "111101";-- RRH A/const
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "111110";-- RCR A
--		wait for 1 ns;
--		Ctr1	<= "011";
--		Func1	<= "111111";-- RCL A
--		wait for 1 ns;
--		Ctr1	<= "000";
--		Func1	<= "100000";-- teste ao SigExt
--		Const1<= "10000000";
--		wait for 1 ns;
--		Ctr1	<= "001";
--		Func1	<= "100000";-- teste ao ZeroFill
--		wait for 1 ns;
--		Ctr1	<= "010";
--		Func1	<= "100000";-- teste ao ZeroFill x2
--		wait for 1 ns;
--		Ctr1	<= "100";
--		Func1	<= "100000";-- teste ao OpB x2
      wait;
   end process;

END;
