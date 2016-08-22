--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:57:07 08/03/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Mplex4to1.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mplex4to1
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
 
ENTITY TB_Mplex4to1 IS
END TB_Mplex4to1;
 
ARCHITECTURE behavior OF TB_Mplex4to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mplex4to1
    PORT(
         Input : IN  std_logic_vector(3 downto 0);
         Sel : IN  std_logic_vector(1 downto 0);
         Output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Input1 : std_logic_vector(3 downto 0) := (others => '0');
   signal Sel1 : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Output1 : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mplex4to1 PORT MAP (
          Input => Input1,
          Sel => Sel1,
          Output => Output1
        );
 
   Input1(0) <= '0';--0
	Input1(1) <= '1';--1
	Input1(2) <= '1';--2
	Input1(3) <= '0';--3
 
   -- Stimulus process
   stim_proc: process
   begin
		Sel1 <= "00";
		wait for 2 ns;
		Sel1 <= "01";
		wait for 2 ns;
		Sel1 <= "10";
		wait for 2 ns;
		Sel1 <= "11";
      wait;
   end process;

END;
