--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:00:49 08/27/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_ImmZeroFill.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ImmZeroFill
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
 
ENTITY TB_ImmZeroFill IS
END TB_ImmZeroFill;
 
ARCHITECTURE behavior OF TB_ImmZeroFill IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ImmZeroFill
    PORT(
         LSB : IN  std_logic_vector(7 downto 0);
         SelImm : IN  std_logic;
         Output : OUT  std_logic_vector(15 downto 0);
         Input : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal LSB1 : std_logic_vector(7 downto 0) := (others => '0');
   signal SelImm1 : std_logic;-- := '0';
   signal Input1 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Output1 : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ImmZeroFill PORT MAP (
          LSB => LSB1,
          SelImm => SelImm1,
          Output => Output1,
          Input => Input1
        );

   -- Stimulus process
   stim_proc: process
   begin		
		SelImm1	<= '0';
		LSB1		<= "11111111";
		Input1	<= "00000001";
		wait for 100 ns;
		SelImm1	<= '1';
		wait;
   end process;

END;
