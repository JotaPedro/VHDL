--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:38:32 05/11/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/PFC16_17/FPGA_PDS/RegisterFile8x16_TB.vhd
-- Project Name:  FPGA_PDS
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RegisterFile8x16_TB IS
END RegisterFile8x16_TB;
 
ARCHITECTURE behavior OF RegisterFile8x16_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile8x16
    PORT(
         DestData : IN  std_logic_vector(15 downto 0);
         AddrA : IN  std_logic_vector(2 downto 0);
         AddrB : IN  std_logic_vector(2 downto 0);
         AddrSD : IN  std_logic_vector(2 downto 0);
         clock : IN  std_logic;
         RFC : IN  std_logic_vector(4 downto 0);
         flagsIN : IN  std_logic_vector(3 downto 0);
         CL : IN  std_logic;
         OpA : OUT  std_logic_vector(15 downto 0);
         OpB : OUT  std_logic_vector(15 downto 0);
         SC : OUT  std_logic_vector(15 downto 0);
         flagsOUT : OUT  std_logic_vector(4 downto 0);
         PCout : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DestData : std_logic_vector(15 downto 0) := (others => '0');
   signal AddrA : std_logic_vector(2 downto 0) := (others => '0');
   signal AddrB : std_logic_vector(2 downto 0) := (others => '0');
   signal AddrSD : std_logic_vector(2 downto 0) := (others => '0');
   signal clock : std_logic := '0';
   signal RFC : std_logic_vector(4 downto 0) := (others => '0');
   signal flagsIN : std_logic_vector(3 downto 0) := (others => '0');
   signal CL : std_logic := '0';

 	--Outputs
   signal OpA : std_logic_vector(15 downto 0);
   signal OpB : std_logic_vector(15 downto 0);
   signal SC : std_logic_vector(15 downto 0);
   signal flagsOUT : std_logic_vector(4 downto 0);
   signal PCout : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile8x16 PORT MAP (
          DestData => DestData,
          AddrA => AddrA,
          AddrB => AddrB,
          AddrSD => AddrSD,
          clock => clock,
          RFC => RFC,
          flagsIN => flagsIN,
          CL => CL,
          OpA => OpA,
          OpB => OpB,
          SC => SC,
          flagsOUT => flagsOUT,
          PCout => PCout
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 
		RFC <= "00001";
		wait for 10 ns;	
		AddrSD <= "010";
		wait for 10 ns;	
		DestData <= "0000000000000101";
		
		wait for 15 ns;
		RFC <= "00000";
		AddrA <= "010";
		--
      wait;
   end process;

END;
