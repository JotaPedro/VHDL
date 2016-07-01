----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:51:49 04/28/2016 
-- Design Name: 
-- Module Name:    PDS16fpga - Behavioral 
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

entity PDS16fpga is
    Port ( EXINT : in  STD_LOGIC;
           MCLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           AD_0_15 : inout  bit_16;
           ALE : out  STD_LOGIC;
           SO : out  STD_LOGIC;
           S1 : out  STD_LOGIC;
           RD : out  STD_LOGIC;
           WRL : out  STD_LOGIC;
           WRH : out  STD_LOGIC;
           RDY : in  STD_LOGIC;
           BRQ : in  STD_LOGIC;
           BGT : out  STD_LOGIC;
           RESOUT : out  STD_LOGIC);
end PDS16fpga;

architecture Behavioral of PDS16fpga is

Signal INTP_Input: STD_LOGIC;
Signal IE: STD_LOGIC;
Signal Reset_flipflop_output: STD_LOGIC;
Signal RES: STD_LOGIC:= Reset_flipflop_output OR (NOT RESET);
Signal N_MCLK: STD_LOGIC:= NOT MCLK;
Signal Mplex_selData_input: bit_16_array(3 downto 0);
Mplex_selData_input(0) <= 
Mplex_selData_input(1) <=
Mplex_selData_input(2) <=
Mplex_selData_input(3) <=
Signal Mplex_selAddr_input: bit_16_array(3 downto 0);
Mplex_selAddr_input(3) <= (15 downto 0 => '0'); --Esta entrada não conta para o multiplexer
Mplex_selAddr_input(0) <= 
Mplex_selAddr_input(1) <= 


