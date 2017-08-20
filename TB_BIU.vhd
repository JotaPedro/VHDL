--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:56:53 08/20/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_BIU.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BIU
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
 
ENTITY TB_BIU IS
END TB_BIU;
 
ARCHITECTURE behavior OF TB_BIU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BIU
    PORT(
         Clock : IN  std_logic;
         CL : IN  std_logic;
         DataOut : IN  std_logic_vector(15 downto 0);
         BusCtr : IN  std_logic_vector(3 downto 0);
         Addr : IN  std_logic_vector(14 downto 0);
         AD : INOUT  std_logic_vector(15 downto 0);
         S1S0_in : IN  std_logic_vector(1 downto 0);
         S1S0_out : OUT  std_logic_vector(1 downto 0);
         RD : IN  std_logic;
         nRD : OUT  std_logic;
         WRL : IN  std_logic;
         nWRL : OUT  std_logic;
         WRH : IN  std_logic;
         nWRH : OUT  std_logic;
         RDY : IN  std_logic;
         BRQ : IN  std_logic;
         BGT_in : IN  std_logic;
         BGT_out : OUT  std_logic;
         DataIn : OUT  std_logic_vector(15 downto 0);
         Sync : OUT  std_logic_vector(1 downto 0);
         A0 : OUT  std_logic;
         RESOUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal CL : std_logic := '0';
   signal DataOut : std_logic_vector(15 downto 0) := (others => '0');
   signal BusCtr : std_logic_vector(3 downto 0) := (others => '0');
   signal Addr : std_logic_vector(14 downto 0) := (others => '0');
   signal S1S0_in : std_logic_vector(1 downto 0) := (others => '0');
   signal RD : std_logic := '0';
   signal WRL : std_logic := '0';
   signal WRH : std_logic := '0';
   signal RDY : std_logic := '0';
   signal BRQ : std_logic := '0';
   signal BGT_in : std_logic := '0';

	--BiDirs
   signal AD : std_logic_vector(15 downto 0);

 	--Outputs
   signal S1S0_out : std_logic_vector(1 downto 0);
   signal nRD : std_logic;
   signal nWRL : std_logic;
   signal nWRH : std_logic;
   signal BGT_out : std_logic;
   signal DataIn : std_logic_vector(15 downto 0);
   signal Sync : std_logic_vector(1 downto 0);
   signal A0 : std_logic;
   signal RESOUT : std_logic;

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BIU PORT MAP (
          Clock => Clock,
          CL => CL,
          DataOut => DataOut,
          BusCtr => BusCtr,
          Addr => Addr,
          AD => AD,
          S1S0_in => S1S0_in,
          S1S0_out => S1S0_out,
          RD => RD,
          nRD => nRD,
          WRL => WRL,
          nWRL => nWRL,
          WRH => WRH,
          nWRH => nWRH,
          RDY => RDY,
          BRQ => BRQ,
          BGT_in => BGT_in,
          BGT_out => BGT_out,
          DataIn => DataIn,
          Sync => Sync,
          A0 => A0,
          RESOUT => RESOUT
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		
		
      wait;
   end process;

END;
