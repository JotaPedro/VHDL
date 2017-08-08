--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:09:52 08/06/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Barrel_shift.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Barrel_shift
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
 
ENTITY TB_Barrel_shift IS
END TB_Barrel_shift;
 
ARCHITECTURE behavior OF TB_Barrel_shift IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Barrel_shift
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(15 downto 0);
         Ctl_3bit : IN  std_logic_vector(2 downto 0);
         Cy : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A1 : std_logic_vector(15 downto 0) := (others => '0');
   signal Ctl_3bit1 : std_logic_vector(2 downto 0) := (others => '0');
   signal B1 : std_logic_vector(3 downto 0):= (others => '0');

 	--Outputs
   signal Output1 : std_logic_vector(15 downto 0);
   signal Cy1 : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Barrel_shift PORT MAP (
          A => A1,
          B => B1,
          Output => Output1,
          Ctl_3bit => Ctl_3bit1,--IR10 , 11, 12
          Cy => Cy1
        );

   -- Stimulus process
   stim_proc: process
   begin
      A1 <= ("1000000000001000");
		Ctl_3bit1 <= ("100"); -- ROTATEnSHIFT, RIGHTnLEFT, SIN;
		B1 <= ("0001");
		wait for 1 ns;
		A1 <= ("1000000000001000");
		Ctl_3bit1 <= ("100"); -- ROTATEnSHIFT, RIGHTnLEFT, SIN;
		B1 <= ("0001");
      wait;
   end process;

END;
