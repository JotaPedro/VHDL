--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:47:30 07/29/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_SigExt.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SigExt
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
 
ENTITY TB_SigExt IS
END TB_SigExt;
 
ARCHITECTURE behavior OF TB_SigExt IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SigExt
    PORT(
         Const8x2 : IN  std_logic_vector(7 downto 0);
         Output16bit : out  bit_16
        );
    END COMPONENT;
    

   --Inputs
   signal Const8 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Output16 : bit_16;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SigExt PORT MAP (
          Const8x2 => Const8,
          Output16bit => Output16
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      Const8	<=	"00101010";
      wait;
   end process;

END;