begin

	Reset_flipflop: DFlipFlop PORT MAP(
		D <= Reset_flipflop_output,
      Q <= NOT RESET,
      Clk <= N_MCLK,
      CL <= '0'
	);
	EXINT_flipflop: DFlipFlop PORT MAP(
		D <= EXINT,
      Q <= INTP_Input,
      Clk <= N_MCLK,
      CL <= IE
	);
	Mplex_selData: Mplex16bit_4to1 PORT MAP(
		Input <= ,--: in  bit_16_array(3 downto 0);
		Sel <= ,--: in  STD_LOGIC_VECTOR(1 downto 0);
		Output <= --: out  bit_16
	);
	Mplex_selAddr: Mplex16bit_4to1 PORT MAP(--ATENÇÃO, este multiplexer de 4para1 é para ser usado no lugar do multiplexer 3 para 1 com a ultima porta sempre a 0;
		Input <= ,--: in  bit_16_array(3 downto 0);
		Sel <= ,--: in  STD_LOGIC_VECTOR(1 downto 0);
		Output <= --: out  bit_16
	);
	Mplex_D07: Mplex8bit_2to1 PORT MAP(
		Input <= ,--: in  bit_8_array(1 downto 0);
      Sel <= ,--: in  STD_LOGIC;
      Output <= --: out  bit_8
	);
	DirZeroFill: DirZeroFill PORT MAP( 
		Input <= ,--: in  STD_LOGIC_VECTOR(6 downto 0);
      Output <= Mplex_selAddr_input(2) --: out  bit_16
	);
	InstReg: InstReg PORT MAP( 
		Input : in  STD_LOGIC;
      EIR : in  STD_LOGIC;
      Output : out  STD_LOGIC;
      Clk : in  STD_LOGIC
	);
	ImmZeroFill: ImmZeroFill PORT MAP( 
		LSB : in  STD_LOGIC_VECTOR(7 downto 0);
      SelImm : in  STD_LOGIC;
      Output : out  bit_16;
      Input : in  STD_LOGIC_VECTOR(7 downto 0)
	);
	HiZeroFill: HiZeroFill PORT MAP(
		Input : in  STD_LOGIC;
      Output : out  STD_LOGIC
	);
	Control: Control PORT MAP(
		WL 			: in  STD_LOGIC;
		Flags 		: in  STD_LOGIC_VECTOR(2 downto 0);-- 0-Zero 1-Carry 2-GE
		OpCode 	: in  STD_LOGIC_VECTOR(6 downto 0);-- bits de 15 a 9
		INTP 		: in  STD_LOGIC;
		Clock 		: in  STD_LOGIC;
		CL 			: in  STD_LOGIC;
		Sync 		: in  STD_LOGIC_VECTOR(1 downto 0); -- 0- BRQ, 1-RDY
		BusCtr 	: out  STD_LOGIC_VECTOR(3 downto 0); -- 0-WrByte, 1-DataOut, 2-Addr, 3-ALE
		RFC 		: out  STD_LOGIC_VECTOR(4 downto 0);
		ALUC 		: out  STD_LOGIC_VECTOR(2 downto 0);
		SelAddr 	: out  STD_LOGIC_VECTOR(1 downto 0);
		SelData	: out  STD_LOGIC_VECTOR(1 downto 0);
		Sellmm 	: out  STD_LOGIC;
		RD 			: out	 STD_LOGIC; -- ACTIVE LOW
		WR			: out  STD_LOGIC_VECTOR(1 downto 0); -- 0-WRL, 1-WRH
		BGT			: out	 STD_LOGIC;
		S0 			: out	 STD_LOGIC;
		S1 			: out	 STD_LOGIC;
		EIR			: out	 STD_LOGIC
	);
	BIU: BIU PORT MAP(
		Clock : in  STD_LOGIC;
		CL : in  STD_LOGIC;
		Addr : in  STD_LOGIC_VECTOR(14 downto 0);--Addr 15 downto 1
		DataOut : in  STD_LOGIC_VECTOR(15 downto 0);
		BusCtr : in  STD_LOGIC_VECTOR(3 downto 0);-- 0-WrByte, 1-DataOut, 2-Addr, 3-Ale
		Sync : out  STD_LOGIC_VECTOR(1 downto 0);-- 0- BRQ, 1-RDY
		AD : inout  STD_LOGIC_VECTOR(15 downto 0);
		ALE : out  STD_LOGIC;
		S0_in : in  STD_LOGIC;
		S1_in : in  STD_LOGIC;
		S0_out : out  STD_LOGIC;
		S1_out : out  STD_LOGIC;
		RD : in  STD_LOGIC;
		WRL : in  STD_LOGIC;
		WRH : in  STD_LOGIC;
		nRD : out  STD_LOGIC;
		nWRL : out  STD_LOGIC;
		nWRH : out  STD_LOGIC;
		RDY : in  STD_LOGIC;
		BRQ : in  STD_LOGIC;
		BGT_in : in  STD_LOGIC;
		BGT_out : out  STD_LOGIC;
		RESOUT : out  STD_LOGIC;
		DataIn : out  STD_LOGIC_VECTOR (15 downto 0)
	);
	Data_Processor: Data_Processor PORT MAP(
		Const : in  STD_LOGIC_VECTOR(7 downto 0);
		OpB : in  bit_16;
		OpA : in  bit_16;
		CYin : in  STD_LOGIC;
		Ctr : in  STD_LOGIC_VECTOR(2 downto 0);
		Func : in  STD_LOGIC_VECTOR(5 downto 0);--IR10 , 11, 12, 13, 14, 15
		Result : out  bit_16;
		FlagsOut : out  STD_LOGIC_VECTOR(3 downto 0)--P,Z,CyBw,GE
	);
	RegisterFile: RegisterFile8x16 PORT MAP(
		clock : in  STD_LOGIC;
		addressSD : in  STD_LOGIC_VECTOR(2 downto 0);
		flags : in  STD_LOGIC_VECTOR(3 downto 0); -- 0-Zero 1-Carry 2-GE 3-Parity
		RFC : in  STD_LOGIC_VECTOR (4 downto 0); -- como é que os bits estão distribuidos? 1-enablers 2-mplexr5 3-mplexr6 4-mplexr7 5-mplexAddrA
		CL : in  STD_LOGIC;
		addrA : in  STD_LOGIC_VECTOR(2 downto 0);
		addrB : in  STD_LOGIC_VECTOR(2 downto 0);
		DestData : in  bit_16;
		flags_output : out  STD_LOGIC_VECTOR(2 downto 0); -- 0-Zero 1-Carry 2-GE
		PC : inout  bit_16;
		Output_A : out  bit_16;
		Output_B : out  bit_16;
		Output_Sc : out  bit_16
	);


end Behavioral;

