--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:04:33 08/10/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Block_Mplex16to1.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Block_Mplex16to1
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
 
ENTITY TB_Block_Mplex16to1 IS
END TB_Block_Mplex16to1;
 
ARCHITECTURE behavior OF TB_Block_Mplex16to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Block_Mplex16to1
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         Mp2to1_in : OUT  std_logic_vector(15 downto 0);
         B_negativo : in  STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A1 : std_logic_vector(15 downto 0) := (others => '0');
   signal B_negativo1 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

 	--Outputs
   signal Mp2to1_in1 : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Block_Mplex16to1 PORT MAP (
          A => A1,
          Mp2to1_in => Mp2to1_in1,
          B_negativo => B_negativo1
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      A1 <= ("0000000000000001");
		B_negativo1 <= "0001";
      wait;
   end process;

END;
