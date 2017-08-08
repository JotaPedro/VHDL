--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:57:36 07/31/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Control.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control
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
use work.pds16_types.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_Control IS
END TB_Control;
 
ARCHITECTURE behavior OF TB_Control IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         WL : IN  std_logic;
         Flags : IN  std_logic_vector(2 downto 0);
         OpCode : IN  std_logic_vector(6 downto 0);
         INTP : IN  std_logic;
         Clock : IN  std_logic;
         CL : IN  std_logic;
         Sync : IN  std_logic_vector(1 downto 0);
         BusCtr : OUT  std_logic_vector(3 downto 0);
         RFC : OUT  std_logic_vector(4 downto 0);
         ALUC : OUT  std_logic_vector(2 downto 0);
         SelAddr : OUT  std_logic_vector(1 downto 0);
         SelData : OUT  std_logic_vector(1 downto 0);
         Sellmm : OUT  std_logic;
         RD : OUT  std_logic;
         WR : OUT  std_logic_vector(1 downto 0);
         BGT : OUT  std_logic;
         S1S0 : OUT  std_logic_vector(1 downto 0);
         EIR : OUT  std_logic;
         CState : OUT  STATE_TYPE;
         inst : OUT  INST_TYPE
        );
    END COMPONENT;
    

   --Inputs
   signal WL : std_logic := '0';
   signal Flags : std_logic_vector(2 downto 0) := (others => '0');
   signal OpCode : std_logic_vector(6 downto 0) := (others => '0');
   signal INTP : std_logic := '0';
   signal Clock : std_logic := '0';
   signal CL : std_logic := '0';
   signal Sync : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal BusCtr : std_logic_vector(3 downto 0);
   signal RFC : std_logic_vector(4 downto 0);
   signal ALUC : std_logic_vector(2 downto 0);
   signal SelAddr : std_logic_vector(1 downto 0);
   signal SelData : std_logic_vector(1 downto 0);
   signal Sellmm : std_logic;
   signal RD : std_logic;
   signal WR : std_logic_vector(1 downto 0);
   signal BGT : std_logic;
   signal S1S0 : std_logic_vector(1 downto 0);
   signal EIR : std_logic;
   signal CState : STATE_TYPE;
   signal inst : INST_TYPE;

   -- Clock period definitions
   constant Clock_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          WL => WL,
          Flags => Flags,
          OpCode => OpCode,
          INTP => INTP,
          Clock => Clock,
          CL => CL,
          Sync => Sync,
          BusCtr => BusCtr,
          RFC => RFC,
          ALUC => ALUC,
          SelAddr => SelAddr,
          SelData => SelData,
          Sellmm => Sellmm,
          RD => RD,
          WR => WR,
          BGT => BGT,
          S1S0 => S1S0,
          EIR => EIR,
          CState => CState,
          inst => inst
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '1';
		wait for Clock_period/2;
		Clock <= '0';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		
      Sync(1)<= '1';
      OpCode <= "0000000";
		wait for 150 ns;
		--OpCode <= "0000100";
		OpCode <= "0000101";
		wait for 200 ns;
		OpCode <= "1000000";
		wait for 200 ns;
		OpCode <= "1100000";

      wait;
   end process;

END;
