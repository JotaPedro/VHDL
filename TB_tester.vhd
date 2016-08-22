--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:40:39 08/10/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_tester.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PDS16fpga
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
 
ENTITY TB_tester IS
END TB_tester;
 
ARCHITECTURE behavior OF TB_tester IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PDS16fpga
    PORT(
         EXINT : IN  std_logic;
         MCLK : IN  std_logic;
         RESET : IN  std_logic;
         AD_0_15 : INOUT  std_logic_vector(15 downto 0);
         ALE : OUT  std_logic;
         SO : OUT  std_logic;
         S1 : OUT  std_logic;
         RD : OUT  std_logic;
         WRL : OUT  std_logic;
         WRH : OUT  std_logic;
         RDY : IN  std_logic;
         BRQ : IN  std_logic;
         BGT : OUT  std_logic;
         RESOUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal EXINT : std_logic := '0';
   signal MCLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal RDY : std_logic := '0';
   signal BRQ : std_logic := '0';

	--BiDirs
   signal AD_0_15 : std_logic_vector(15 downto 0);

 	--Outputs
   signal ALE : std_logic;
   signal SO : std_logic;
   signal S1 : std_logic;
   signal RD : std_logic;
   signal WRL : std_logic;
   signal WRH : std_logic;
   signal BGT : std_logic;
   signal RESOUT : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PDS16fpga PORT MAP (
          EXINT => EXINT,
          MCLK => MCLK,
          RESET => RESET,
          AD_0_15 => AD_0_15,
          ALE => ALE,
          SO => SO,
          S1 => S1,
          RD => RD,
          WRL => WRL,
          WRH => WRH,
          RDY => RDY,
          BRQ => BRQ,
          BGT => BGT,
          RESOUT => RESOUT
        );
 
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period := 1ns;
 
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
      wait for 100ms;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
