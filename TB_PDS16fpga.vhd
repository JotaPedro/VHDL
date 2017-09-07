--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:11:27 09/06/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_PDS16fpga.vhd
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
use work.pds16_types.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_PDS16fpga IS
END TB_PDS16fpga;
 
ARCHITECTURE behavior OF TB_PDS16fpga IS 
 
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
			-- Saídas para teste apenas
			  DataIn_sig_out: out STD_LOGIC_VECTOR (15 downto 0);
			  instruction_out: out STD_LOGIC_VECTOR (15 downto 0);
			  PC_sig_out: out STD_LOGIC_VECTOR (15 downto 0);
			  Addr_sig_out: out STD_LOGIC_VECTOR (15 downto 0)
			
        );
    END COMPONENT;
    
	-- Saídas para teste apenas
	signal DataIn_sig_out:  STD_LOGIC_VECTOR (15 downto 0);
	signal instruction_out: STD_LOGIC_VECTOR (15 downto 0);
	signal PC_sig_out:  STD_LOGIC_VECTOR (15 downto 0);
	signal Addr_sig_out:  STD_LOGIC_VECTOR (15 downto 0);
	 

   --Inputs
   signal EXINT : std_logic := '0';
   signal MCLK : std_logic := '0';
   signal RESET : std_logic := '1';
   signal RDY : std_logic := '1';
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

   -- Clock period definitions
   constant MCLK_period : time := 50 ns;
	
	
	signal WR_ram_sig: std_logic_vector(1 downto 0);
 
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
			 
			 -- Saídas para teste apenas
			  DataIn_sig_out => DataIn_sig_out,
			  instruction_out => instruction_out,
			  PC_sig_out => PC_sig_out,
			  Addr_sig_out => Addr_sig_out
			 
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
--		RESET	<= '0';
----como não estou a conseguir obter resultados no testbench:
--		--vou testar se é porque não estou a conseguir inserir dados na memória antes do arranque.
--		-- Para tal vou forçar a entrada de dados na ram antes de desativar o reset do pds16.
--		AD0_15 <= x"0000";				--por o address na posição #0.
--		ALE	 <= '1';						
--		wait for 50 ns;
--		ALE	 <= '0';	
--		AD0_15 <= "0000000000001000"; --LDI R0,#1
--		WR_ram_sig <= "11";				-- escrever word.
--		wait for 50 ns;
--		WR_ram_sig <= "00";
--		AD0_15 <= "ZZZZZZZZZZZZZZZZ"; -- colocar o bus em alta inpedancia só para diferenciar das proximas instruções.
--		wait for 50 ns;
		-- inciar o processador.
      RESET	<= '0';
		wait for 50 ns;
		RESET	<= '1';
--		wait for 120 ns;
--		RESET <= '0';
      wait;
   end process;

END;
