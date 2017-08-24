--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:37:40 08/24/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Biu_Ram2.vhd
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
 
ENTITY TB_Biu_Ram2 IS
END TB_Biu_Ram2;
 
ARCHITECTURE behavior OF TB_Biu_Ram2 IS 
 
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

	--BiDirs
   signal DATA : std_logic_vector(15 downto 0);
	
----------------------------------------------------------------------   
	
	
	-- Clock period definitions
   constant Clock_period : time := 50 ns;
	
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
          Addr_out => Addr_out,
          RESOUT => RESOUT
        );
		  
	nWR(0) <= nWRL;
	nWR(1) <= nWRH;
	-- Instantiate the Unit Under Test (UUT)
   uut2: Ram2 PORT MAP (

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
      
--------------------------------------------------      
-- Testar a escrita de word
-- Testar a leitura da word

-- Testar a escrita de byte high
-- Testar a leitura de byte high

-- Testar a escrita de byte low
-- Testar a leitura de byte low
--------------------------------------------------


--------------------------------------------------      
				-- escrita de word
--------------------------------------------------      

-- introduzir dados nas entradas de data e endereço
	DataOut 	<= x"F00F";
	Addr		<= "000" & x"0_00"; 	--15 bits
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
	WRL		<= '0';
	WRH		<= '0';
	wait for 50 ns;
	WRL		<= '1';
	WRH		<= '1';
	wait for 50 ns;

--------------------------------------------------      
				-- escrita de word
--------------------------------------------------      
	
-- introduzir dados nas entradas de data e endereço
	DataOut 	<= x"0FF0";
	Addr		<= "000" & x"0_01"; 	--15 bits
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
	WRL		<= '0';
	WRH		<= '0';
	wait for 50 ns;
	WRL		<= '1';
	WRH		<= '1';
	wait for 50 ns;

--------------------------------------------------      
				-- leitura de word
--------------------------------------------------      

-- introduzir dados nas entradas de data e endereço
	Addr		<= "000" & x"0_00"; 	--15 bits
	wait for 50 ns;
-- ativar o tristate para disponibilizar o endereço no bus AD
	BusCtr(2)<= '1'; --Addr
	BGT_in	<= '0'; --Bus Grant
	wait for 50 ns;
-- guardar no registo de Latch address o endereço no bus AD
	BusCtr(3)<= '1'; --ALE
	wait for 50 ns;
-- ler uma word	
	BusCtr(3)<= '0'; --ALE
	RD		<= '0';
	wait for 50 ns;

--------------------------------------------------      
				-- leitura de word
--------------------------------------------------      


-- introduzir dados nas entradas de data e endereço
	DataOut 	<= x"0FF0";
	Addr		<= "000" & x"0_01"; 	--15 bits
	wait for 50 ns;
-- ativar o tristate para disponibilizar o endereço no bus AD
	BusCtr(2)<= '1'; --Addr
	BGT_in	<= '0'; --Bus Grant
	wait for 50 ns;
-- guardar no registo de Latch address o endereço no bus AD
	BusCtr(3)<= '1'; --ALE
	wait for 50 ns;
-- ler uma word
	BusCtr(3)<= '0'; --ALE
	RD		<= '0';
	wait for 50 ns;
	
      wait;
   end process;

END;
