--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:55:36 09/07/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_RF_BIU_RAM.vhd
-- Project Name:  work
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
 
ENTITY TB_RF_BIU_RAM IS
END TB_RF_BIU_RAM;
 
ARCHITECTURE behavior OF TB_RF_BIU_RAM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile8x16
    PORT(
         clock : IN  std_logic;
         CL : IN  std_logic;
         RFC : IN  std_logic_vector(5 downto 0);
         AddrA : IN  std_logic_vector(2 downto 0);
         AddrB : IN  std_logic_vector(2 downto 0);
         AddrSD : IN  std_logic_vector(2 downto 0);
         DestData : IN  std_logic_vector(15 downto 0);
         flagsIN : IN  std_logic_vector(3 downto 0);
         OpA : OUT  std_logic_vector(15 downto 0);
         OpB : OUT  std_logic_vector(15 downto 0);
         SC : OUT  std_logic_vector(15 downto 0);
         flagsOUT : OUT  std_logic_vector(4 downto 0);
         PCout : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
	 --Inputs
   signal clock : std_logic := '0';
   signal CL : std_logic := '0';
   signal RFC : std_logic_vector(5 downto 0) := (others => '0');
   signal AddrA : std_logic_vector(2 downto 0) := (others => '0');
   signal AddrB : std_logic_vector(2 downto 0) := (others => '0');
   signal AddrSD : std_logic_vector(2 downto 0) := (others => '0');
   signal DestData : std_logic_vector(15 downto 0) := (others => '0');
   signal flagsIN : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal OpA : std_logic_vector(15 downto 0);
   signal OpB : std_logic_vector(15 downto 0);
   signal SC : std_logic_vector(15 downto 0);
   signal flagsOUT : std_logic_vector(4 downto 0);
   signal PCout : std_logic_vector(15 downto 0);

	 ----------------------------------------------------------------------  
    
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
			ALE			: out STD_LOGIC;
         RESOUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
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
   signal RESOUT : std_logic;
	 
----------------------------------------------------------------------   
	-- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Ram2
    PORT(

         AD : INOUT  std_logic_vector(15 downto 0);
         nWR : IN  std_logic_vector(1 downto 0);
         nRD : IN  std_logic;
			ALE : in STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
	signal ALE : STD_LOGIC := '0';
   signal nWR : std_logic_vector(1 downto 0) := (others => '0');
	
----------------------------------------------------------------------    

   -- Clock period definitions
   constant clock_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile8x16 PORT MAP (
          clock => Clock,
          CL => CL,
          RFC => RFC,
          AddrA => DataIn(5 downto 3),
          AddrB => DataIn(8 downto 6),
          AddrSD => DataIn(2 downto 0),
          DestData => DataIn,
          flagsIN => flagsIN,
          OpA => OpA,
          OpB => OpB,
          SC => SC,
          flagsOUT => flagsOUT,
          PCout => PCout
        );
		  
	-- Instantiate the Unit Under Test (UUT)
   uut1: BIU PORT MAP (
          Clock => Clock,
          CL => CL,
          DataOut => SC,
          BusCtr => BusCtr,
          Addr => PCout(15 downto 1),
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
			 ALE	=> ALE,
          RESOUT => RESOUT
        );
		  
	nWR(0) <= nWRL;
	nWR(1) <= nWRH;
	-- Instantiate the Unit Under Test (UUT)
   uut2: Ram2 PORT MAP (

          AD => AD,
          nWR => nWR,
          nRD => nRD,
			 ALE	=> ALE
        );
	

   -- Clock process definitions
   clock_process :process
   begin
		Clock <= '0';
		wait for clock_period/2;
		Clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

-- fazer iniciação dos registos R6 e R7	
	CL			<= '1';
	wait for 50 ns;
	CL			<= '0';
-- ativar o tristate para disponibilizar o endereço no bus AD
	BusCtr(2)<= '1'; --Addr
	BGT_in	<= '0'; --Bus Grant
	wait for 50 ns;
-- guardar no registo de Latch address o endereço no bus AD
	BusCtr(3)<= '1'; --ALE
	wait for 50 ns;
-- ler uma word	
	BusCtr(3)<= '0'; -- desativar o ALE
	BusCtr(2)<= '0'; -- desativar o tristate de Addr
	RD		<= '1';
	wait for 50 ns;
	RD		<= '0'; -- desativar a leitura
	wait for 50 ns;
-- introduzir dados no bus DataIn para entrada no registo R0
	RFC		<= "001001"; -- activar o enable do R0 e dar 1 clock no PC
	wait for 50 ns;
	RFC		<= "000000";
	wait for 50 ns;
	
-- ativar o tristate para disponibilizar o endereço no bus AD
	BusCtr(2)<= '1'; --Addr
	BGT_in	<= '0'; --Bus Grant
	wait for 50 ns;
-- guardar no registo de Latch address o endereço no bus AD
	BusCtr(3)<= '1'; --ALE
	wait for 50 ns;
-- passar uma word para bus AD
	BusCtr(3)<= '0'; --ALE
	BusCtr(0)<= '0'; -- WrByte
	BusCtr(2)<= '0'; -- desativar o tristate de Addr
	BusCtr(1)<= '1'; -- ativar o tristate de DataOut
	wait for 50 ns;
-- escrever uma word
	WRL		<= '1';
	WRH		<= '1';
	wait for 50 ns;
	WRL		<= '0'; -- desativar a escrita
	WRH		<= '0'; -- desativar a escrita
	BusCtr(1)<= '0'; -- desativar o tristate de DataOut
	wait for 50 ns;
--300ns
----------------------------------------------------      
--				-- escrita de word
----------------------------------------------------      
--	
---- introduzir dados nas entradas de data e endereço
--	DataOut 	<= x"0FF0";
--	Addr		<= "000" & x"0_01"; 	--15 bits
--	wait for 50 ns;
---- ativar o tristate para disponibilizar o endereço no bus AD
--	BusCtr(2)<= '1'; --Addr
--	BGT_in	<= '0'; --Bus Grant
--	wait for 50 ns;
---- guardar no registo de Latch address o endereço no bus AD
--	BusCtr(3)<= '1'; --ALE
--	wait for 50 ns;
---- passar uma word para bus AD
--	BusCtr(3)<= '0'; --ALE
--	BusCtr(0)<= '0'; -- WrByte
--	BusCtr(2)<= '0'; -- desativar o tristate de Addr
--	BusCtr(1)<= '1'; -- ativar o tristate de DataOut
--	wait for 50 ns;
---- escrever uma word
--	WRL		<= '1';
--	WRH		<= '1';
--	wait for 50 ns;
--	WRL		<= '0'; -- desativar a escrita
--	WRH		<= '0'; -- desativar a escrita
--	BusCtr(1)<= '0'; -- desativar o tristate de DataOut
--	wait for 50 ns;
----600ns
----------------------------------------------------      
--				-- leitura de word
----------------------------------------------------      
--
---- introduzir dados nas entradas de data e endereço
--	Addr		<= "000" & x"0_00"; 	--15 bits
--	wait for 50 ns;
---- ativar o tristate para disponibilizar o endereço no bus AD
--	BusCtr(2)<= '1'; --Addr
--	BGT_in	<= '0'; --Bus Grant
--	wait for 50 ns;
---- guardar no registo de Latch address o endereço no bus AD
--	BusCtr(3)<= '1'; --ALE
--	wait for 50 ns;
---- ler uma word	
--	BusCtr(3)<= '0'; -- desativar o ALE
--	BusCtr(2)<= '0'; -- desativar o tristate de Addr
--	RD		<= '1';
--	wait for 50 ns;
--	RD		<= '0'; -- desativar a leitura
----------------------------------------------------      
--				-- leitura de word
----------------------------------------------------      
--
--
---- introduzir dados nas entradas de data e endereço
--	DataOut 	<= x"0FF0";
--	Addr		<= "000" & x"0_01"; 	--15 bits
--	wait for 50 ns;
---- ativar o tristate para disponibilizar o endereço no bus AD
--	BusCtr(2)<= '1'; --Addr
--	BGT_in	<= '0'; --Bus Grant
--	wait for 50 ns;
---- guardar no registo de Latch address o endereço no bus AD
--	BusCtr(3)<= '1'; --ALE
--	wait for 50 ns;
---- ler uma word
--	BusCtr(3)<= '0'; -- desativar o ALE
--	BusCtr(2)<= '0'; -- desativar o tristate de Addr
--	RD		<= '1';
--	wait for 50 ns;
--	RD		<= '0'; -- desativar a leitura      

      wait;
   end process;

END;
