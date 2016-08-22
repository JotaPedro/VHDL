--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:32:48 07/23/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Decoder3_8.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder3_8
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
 
ENTITY TB_Alu_aritmetico IS
END TB_Alu_aritmetico;
 
ARCHITECTURE behavior OF TB_Alu_aritmetico IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu_aritmetico is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           Cin : in  STD_LOGIC;
           Result : out  STD_LOGIC_VECTOR(15 downto 0);
           Flags_out : out  STD_LOGIC_VECTOR(1 downto 0);
			  Op : in STD_LOGIC
			 );
    END COMPONENT;
    

   --Inputs
   signal A1 : STD_LOGIC_VECTOR(15 downto 0);
   signal B1 : STD_LOGIC_VECTOR(15 downto 0);
   signal Cin1 : STD_LOGIC;
	signal Op1 : STD_LOGIC;

 	--Outputs
   signal Result1 : STD_LOGIC_VECTOR(15 downto 0);
   signal Flags_out1 : STD_LOGIC_VECTOR(1 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu_aritmetico Port map 
			( A => A1,
           B => B1,
           Cin => Cin1,
           Result => Result1,
           Flags_out => Flags_out1,
			  Op => Op1
			 );
 
   -- Stimulus process
   stim_proc: process
   begin
		A1 	<= ("0001000000000000");--0
		B1 	<= ("0000000000001001");--1
		Cin1 	<= '0';--0
		Op1	<= '1';--1
      wait for 2 ns;
		A1 	<= ("0000000000000000");--0
		B1 	<= ("0000000000001001");--1
		Cin1 	<= '0';--0
		Op1	<= '1';--1
      wait for 2 ns;
		A1 	<= ("0001000000000000");--0
		B1 	<= ("0000000000001001");--1
		Cin1 	<= '0';--0
		Op1	<= '0';--1
      wait for 2 ns;
		A1 	<= ("0000000000000000");--0
		B1 	<= ("0000000000001001");--1
		Cin1 	<= '0';--0
		Op1	<= '0';--1
      wait for 2 ns;
		A1 	<= ("0000000000000000");--0
		B1 	<= ("0000000000001001");--1
		Cin1 	<= '1';--0
		Op1	<= '1';--1
      wait for 2 ns;
		A1 	<= ("0000000000000000");--0
		B1 	<= ("0000000000001001");--1
		Cin1 	<= '1';--0
		Op1	<= '0';--1
		wait;
   end process;
END;
