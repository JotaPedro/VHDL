--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:28:55 09/15/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_RegisterFileBS.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterFileBS
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
 
ENTITY TB_RegisterFileBS IS
END TB_RegisterFileBS;
 
ARCHITECTURE behavior OF TB_RegisterFileBS IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFileBS
    PORT(
         clock : IN  std_logic;
         RFC : IN  std_logic_vector(12 downto 0);
         destData : IN  std_logic_vector(15 downto 0);
         flagsIn : IN  std_logic_vector(3 downto 0);
         AddrSD : IN  std_logic_vector(2 downto 0);
         AddrA : IN  std_logic_vector(2 downto 0);
         AddrB : IN  std_logic_vector(2 downto 0);
         CL : IN  std_logic;
         flagsOut : OUT  std_logic_vector(5 downto 0);
         PC : OUT  std_logic_vector(15 downto 0);
         OpA : OUT  std_logic_vector(15 downto 0);
         OpB : OUT  std_logic_vector(15 downto 0);
         Sc : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal RFC : std_logic_vector(12 downto 0) := (others => '0');
   signal destData : std_logic_vector(15 downto 0) := (others => '0');
   signal flagsIn : std_logic_vector(3 downto 0) := (others => '0');
   signal AddrSD : std_logic_vector(2 downto 0) := (others => '0');
   signal AddrA : std_logic_vector(2 downto 0) := (others => '0');
   signal AddrB : std_logic_vector(2 downto 0) := (others => '0');
   signal CL : std_logic := '0';

 	--Outputs
   signal flagsOut : std_logic_vector(5 downto 0);
   signal PC : std_logic_vector(15 downto 0);
   signal OpA : std_logic_vector(15 downto 0);
   signal OpB : std_logic_vector(15 downto 0);
   signal Sc : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFileBS PORT MAP (
          clock => clock,
          RFC => RFC,
          destData => destData,
          flagsIn => flagsIn,
          AddrSD => AddrSD,
          AddrA => AddrA,
          AddrB => AddrB,
          CL => CL,
          flagsOut => flagsOut,
          PC => PC,
          OpA => OpA,
          OpB => OpB,
          Sc => Sc
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
      CL <= '1';
		
		wait for 100 ns;	


		CL <= '0';

      wait for clock_period*10;

		RFC <= "0001000001001";
		destData <= "1111111100110011";
		AddrSD <= "001";
		
		wait for 13 ns;
		
		RFC <= "0001001001100";
		AddrA <= "001";

      wait;
   end process;

END;
