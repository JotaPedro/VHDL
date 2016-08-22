--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:45:20 08/10/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Shifter_Sel_mplex2to1.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Shifter_Sel_mplex2to1
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
 
ENTITY TB_Shifter_Sel_mplex2to1 IS
END TB_Shifter_Sel_mplex2to1;
 
ARCHITECTURE behavior OF TB_Shifter_Sel_mplex2to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Shifter_Sel_mplex2to1
    PORT(
         Decoder_1 : IN  std_logic_vector(15 downto 0);
         Decoder_2 : IN  std_logic_vector(15 downto 0);
         Mp2to1_sel : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Decoder_1 : std_logic_vector(15 downto 0) := (others => '0');
   signal Decoder_2 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Mp2to1_sel : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Shifter_Sel_mplex2to1 PORT MAP (
          Decoder_1 => Decoder_1,
          Decoder_2 => Decoder_2,
          Mp2to1_sel => Mp2to1_sel
        );
 
   -- Stimulus process
   stim_proc: process
   begin	
		Decoder_1 <= ("0000000000000010");
		Decoder_2 <= ("0000000000000000");
      wait for 2 ns;
		Decoder_1 <= ("0000000000000010");
		Decoder_2 <= ("0001000000000000");
		wait;
   end process;

END;
