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
			
			--para teste
			  ALE_flipflop_out : out STD_LOGIC;
			
			Addr_out 	: out  STD_LOGIC_VECTOR(14 downto 0);--Addr 15 downto 1
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
	signal Addr_out : STD_LOGIC_VECTOR(14 downto 0);--Addr 15 downto 1
	--para teste
	signal ALE_flipflop_out : STD_LOGIC;

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
			 --para teste
			 ALE_flipflop_out => ALE_flipflop_out,
			 
			 Addr_out => Addr_out,
          RESOUT => RESOUT
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

--------------------------------------------------      
-- Testar a entrada de dados no Bus AD
-- Testar o funcionamento do multiplexer do DataOut
-- Testar a entrada de endereço no Bus AD
--------------------------------------------------

---- introduzir dados nas entradas de data e endereço
--	DataOut 	<= x"F00F";
--	Addr		<= "000" & x"0_0F"; 	--15 bits
---- ativar o tristate para disponibilizar o endereço no bus AD
--	BusCtr(1)<= '1'; --DataOut
---- passar uma word do bus DataOut
--	BusCtr(0)<= '0'; --WrByte
--	wait for 50 ns;
---- passar um Byte do bus DataOut
--	BusCtr(0)<= '1'; --WrByte
--	wait for 50 ns;
---- retirar o acesso ao Bus AD
--	BusCtr(1)<= '0'; --DataOut
--	BusCtr(2)<= '1';


--------------------------------------------------      
-- Testar a entrada de endereço na Latch address.	
--------------------------------------------------

---- introduzir dados nas entradas de data e endereço
--	DataOut 	<= x"F0_0F";
--	Addr		<= "000" & x"0_0F"; 	--15 bits
---- ativar o tristate para disponibilizar o endereço no bus AD
--	BusCtr(2)<= '1'; --addr	
--	wait for 50 ns;
--	BusCtr(3)<= '1'; --ALE
--	wait for 50 ns;
--	BusCtr(3)<= '0';	
--	BGT_in	<= '0';

			
      wait;
   end process;

END;
