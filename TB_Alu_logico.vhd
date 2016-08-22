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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;
 
ENTITY TB_Alu_logico IS
END TB_Alu_logico;
 
ARCHITECTURE behavior OF TB_Alu_logico IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu_logico is
    Port ( Input_B : in  bit_16;
           Input_A : in  bit_16;
           Op : in  STD_LOGIC_VECTOR(1 downto 0);--IR11, 12
           Output : out  bit_16
			);
    END COMPONENT;
    

   --Inputs
   signal A1 : bit_16;
   signal B1 : bit_16;
	signal Op1 : STD_LOGIC_VECTOR(1 downto 0);--AND, OR, XOR e NOT

 	--Outputs
   signal Output1 : bit_16;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu_logico Port map( 
			Input_B => B1,
         Input_A => A1,
         Op => Op1,
         Output => Output1
		);
 
   -- Stimulus process
   stim_proc: process
   begin
		A1 	<= ("0001000000001000");--0
		B1 	<= ("0000000000001001");--1
		Op1	<= "00";--ANL
      wait for 2 ns;
		A1 	<= ("0001000000001000");--0
		B1 	<= ("0000000000001001");--1
		Op1	<= "01";--OR
      wait for 2 ns;
		A1 	<= ("0001000000001000");--0
		B1 	<= ("0000000000001001");--1
		Op1	<= "10";--XOR
      wait for 2 ns;
		A1 	<= ("0001000000001000");--0
		B1 	<= ("0000000000001001");--1
		Op1	<= "11";--NOT
		wait;
   end process;
END;
