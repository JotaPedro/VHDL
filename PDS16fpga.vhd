----------------------------------------------------------------------------------
-- Company: ISEL
-- Engineer: 
-- 
-- Create Date:    12:51:49 04/28/2016 
-- Design Name: 
-- Module Name:    PDS16fpga - Behavioral 
-- Project Name: PDS16fpga
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


entity PDS16fpga is
    Port ( EXINT : in  STD_LOGIC;
           MCLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  RDY : in  STD_LOGIC;
           BRQ : in  STD_LOGIC;
           AD0_15 : inout  STD_LOGIC_VECTOR (15 downto 0);
           ALE : out  STD_LOGIC;
           SO : out  STD_LOGIC;
           S1 : out  STD_LOGIC;
           RD : out  STD_LOGIC;
           WRL : out  STD_LOGIC;
           WRH : out  STD_LOGIC;
           BGT : out  STD_LOGIC;
           RESOUT : out  STD_LOGIC);
end PDS16fpga;	

architecture Structural of PDS16fpga is
	Signal N_MCLK: STD_LOGIC:= NOT MCLK;
	Signal INTP_sig: STD_LOGIC;
	Signal IE: STD_LOGIC := flagsCtrl_sig(4);	--flagsCtrl_sig(4)=IE
	Signal reset: STD_LOGIC;	
	Signal clear: STD_LOGIC;	
	Signal DataIn_sig: STD_LOGIC_VECTOR (15 downto 0); 
	Signal EIR_sig: STD_LOGIC;
	Signal instruction: STD_LOGIC_VECTOR (15 downto 0); --saída (Q) do InstReg
	Signal SelImm_sig: STD_LOGIC;
	Signal LSB_sig: STD_LOGIC_VECTOR (7 downto 0) := DataOut_sig(7 downto 0);
	Signal ImmZFout: STD_LOGIC_VECTOR (15 downto 0); --saída ImmZeroFill
	Signal Addr_sig: STD_LOGIC_VECTOR (15 downto 0); 
	Signal HiZFout: STD_LOGIC_VECTOR (15 downto 0); --saída HiZeroFill
	Signal HiZFin: STD_LOGIC_VECTOR (7 downto 0); --entrada HiZeroFill
	Signal SelData_sig: STD_LOGIC_VECTOR (1 downto 0);
	Signal Result_sig: STD_LOGIC_VECTOR (15 downto 0);
	Signal DestData_sig: STD_LOGIC_VECTOR (15 downto 0);
	Signal RFC_sig: STD_LOGIC_VECTOR (5 downto 0);
	Signal flags_sig: STD_LOGIC_VECTOR (3 downto 0);
	Signal OpA_sig: STD_LOGIC_VECTOR (15 downto 0);
	Signal OpB_sig: STD_LOGIC_VECTOR (15 downto 0);
	Signal DataOut_sig: STD_LOGIC_VECTOR (15 downto 0);
	Signal flagsCtrl_sig: STD_LOGIC_VECTOR (4 downto 0);
	Signal PC_sig: STD_LOGIC_VECTOR (15 downto 0);
	Signal ALUCtrl_sig: STD_LOGIC_VECTOR (2 downto 0);
	Signal func_sig: STD_LOGIC_VECTOR (2 downto 0);
	Signal DirZFout: STD_LOGIC_VECTOR (15 downto 0);
	Signal SelAddr_sig: STD_LOGIC (1 downto 0);
	
	--Signal Reset_flipflop_output: STD_LOGIC;
	--Signal RES: STD_LOGIC:= Reset_flipflop_output OR (NOT RESET);
										
	--Signal Mplex_selData_input: bit_16_array(3 downto 0);
	--Mplex_selData_input(0) <= 
	--Mplex_selData_input(1) <=
	--Mplex_selData_input(2) <=
	--Mplex_selData_input(3) <=
	--Signal Mplex_selAddr_input: bit_16_array(3 downto 0);
	--Mplex_selAddr_input(3) <= (15 downto 0 => '0'); --Esta entrada não conta para o multiplexer
	--Mplex_selAddr_input(0) <= 
	--Mplex_selAddr_input(1) <= 

