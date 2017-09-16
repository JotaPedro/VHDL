--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:26:42 09/15/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_PDS16fpga_V2.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PDS16fpga_V2
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
 
ENTITY TB_PDS16fpga_V2 IS
END TB_PDS16fpga_V2;
 
ARCHITECTURE behavior OF TB_PDS16fpga_V2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PDS16fpga_V2
    PORT(
         MCLK : IN  std_logic;
         RESET : IN  std_logic;
         EXINT : IN  std_logic;
         AD0_15 : INOUT  std_logic_vector(15 downto 0);
			RDY : in  STD_LOGIC;
			BRQ : in  STD_LOGIC;
         ALE : OUT  std_logic;
         S0 : OUT  std_logic;
         S1 : OUT  std_logic;
         RD : OUT  std_logic;
         WRL : OUT  std_logic;
         WRH : OUT  std_logic;
         BGT : OUT  std_logic;
         RESOUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal MCLK : std_logic := '0';
   signal RESET : std_logic := '1';
   signal EXINT : std_logic := '1';
	signal RDY : STD_LOGIC :='1';
	signal BRQ : STD_LOGIC :='0';

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

   -- Clock period definitions
   constant MCLK_period : time := 60 ns;
	
	
	signal WR_ram_sig: std_logic_vector(1 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PDS16fpga_V2 PORT MAP (
          MCLK => MCLK,
          RESET => RESET,
          EXINT => EXINT,
          AD0_15 => AD0_15,
			 RDY	=> RDY,
			 BRQ	=> BRQ,
          ALE => ALE,
          S0 => S0,
          S1 => S1,
          RD => RD,
          WRL => WRL,
          WRH => WRH,
          BGT => BGT,
          RESOUT => RESOUT
        );
		  
	------------------------
	-- RAM
	------------------------
	
	WR_ram_sig(0) <= WRL;
	WR_ram_sig(1) <= WRH;
	
	Ram: Ram2 PORT MAP(
		AD   	=> AD0_15,--:inout std_logic_vector (15 downto 0);  -- bi-directional data/address
		nWR   => WR_ram_sig,--:in    std_logic_vector(1 downto 0);             -- Write Enable (High/Low)
		nRD   => RD,--:in    std_logic;                                 	-- Read Enable
		ALE	=> ALE --:in	 std_logic
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
      RESET <= '0';
		wait for 100 ns;
		RESET <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
