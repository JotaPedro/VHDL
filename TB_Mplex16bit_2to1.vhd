--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:18:11 07/23/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Mplex16bit_2to1.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mplex16bit_2to1
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
 
ENTITY TB_Mplex16bit_2to1 IS
END TB_Mplex16bit_2to1;
 
ARCHITECTURE behavior OF TB_Mplex16bit_2to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mplex16bit_2to1
    PORT(
         Input_port : in  bit_16_array(1 downto 0);
         Selector_MP : in  STD_LOGIC;
         Output_port : out  bit_16
        );
    END COMPONENT;
    

   --Inputs
   signal Input : bit_16_array(1 downto 0);
   signal Selector : std_logic := '0';

 	--Outputs
   signal Output : bit_16;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mplex16bit_2to1 PORT MAP (
          Input_port => Input,
          Selector_MP => Selector,
          Output_port => Output
        );
 
	-- Init variables
	Input(0) <= ("0001000000000000");--0
	Input(1) <= ("0000000000001001");--1

   -- Stimulus process
   stim_proc: process
   begin		
      Selector <= '1';
      wait for 2 ns;
		Selector <= '0';
		wait;
   end process;

END;
