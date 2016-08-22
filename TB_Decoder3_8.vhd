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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY TB_Decoder3_8 IS
END TB_Decoder3_8;
 
ARCHITECTURE behavior OF TB_Decoder3_8 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder3_8
    PORT(
         AddrSD_port : IN  std_logic_vector(2 downto 0);
         Enable_port : IN  std_logic;
         Output_port : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal AddrSD : std_logic_vector(2 downto 0);
   signal Enable : std_logic := '0';

 	--Outputs
   signal Output : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder3_8 PORT MAP (
          AddrSD_port => AddrSD,
          Enable_port => Enable,
          Output_port => Output
        );
 
   -- Stimulus process
   stim_proc: process
   begin
		AddrSD <= "000";
      wait for 2 ns;
		Enable <= '1';
		AddrSD <= "000";
      wait for 2 ns;
		AddrSD <= "001";
      wait for 2 ns;
		AddrSD <= "010";
      wait for 2 ns;
		AddrSD <= "011";
      wait for 2 ns;
		AddrSD <= "100";
      wait for 2 ns;
		AddrSD <= "101";
      wait for 2 ns;
		AddrSD <= "110";
      wait for 2 ns;
		AddrSD <= "111";
		wait;
   end process;
END;
