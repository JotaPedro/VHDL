--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:46:12 08/26/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Control_Biu_Ram.vhd
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_Control_Biu_Ram IS
END TB_Control_Biu_Ram;
 
ARCHITECTURE behavior OF TB_Control_Biu_Ram IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         A0 : IN  std_logic;
         Flags : IN  std_logic_vector(2 downto 0);
         OpCode : IN  std_logic_vector(6 downto 0);
         INTP : IN  std_logic;
         Clock : IN  std_logic;
         CL : IN  std_logic;
         Sync : IN  std_logic_vector(1 downto 0);
         BusCtr : OUT  std_logic_vector(3 downto 0);
         RFC : OUT  std_logic_vector(5 downto 0);
         ALUC : OUT  std_logic_vector(2 downto 0);
         SelAddr : OUT  std_logic_vector(1 downto 0);
         SelData : OUT  std_logic_vector(1 downto 0);
         Sellmm : OUT  std_logic;
         RD : OUT  std_logic;
         WR : OUT  std_logic_vector(1 downto 0);
         BGT : OUT  std_logic;
         S1S0 : OUT  std_logic_vector(1 downto 0);
         EIR : OUT  std_logic;
         CState : OUT  std_logic;
         inst : OUT  std_logic
        );
    END COMPONENT;
    
	
   --Inputs
   signal A0 : std_logic := '0';
   signal Flags : std_logic_vector(2 downto 0) := (others => '0');
   signal OpCode : std_logic_vector(6 downto 0) := (others => '0');
   signal INTP : std_logic := '0';
   signal Clock : std_logic := '0';
   signal CL : std_logic := '0';
   signal Sync : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal BusCtr : std_logic_vector(3 downto 0);
   signal RFC : std_logic_vector(5 downto 0);
   signal ALUC : std_logic_vector(2 downto 0);
   signal SelAddr : std_logic_vector(1 downto 0);
   signal SelData : std_logic_vector(1 downto 0);
   signal Sellmm : std_logic;
   signal RD : std_logic;
   signal WR : std_logic_vector(1 downto 0);
   signal BGT : std_logic;
   signal S1S0 : std_logic_vector(1 downto 0);
   signal EIR : std_logic;
   signal CState : std_logic;
   signal inst : std_logic;

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
         Addr_out : OUT  std_logic_vector(14 downto 0);
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
   signal Addr_out : std_logic_vector(14 downto 0);
   signal RESOUT : std_logic;

----------------------------------------------------------------------   
	-- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Ram2
    PORT(

         AD : IN  std_logic_vector(14 downto 0);
         DATA : INOUT  std_logic_vector(15 downto 0);
         nWR : IN  std_logic_vector(1 downto 0);
         nRD : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal nWR : std_logic_vector(1 downto 0) := (others => '0');
	
----------------------------------------------------------------------   
	
	
	-- Clock period definitions
   constant Clock_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          A0 => A0,
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
		  
	uut2: BIU PORT MAP (
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
          Addr_out => Addr_out,
          RESOUT => RESOUT
        );
		  
	nWR(0) <= nWRL;
	nWR(1) <= nWRH;
	-- Instantiate the Unit Under Test (UUT)
   uut3: Ram2 PORT MAP (

          AD => Addr_out,
          DATA => AD,
          nWR => nWR,
          nRD => nRD
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