begin
	
	-----------------------
	-- External Interrupt
	-----------------------
	EXINT_FF: component DFlipFlop PORT MAP(
		Clk => N_MCLK,
		CL => IE,
		D => NOT EXINT,
      Q => INTP_sig); 		--sinal INTP do Control

	-----------------
	-- Reset
	-----------------
	Reset_FF: component DFlipFlop PORT MAP(
		Clk => N_MCLK,
		CL => '0',		--CL?? ou En??
		D => RESET,
      Q => reset);
	
	clear <= RESET OR reset;
	
	--------------------------
	-- INSTRUCTION REGISTER
	--------------------------
	InstReg: component Register16bits PORT MAP( 
		clkReg => MCLK,
		En => EIR_sig,
		D => DataIn_sig,	--sinal DataIn do BIU
      Q => instruction);

	--------------------------------
	-- Seleção do destino da DATA
	-- para o REGISTER FILE
	--------------------------------
	ImmZeroFill: component ImmZeroFill PORT MAP( 
		SelImm => SelImm_sig, --sinal de saida do CONTROL
		LSB => LSB_sig,
		Input => intruction (10 downto 3),
		Output => ImmZFout);
	
	muxD0_7: component MUX1x8bits PORT MAP(
		Sel => Addr_sig(0),  	--A0
		In0 => DataIn_sig (15 downto 8),
		In1 => DataIn_sig (7 downto 0),
		outdata => HiZFin);
	
	HiZeroFill: component HiZeroFill PORT MAP(
		Input => HiZFin,
      Output => HiZFout);	
	
	muxSelData: component MUX2x16bits PORT MAP(
		Sel => SelData_sig,
		In0 => ImmZFout,
		In1 => DataIn_sig,
		In2 => HiZFout,
		In3 => Result_sig,
		outdata => DestData_sig);
	
	-----------------
	-- REGISTER FILE
	-----------------
	RegisterFile: component RegisterFile8x16 PORT MAP(
		clock => N_MCLK,
		CL => clear,
		RFC => RFC_sig,				
		AddrA => instruction (5 downto 3),			--RFC(0)-Enable Decoder
		AddrB => instruction (8 downto 6),			--RFC(1)-OR Reg R5 / SelMuxR5
		AddrSD => instruction (2 downto 0),			--RFC(2)-OR Reg R6
		DestData => DestData_sig,						--RFC(3)-OR Reg R7
		flagsIN => flags_sig,							--RFC(4)-MUX do MUXaddrA
		OpA => OpA_sig,
		OpB => OpB_sig,
		SC => DataOut_sig,
		flagsOUT => flagsCtrl_sig,
		PCout => PC_sig);
	
	--------------------
	-- DATA PROCESSOR
	--------------------
	DataProcessor: component Data_Processor PORT MAP(
		OpA => OpA_sig,
		OpB => OpB_sig,
		CYin => flagsCtrl_sig(1),
		Func => instruction (15 downto 10),	--IR10 , 11, 12, 13, 14, 15
		Const => instruction (10 downto 3),
		Ctr => ALUCtrl_sig,						--0-SigExt 1-ZeroFill 2-ZeroFillx2 3-OpB 4-OpBx2
		Result => Result_sig,
		FlagsOut => flags_sig);					-- 0-Zero 1-CyBw 2-GE 3-Parity 
	
	---------------------------
	-- Seleção da origem do
	-- ADDRESS para a BIU
	---------------------------
	DirZeroFill: DirZeroFill PORT MAP( 
		Input => instruction (9 downto 3),
      Output => DirZFout);
	
	muxSelAddr: MUX2x16bits PORT MAP(
		Sel => SelAddr_sig,
		In0 => PC_sig,
		In1 => Result_sig,
		In2 => DirZFout,
		In3 => "0000000000000000", -- Entrada não utilizada
		outdata => Addr_sig);	

	------------------------
	-- BUS INTERFACE UNIT
	------------------------
	
--	NOTA: É preciso corrigir este componente


--	BIU: BIU PORT MAP(
--		Clock : in  STD_LOGIC;
--		CL : in  STD_LOGIC;
--		Addr : in  STD_LOGIC_VECTOR(14 downto 0);--Addr 15 downto 1
--		DataOut : in  STD_LOGIC_VECTOR(15 downto 0);
--		BusCtr : in  STD_LOGIC_VECTOR(3 downto 0);-- 0-WrByte, 1-DataOut, 2-Addr, 3-Ale
--		Sync : out  STD_LOGIC_VECTOR(1 downto 0);-- 0- BRQ, 1-RDY
--		AD : inout  STD_LOGIC_VECTOR(15 downto 0);
--		ALE : out  STD_LOGIC;
--		S0_in : in  STD_LOGIC;
--		S1_in : in  STD_LOGIC;
--		S0_out : out  STD_LOGIC;
--		S1_out : out  STD_LOGIC;
--		RD : in  STD_LOGIC;
--		WRL : in  STD_LOGIC;
--		WRH : in  STD_LOGIC;
--		nRD : out  STD_LOGIC;
--		nWRL : out  STD_LOGIC;
--		nWRH : out  STD_LOGIC;
--		RDY : in  STD_LOGIC;
--		BRQ : in  STD_LOGIC;
--		BGT_in : in  STD_LOGIC;
--		BGT_out : out  STD_LOGIC;
--		RESOUT : out  STD_LOGIC;
--		DataIn : out  STD_LOGIC_VECTOR (15 downto 0)
--	);
	
		-----------------
	-- CONTROL
	-----------------
--		Control: component Control PORT MAP(
--		WL 		: in  STD_LOGIC;
--		Flags 	: in  STD_LOGIC_VECTOR(2 downto 0);-- 0-Zero 1-Carry 2-GE
--		OpCode 	: in  STD_LOGIC_VECTOR(6 downto 0);-- bits de 15 a 9
--		INTP 		: in  STD_LOGIC;
--		Clock 	: in  STD_LOGIC;
--		CL 		: in  STD_LOGIC;
--		Sync 		: in  STD_LOGIC_VECTOR(1 downto 0); -- 0- BRQ, 1-RDY
--		BusCtr 	: out  STD_LOGIC_VECTOR(3 downto 0); -- 0-WrByte, 1-DataOut, 2-Addr, 3-ALE
--		RFC 		: out  STD_LOGIC_VECTOR(4 downto 0);
--		ALUC 		: out  STD_LOGIC_VECTOR(2 downto 0);
--		SelAddr 	: out  STD_LOGIC_VECTOR(1 downto 0);
--		SelData	: out  STD_LOGIC_VECTOR(1 downto 0);
--		Sellmm 	: out  STD_LOGIC;
--		
--		RD 		: out	 STD_LOGIC; -- ACTIVE LOW
--		WR			: out  STD_LOGIC_VECTOR(1 downto 0); -- 0-WRL, 1-WRH
--		BGT		: out	 STD_LOGIC;
--		S0 		: out	 STD_LOGIC;
--		S1 		: out	 STD_LOGIC;
--		EIR		: out	 STD_LOGIC
--	);
	
	
end Behavioral;

