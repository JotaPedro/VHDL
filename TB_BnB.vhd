--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:05:40 08/10/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_BnB.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BnB
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
 
ENTITY TB_BnB IS
END TB_BnB;
 
ARCHITECTURE behavior OF TB_BnB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BnB
    PORT(
         B : IN  std_logic_vector(3 downto 0);
         IR11 : IN  std_logic;
         B_negativo : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal B1 : std_logic_vector(3 downto 0) := (others => '0');
   signal IR111 : std_logic := '0';

 	--Outputs
   signal B_negativo1 : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BnB PORT MAP (
          B => B1,
          IR11 => IR111,
          B_negativo => B_negativo1
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      B1 <= ("0001");
		IR111 <= '1';
      wait;
   end process;

END;
