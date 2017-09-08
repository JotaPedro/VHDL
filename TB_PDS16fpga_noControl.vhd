--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:19:17 09/07/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_PDS16fpga_noControl.vhd
-- Project Name:  work
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_PDS16fpga_noControl IS
END TB_PDS16fpga_noControl;
 
ARCHITECTURE behavior OF TB_PDS16fpga_noControl IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PDS16fpga
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
         Addr_sig_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal EXINT : std_logic := '0';
   signal MCLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal RDY : std_logic := '0';
   signal BRQ : std_logic := '0';

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
   constant MCLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PDS16fpga PORT MAP (
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
          Addr_sig_out => Addr_sig_out
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for MCLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
