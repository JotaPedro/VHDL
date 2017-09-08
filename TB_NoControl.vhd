--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:10:31 09/08/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Nocontrol.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: No_ctrl_pds
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
 
ENTITY TB_Nocontrol IS
END TB_Nocontrol;
 
ARCHITECTURE behavior OF TB_Nocontrol IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT No_ctrl_pds
    PORT(
         EXINT : IN  std_logic;
         MCLK : IN  std_logic;
         RESET : IN  std_logic;
         RDY : IN  std_logic;
         BRQ : IN  std_logic;
         AD0_15 : INOUT  std_logic_vector(15 downto 0);
         ALE : OUT  std_logic;
         S0 : OUT  std_logic;
         S1 : OUT  std_logic;
         RD : OUT  std_logic;
         WRL : OUT  std_logic;
         WRH : OUT  std_logic;
         BGT : OUT  std_logic;
         RESOUT : OUT  std_logic;
         DataIn_sig_out : OUT  std_logic_vector(15 downto 0);
         instruction_out : OUT  std_logic_vector(15 downto 0);
         PC_sig_out : OUT  std_logic_vector(15 downto 0);
         Addr_sig_out : OUT  std_logic_vector(15 downto 0);
         BusCtr_sig : IN  std_logic_vector(3 downto 0);
         RFC_sig : IN  std_logic_vector(5 downto 0);
         ALUCtrl_sig : IN  std_logic_vector(2 downto 0);
         SelAddr_sig : IN  std_logic_vector(1 downto 0);
         SelData_sig : IN  std_logic_vector(1 downto 0);
         SelImm_sig : IN  std_logic;
         RD_ctrl_sig : IN  std_logic;
         WR_ctrl_sig : IN  std_logic_vector(1 downto 0);
         BGT_sig : IN  std_logic;
         S1S0_sig : IN  std_logic_vector(1 downto 0);
         EIR_sig : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal EXINT : std_logic := '0';
   signal MCLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal RDY : std_logic := '0';
   signal BRQ : std_logic := '0';
   signal BusCtr_sig : std_logic_vector(3 downto 0) := (others => '0');
   signal RFC_sig : std_logic_vector(5 downto 0) := (others => '0');
   signal ALUCtrl_sig : std_logic_vector(2 downto 0) := (others => '0');
   signal SelAddr_sig : std_logic_vector(1 downto 0) := (others => '0');
   signal SelData_sig : std_logic_vector(1 downto 0) := (others => '0');
   signal SelImm_sig : std_logic := '0';
   signal RD_ctrl_sig : std_logic := '0';
   signal WR_ctrl_sig : std_logic_vector(1 downto 0) := (others => '0');
   signal BGT_sig : std_logic := '0';
   signal S1S0_sig : std_logic_vector(1 downto 0) := (others => '0');
   signal EIR_sig : std_logic := '0';

	--BiDirs
   signal AD0_15 : std_logic_vector(15 downto 0);

 	--Outputs
   signal ALE : std_logic;
   signal S0 : std_logic;
   signal S1 : std_logic;
   signal RD : std_logic;
   signal WRL : std_logic;
   signal WRH : std_logic;
   signal BGT : std_logic;
   signal RESOUT : std_logic;
   signal DataIn_sig_out : std_logic_vector(15 downto 0);
   signal instruction_out : std_logic_vector(15 downto 0);
   signal PC_sig_out : std_logic_vector(15 downto 0);
   signal Addr_sig_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant MCLK_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: No_ctrl_pds PORT MAP (
          EXINT => EXINT,
          MCLK => MCLK,
          RESET => RESET,
          RDY => RDY,
          BRQ => BRQ,
          AD0_15 => AD0_15,
          ALE => ALE,
          S0 => S0,
          S1 => S1,
          RD => RD,
          WRL => WRL,
          WRH => WRH,
          BGT => BGT,
          RESOUT => RESOUT,
          DataIn_sig_out => DataIn_sig_out,
          instruction_out => instruction_out,
          PC_sig_out => PC_sig_out,
          Addr_sig_out => Addr_sig_out,
          BusCtr_sig => BusCtr_sig,
          RFC_sig => RFC_sig,
          ALUCtrl_sig => ALUCtrl_sig,
          SelAddr_sig => SelAddr_sig,
          SelData_sig => SelData_sig,
          SelImm_sig => SelImm_sig,
          RD_ctrl_sig => RD_ctrl_sig,
          WR_ctrl_sig => WR_ctrl_sig,
          BGT_sig => BGT_sig,
          S1S0_sig => S1S0_sig,
          EIR_sig => EIR_sig
        );

   -- Clock process definitions
   MCLK_process :process
   begin
		MCLK <= '0';
		wait for MCLK_period/2;
		MCLK <= '1';
		wait for MCLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		wait for 50 ns;
		RFC_sig <= "001000";
		RESET	<= '1';
		wait for 200 ns;
		RFC_sig <= "001000";
		RESET	<= '0';
		
      wait;
   end process;

END;
