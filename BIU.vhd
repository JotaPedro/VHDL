----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:17:10 04/25/2016 
-- Design Name: 
-- Module Name:    BIU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BIU is
    Port ( Clock 		: in  STD_LOGIC;
           CL 			: in  STD_LOGIC; 
			 
           DataOut 	: in  STD_LOGIC_VECTOR(15 downto 0);
           BusCtr 	: in  STD_LOGIC_VECTOR(3 downto 0);-- 0-WrByte, 1-DataOut, 2-Addr, 3-Ale
           Addr 		: in  STD_LOGIC_VECTOR(14 downto 0);--Addr 15 downto 1
			  
			  AD 			: inout  STD_LOGIC_VECTOR(15 downto 0); --Bus address and data
           
			  S1S0_in	: in	STD_LOGIC_VECTOR(1 downto 0); -- 0-S0, 1-S1
			  S1S0_out	: out	STD_LOGIC_VECTOR(1 downto 0); -- 0-S0, 1-S1			  
	
			  RD 			: in  STD_LOGIC;
			  nRD 		: out  STD_LOGIC;
           WRL 		: in  STD_LOGIC;
           nWRL 		: out  STD_LOGIC;
			  WRH 		: in  STD_LOGIC;
			  nWRH 		: out  STD_LOGIC;
			  
           RDY 		: in  STD_LOGIC; -- do lado da memoria
           BRQ 		: in  STD_LOGIC; -- do lado da memoria
           BGT_in 	: in  STD_LOGIC;
			  BGT_out 	: out  STD_LOGIC;
           DataIn 	: out  STD_LOGIC_VECTOR (15 downto 0);
			  Sync 		: out  STD_LOGIC_VECTOR(1 downto 0);-- 0- BRQ, 1-RDY
	  
			  ALE			: out STD_LOGIC;
			  RESOUT 	: out  STD_LOGIC
			  );
end BIU;

architecture Behavioral of BIU is

	--Variaveis confirmadas
	Signal Data_to_mem			: STD_LOGIC_VECTOR(15 downto 0);
	Signal TS_DataOut_Enable	: STD_LOGIC;
	Signal TS_Addr_Enable		: STD_LOGIC;
	Signal TS_Addr_Input			: STD_LOGIC_VECTOR(15 downto 0);
	Signal ALE_flipflop			: STD_LOGIC;
	
begin

	nRD 		<= (RD) when BGT_in='0' else 'Z';
	nWRL		<= (WRL) when BGT_in='0' else 'Z';
	nWRH		<= (WRH) when BGT_in='0' else 'Z';
	RESOUT 	<= CL;
	S1S0_out <= S1S0_in;
	BGT_out <= BGT_in;
	
	-----------------------
	-- MBR: Memory bus register
	-----------------------
	
	Membusreg: MBR PORT MAP( 
		enable => RD,
		d => AD,
		q => DataIn
	);
	
	-----------------------
	-- Multiplexer DataOut
	-----------------------

	Mplex_DataOut: MplexWrByte PORT MAP(
		Input0 => DataOut(15 downto 8),
		Input1 => DataOut(7 downto 0),
      Sel => BusCtr(0), -- BusCtr(WrByte)
      Output => Data_to_mem -- dados a entrar no tristate DataOut.
	);

	-----------------------
	-- Tristate DataOut
	-----------------------

	TS_DataOut_Enable	<= (BusCtr(1) and (not BGT_in)); --BusCtr(DataOut) and (not BGT)
	
	TS_DataOut: Tristate PORT MAP(
		Input => Data_to_mem,
      Enable => TS_DataOut_Enable,
      Output => AD
	);
	
	-----------------------
	-- Tristate Address
	-----------------------
	
	TS_Addr_Enable 	<= (BusCtr(2) and (not BGT_in)); --BusCtr(Addr) and (not BGT)
	TS_Addr_Input		<= Addr & '0'; -- para quê a introdução de um 0 se não vai ser usado?
	
	TS_Addr: Tristate PORT MAP(
		Input => TS_Addr_Input,
      Enable => TS_Addr_Enable,
      Output => AD
	);
	
	-----------------------
	-- Flipflops
	-----------------------

	RDY_flipflop: DFlipFlop PORT MAP(
		D => RDY,
      Q => Sync(1),--Sync(RDY)
      Clk => Clock,
		En => Clock
	);
	
	
	BRQ_flipflop: DFlipFlop PORT MAP(
		D => BRQ,
      Q => Sync(0),--Sync(BRQ)
      Clk => Clock,
      En => Clock
	);
	
	
	ALE_ff: DFlipFlop PORT MAP(
		D => BusCtr(3),--BusCtr(ALE)
      Q => ALE_flipflop,
      Clk => Clock,
      En => Clock
	);
	
	ALE <= (BusCtr(3) AND (NOT ALE_flipflop));
	
--	-----------------------
--	-- LATCH ADDRESS
--	-----------------------
--
--	-- Latch for the address storing when acessing ram
--	-- não deve ter clock.
--	Latch: Latch16bits
--	Port map( D 		=> AD,
--				 Q 		=> Addr_out,
--				 En 		=> ALE_out,
--				 A0		=> A0
--				);


end Behavioral;