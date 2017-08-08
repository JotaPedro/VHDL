--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:38:45 07/28/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_PC_Adder.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PC_Adder
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
 
ENTITY TB_PC_Adder IS
END TB_PC_Adder;
 
ARCHITECTURE behavior OF TB_PC_Adder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC_Adder
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         Result : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0);
   signal B : std_logic_vector(15 downto 0);

 	--Outputs
   signal Result : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC_Adder PORT MAP (
          A => A,
          B => B,
          Result => Result
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      A	<= "0000000000000000";
		B	<= "0000000000000010";
		wait for 2ns;
		A	<=	Result;
		wait for 2ns;
		A	<=	Result;
		wait for 2ns;
		A	<=	Result;
		wait;	
   end process;

END;
