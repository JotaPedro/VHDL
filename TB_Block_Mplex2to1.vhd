--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:18:20 08/11/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Block_Mplex2to1.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Block_Mplex2to1
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
 
ENTITY TB_Block_Mplex2to1 IS
END TB_Block_Mplex2to1;
 
ARCHITECTURE behavior OF TB_Block_Mplex2to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Block_Mplex2to1
    PORT(
         Input1 : IN  std_logic_vector(15 downto 0);
         Input2 : IN  std_logic;
         Output : OUT  std_logic_vector(15 downto 0);
         Sel : IN  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input11 : std_logic_vector(15 downto 0) := (others => '0');
   signal Input21 : std_logic := '0';
   signal Sel1 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Output1 : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Block_Mplex2to1 PORT MAP (
          Input1 => Input11,
          Input2 => Input21,
          Output => Output1,
          Sel => Sel1
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      Input11 	<= ("0000000000000001");
		Input21 	<= '0';
		Sel1		<= ("1001001001001000");
      wait;
   end process;

END;
