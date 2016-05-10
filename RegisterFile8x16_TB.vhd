--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:24:36 04/29/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/RegisterFile8x16_TB.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterFile8x16
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
 
ENTITY RegisterFile8x16_TB IS
END RegisterFile8x16_TB;
 
ARCHITECTURE behavior OF RegisterFile8x16_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile8x16
    PORT(
         clock : IN  std_logic;
         addressSD : IN  std_logic_vector(2 downto 0);
         flags : IN  std_logic_vector(3 downto 0);
         RFC : IN  std_logic_vector(4 downto 0);
         CL : IN  std_logic;
         addrA : IN  std_logic_vector(2 downto 0);
         addrB : IN  std_logic_vector(2 downto 0);
         DestData : IN  std_logic_vector(15 downto 0);
         flags_output : OUT  std_logic_vector(2 downto 0);
         PC : INOUT  std_logic_vector(15 downto 0);
         Output_A : OUT  std_logic_vector(15 downto 0);
         Output_B : OUT  std_logic_vector(15 downto 0);
         Output_Sc : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal addressSD : std_logic_vector(2 downto 0) := (others => '0');
   signal flags : std_logic_vector(3 downto 0) := (others => '0');
   signal RFC : std_logic_vector(4 downto 0) := (others => '0');
   signal CL : std_logic := '0';
   signal addrA : std_logic_vector(2 downto 0) := (others => '0');
   signal addrB : std_logic_vector(2 downto 0) := (others => '0');
   signal DestData : std_logic_vector(15 downto 0) := (others => '0');

	--BiDirs
   signal PC : std_logic_vector(15 downto 0);

 	--Outputs
   signal flags_output : std_logic_vector(2 downto 0);
   signal Output_A : std_logic_vector(15 downto 0);
   signal Output_B : std_logic_vector(15 downto 0);
   signal Output_Sc : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clock_period : time := 1us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile8x16 PORT MAP (
          clock => clock,
          addressSD => addressSD,
          flags => flags,
          RFC => RFC,
          CL => CL,
          addrA => addrA,
          addrB => addrB,
          DestData => DestData,
          flags_output => flags_output,
          PC => PC,
          Output_A => Output_A,
          Output_B => Output_B,
          Output_Sc => Output_Sc
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
      wait for 100ms;	

      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
