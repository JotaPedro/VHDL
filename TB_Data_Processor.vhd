--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:31:14 09/01/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_Data_Processor.vhd
-- Project Name:  work
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
use work.pds16_types.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_Data_Processor IS
END TB_Data_Processor;
 
ARCHITECTURE behavior OF TB_Data_Processor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Data_Processor
    PORT(
         OpA : IN  std_logic_vector(15 downto 0);
         OpB : IN  std_logic_vector(15 downto 0);
         CYin : IN  std_logic;
         Func : IN  std_logic_vector(5 downto 0);
         Const : IN  std_logic_vector(7 downto 0);
         Ctr : IN  std_logic_vector(2 downto 0);
         Result : OUT  std_logic_vector(15 downto 0);
         FlagsOut : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal OpA : std_logic_vector(15 downto 0) := (others => '0');
   signal OpB : std_logic_vector(15 downto 0) := (others => '0');
   signal CYin : std_logic := '0';
   signal Func : std_logic_vector(5 downto 0) := (others => '0');
   signal Const : std_logic_vector(7 downto 0) := (others => '0');
   signal Ctr : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal Result : std_logic_vector(15 downto 0);
   signal FlagsOut : std_logic_vector(3 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Data_Processor PORT MAP (
          OpA => OpA,
          OpB => OpB,
          CYin => CYin,
          Func => Func,
          Const => Const,
          Ctr => Ctr,
          Result => Result,
          FlagsOut => FlagsOut
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
		
--	OpA : IN  std_logic_vector(15 downto 0);
--	OpB : IN  std_logic_vector(15 downto 0);
--	CYin : IN  std_logic;
--	Func : IN  std_logic_vector(5 downto 0);		--IR10 , 11, 12, 13, 14, 15
--	Const : IN  std_logic_vector(7 downto 0);		
--	Ctr : IN  std_logic_vector(2 downto 0);		--OpB => 0-SigExt 1-ZeroFill 2-ZeroFillx2 3-OpB 4-OpBx2

	OpA	<= "0000000000011010";
	OpB	<= "0000000000000111";
	CYin	<= '1';
	Const	<= "00000010";
	
	
		--ADD A+Const		-> LD r, [r, #7]
--	Ctr	<= "000";
--	Func	<= "101000";
--	wait for 13 ns;	
	
		--SUB A-Const		
--	Ctr	<= "001";
--	Func	<= "101010";
--	wait for 13 ns;
	
		--SHL sin='1'
--	Ctr	<= "001";
--	Func	<= "111001";
--	wait for 13 ns;
	
		--ADD A+Const		-> LD r, [r, #7]
--	Ctr	<= "010";
--	Func	<= "101000";
--	wait for 13 ns;	 
	
		--ADDC A+B+Cy
--	Ctr	<= "011";
--	Func	<= "100100";
--	wait for 13 ns;

		--ANL A&B
	Ctr	<= "011";
	Func	<= "110000";
	wait for 13 ns;
		
		
	
	
	

      wait;
   end process;

END;
