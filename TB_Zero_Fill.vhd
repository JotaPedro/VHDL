--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:42:59 07/29/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Zero_Fill.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Zero_Fill
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
 
ENTITY TB_Zero_Fill IS
END TB_Zero_Fill;
 
ARCHITECTURE behavior OF TB_Zero_Fill IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Zero_Fill
    PORT(
         Const4bit : in  STD_LOGIC_VECTOR(3 downto 0);
         Output16bit : out  bit_16
        );
    END COMPONENT;
    

   --Inputs
   signal Const4 : std_logic_vector(3 downto 0);

 	--Outputs
   signal Output16 : bit_16;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Zero_Fill PORT MAP (
          Const4bit => Const4,
          Output16bit => Output16
        );

   -- Stimulus process
   stim_proc: process
   begin		
      Const4	<=	"1010";
		wait for 2ns;
		Const4	<=	"1000";
      wait;
   end process;

END;
