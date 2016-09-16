--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:44:59 08/28/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_BIU.vhd
-- Project Name:  vhdl1
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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY TB_BIU IS
END TB_BIU;
 
ARCHITECTURE behavior OF TB_BIU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BIU
    PORT(
         Clock : IN  std_logic;
         CL : IN  std_logic;
         Addr : IN  std_logic_vector(14 downto 0);
         DataOut : IN  std_logic_vector(15 downto 0);
         BusCtr : IN  std_logic_vector(3 downto 0);
         Sync : OUT  std_logic_vector(1 downto 0);
         AD : INOUT  std_logic_vector(15 downto 0);
         ALE : OUT  std_logic;
         S0_in : IN  std_logic;
         S1_in : IN  std_logic;
         S0_out : OUT  std_logic;
         S1_out : OUT  std_logic;
         RD : IN  std_logic;
         WRL : IN  std_logic;
         WRH : IN  std_logic;
         nRD : OUT  std_logic;
         nWRL : OUT  std_logic;
         nWRH : OUT  std_logic;
         RDY : IN  std_logic;
         BRQ : IN  std_logic;
         BGT_in : IN  std_logic;
         BGT_out : OUT  std_logic;
         RESOUT : OUT  std_logic;
         DataIn : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic;-- := '0';
   signal CL : std_logic;-- := '0';
   signal Addr : std_logic_vector(14 downto 0);-- := (others => '0');
   signal DataOut : std_logic_vector(15 downto 0);-- := (others => '0');
   signal BusCtr : std_logic_vector(3 downto 0);-- := (others => '0');
   signal S0_in : std_logic;-- := '0';
   signal S1_in : std_logic;-- := '0';
   signal RD : std_logic;-- := '0';
   signal WRL : std_logic;-- := '0';
   signal WRH : std_logic;-- := '0';
   signal RDY : std_logic;-- := '0';
   signal BRQ : std_logic;-- := '0';
   signal BGT_in : std_logic;-- := '0';

	--BiDirs
   signal AD : std_logic_vector(15 downto 0);

 	--Outputs
   signal Sync : std_logic_vector(1 downto 0);
   signal ALE : std_logic;
   signal S0_out : std_logic;
   signal S1_out : std_logic;
   signal nRD : std_logic;
   signal nWRL : std_logic;
   signal nWRH : std_logic;
   signal BGT_out : std_logic;
   signal RESOUT : std_logic;
   signal DataIn : std_logic_vector(15 downto 0);
	
	-- Clock period definitions
   constant Clock_period : time := 1ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BIU PORT MAP (
          Clock => Clock,
          CL => CL,
          Addr => Addr,
          DataOut => DataOut,
          BusCtr => BusCtr,
          Sync => Sync,
          AD => AD,
          ALE => ALE,
          S0_in => S0_in,
          S1_in => S1_in,
          S0_out => S0_out,
          S1_out => S1_out,
          RD => RD,
          WRL => WRL,
          WRH => WRH,
          nRD => nRD,
          nWRL => nWRL,
          nWRH => nWRH,
          RDY => RDY,
          BRQ => BRQ,
          BGT_in => BGT_in,
          BGT_out => BGT_out,
          RESOUT => RESOUT,
          DataIn => DataIn
        );
 
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
      --testar sinais com entradas e saidas "simples"
--		BGT_in	<= '0';
--		BRQ		<= '0';
--		RDY		<= '0';
--		S0_in		<= '0';
--		S1_in		<= '0';
--		CL 		<= '0';
--		wait for 2 ns;
--		BGT_in	<= '1';
--		BRQ		<= '1';
--		RDY		<= '1';
--		S0_in		<= '1';
--		S1_in		<= '1';
--		CL 		<= '1';
		
		--testar os sinais read/write e ALE
--		BGT_in	<= '0';
--		RD			<= '0';
--		WRL		<= '1';
--		WRH		<= '1';
--		wait for 2 ns;
--		BGT_in	<= '0';
--		RD			<= '1';
--		WRL		<= '0';
--		WRH		<= '0';
--		wait for 2 ns;
--		BGT_in	<= '1';
--		RD			<= '0';
--		WRL		<= '1';
--		WRH		<= '1';
--		wait for 2 ns;
--		BGT_in	<= '1';
--		RD			<= '1';
--		WRL		<= '0';
--		WRH		<= '0';

--		--testar o modulo MBR com o Enable do RD
--		AD 		<= x"00_0F";
--		RD			<= '0';
--		wait for 2 ns;
--		RD			<= '1';
--		wait for 2 ns;
--		AD			<= x"FF_00";
--		wait for 2 ns;
--		RD			<= '0';
--		AD			<= x"00_00";
--		wait for 2 ns;
--		RD			<= '1';

--		--testar o sinal de BusCtr(3) ALE
--		BusCtr(3)<= '0';
--		wait for 6 ns;
--		BusCtr(3)<= '1';

		--testar read and write, ver se o BUS partilhado funciona!
		Addr 		<= "000" & x"0_0F"; 	--15 bits
		DataOut	<= x"FF_00";			--16 bits
		BusCtr(2)<= '0';					--BusCtr(Addr)
		BusCtr(1)<= '0';					--BusCtr(DataOut)
		BusCtr(0)<= '0';					--BusCtr(WrByte)
		BGT_in	<= '0';
		RD			<= '0';
		wait for 4 ns;
		--activar BusCtr(Addr), deve se obter no BUS o addr passado.
		BusCtr(2)<= '1';					--BusCtr(Addr)
		BusCtr(1)<= '0';					--BusCtr(DataOut)
		BusCtr(0)<= '0';					--BusCtr(WrByte)
		wait for 4 ns;
		--activar BusCtr(DataOut), deve se obter no BUS o DataOut.
		--Com BusCtr(WrByte) = 0; --resultado deve ser "FF00"
		BusCtr(2)<= '0';					--BusCtr(Addr)
		BusCtr(1)<= '1';					--BusCtr(DataOut)
		BusCtr(0)<= '0';					--BusCtr(WrByte)
		wait for 4 ns;
		--Com BusCtr(WrByte) = 1; --resultado deve ser "0000"
		BusCtr(2)<= '0';					--BusCtr(Addr)
		BusCtr(1)<= '1';					--BusCtr(DataOut)
		BusCtr(0)<= '1';					--BusCtr(WrByte)
		wait for 4 ns;
		--vou ligar o BGT , deve cancelar o acesso há memoria.
		BGT_in	<= '1';
		
   
--			  Clock : IN  std_logic;
--         CL : IN  std_logic;
--         Addr : IN  std_logic_vector(14 downto 0);
--         DataOut : IN  std_logic_vector(15 downto 0);
--         BusCtr : IN  std_logic_vector(3 downto 0);
--         Sync : OUT  std_logic_vector(1 downto 0);
--         AD : INOUT  std_logic_vector(15 downto 0);
--         ALE : OUT  std_logic;
--         S0_in : IN  std_logic;
--         S1_in : IN  std_logic;
--         S0_out : OUT  std_logic;
--         S1_out : OUT  std_logic;
--         RD : IN  std_logic;
--         WRL : IN  std_logic;
--         WRH : IN  std_logic;
--         nRD : OUT  std_logic;
--         nWRL : OUT  std_logic;
--         nWRH : OUT  std_logic;
--         RDY : IN  std_logic;
--         BRQ : IN  std_logic;
--         BGT_in : IN  std_logic;
--         BGT_out : OUT  std_logic;
--         RESOUT : OUT  std_logic;
--         DataIn : OUT  std_logic_vector(15 downto 0)
      wait;
   end process;

END;
