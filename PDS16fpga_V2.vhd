----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  PDS16 - Descrição Hardware

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;

entity PDS16fpga_V2 is
    Port ( MCLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           EXINT : in  STD_LOGIC;
			  AD0_15 : inout  STD_LOGIC_VECTOR (15 downto 0);
			  ALE : out  STD_LOGIC;
           S0 : out  STD_LOGIC;
           S1 : out  STD_LOGIC;
           RD : out  STD_LOGIC;
           WRL : out  STD_LOGIC;
           WRH : out  STD_LOGIC;
           BGT : out  STD_LOGIC;
           RESOUT : out  STD_LOGIC);
end PDS16fpga_V2;

architecture Structural of PDS16fpga_V2 is


	Signal N_MCLK: STD_LOGIC;
	
	-- External Interrupt
	Signal EXINT_FF_D: STD_LOGIC;
	Signal EXINT_FF_CL: STD_LOGIC;
	Signal INTP_sig: STD_LOGIC;	
	-- Reset
	Signal Reset_FF_D: STD_LOGIC;
	Signal Reset_FF_Q: STD_LOGIC;
	Signal CL: STD_LOGIC;
	-- INSTRUCTION REGISTER
	Signal DataIn_sig: STD_LOGIC_VECTOR (15 downto 0);
	Signal IR: STD_LOGIC_VECTOR (15 downto 0); --saída (Q) do InstReg
	-- Seleção do destino da DATA para o REGISTER FILE
	Signal LSB_sig : STD_LOGIC_VECTOR (7 downto 0) := (others => 'Z');
	Signal ImmZFout: STD_LOGIC_VECTOR (15 downto 0);
	Signal HiZFin: STD_LOGIC_VECTOR (7 downto 0);
	Signal HiZFout: STD_LOGIC_VECTOR (15 downto 0);
	Signal DestData_sig: STD_LOGIC_VECTOR (15 downto 0);
	-- REGISTER FILE
	Signal flags_sig : STD_LOGIC_VECTOR (3 downto 0);
	Signal OpA_sig : STD_LOGIC_VECTOR (15 downto 0);
	Signal OpB_sig : STD_LOGIC_VECTOR (15 downto 0);
	Signal flagsCtrl_sig : STD_LOGIC_VECTOR (5 downto 0);
	Signal DataOut_sig : STD_LOGIC_VECTOR (15 downto 0);
	-- DATA PROCESSOR
	Signal Result_sig : STD_LOGIC_VECTOR (15 downto 0);
	Signal PC_sig : STD_LOGIC_VECTOR (15 downto 0);
	-- Seleção da origem do ADDRESS para a BIU
	Signal DirZFout : STD_LOGIC_VECTOR (15 downto 0);
	Signal Addr_sig : STD_LOGIC_VECTOR (15 downto 0);
	-- BUS INTERFACE UNIT
	Signal S1S0_port_out: STD_LOGIC_VECTOR (1 downto 0);
	Signal BusCtr_sig: STD_LOGIC_VECTOR(3 downto 0);
	Signal S1S0_sig: STD_LOGIC_VECTOR (1 downto 0);
	Signal RD_ctrl_sig: STD_LOGIC;
	Signal WR_ctrl_sig: STD_LOGIC_VECTOR (1 downto 0);
	Signal RDY_sig: STD_LOGIC;
	Signal BRQ_sig: STD_LOGIC;
	Signal BGT_sig: STD_LOGIC;
	Signal Sync_sig: STD_LOGIC_VECTOR (1 downto 0);
	-- CONTROL
	Signal EIR: STD_LOGIC;
	Signal SelImm: STD_LOGIC;
	Signal SelData: STD_LOGIC_VECTOR (1 downto 0);
	Signal RFC: STD_LOGIC_VECTOR (12 downto 0);
	Signal ALUCtrl_sig: STD_LOGIC_VECTOR (2 downto 0);
	Signal SelAddr: STD_LOGIC_VECTOR (1 downto 0);
	
	
begin

	N_MCLK <= NOT MCLK;

	-----------------------
	-- External Interrupt
	-----------------------
	EXINT_FF_D	<= NOT EXINT;
	EXINT_FF_CL	<= NOT flagsCtrl_sig(4);	--flagsCtrl_sig(4)=IE
	
	EXINT_FF: component DFlipFlop PORT MAP(
		Clk => N_MCLK,
		CL => EXINT_FF_CL,
		D => EXINT_FF_D,
      Q => INTP_sig); 		--sinal INTP do Control


	-----------------
	-- Reset
	-----------------
	Reset_FF_D	<= NOT RESET;
	
	Reset_FF: component DFlipFlop PORT MAP(
		Clk => N_MCLK,
		CL => '0',
		D => Reset_FF_D,
      Q => Reset_FF_Q);

	CL <= Reset_FF_D OR Reset_FF_Q;
	
	
	--------------------------
	-- INSTRUCTION REGISTER
	--------------------------
	InstReg: component Register16bits PORT MAP( 
		clkReg => MCLK,
		En => EIR,
		D => DataIn_sig,	
      Q => IR);


	--------------------------------
	-- Seleção do destino da DATA
	-- para o REGISTER FILE
	--------------------------------
	LSB_sig <= DataOut_sig (7 downto 0);
	
	ImmZF: component ImmZeroFill PORT MAP( 
		SelImm => SelImm, 						
		LSB => LSB_sig,						
		Input => IR (10 downto 3),
		Output => ImmZFout);
	
	muxD0_7: component MUX1x8bits PORT MAP(
		Sel => Addr_sig(0),  	--A0
		In0 => DataIn_sig (15 downto 8),
		In1 => DataIn_sig (7 downto 0),
		outdata => HiZFin);
	
	HiZF: component HiZeroFill PORT MAP(
		Input => HiZFin,
      Output => HiZFout);	
	
	muxSelData: component MUX2x16bits PORT MAP(
		Sel => SelData,
		In0 => ImmZFout,
		In1 => DataIn_sig,
		In2 => HiZFout,
		In3 => Result_sig,
		outdata => DestData_sig);


	-----------------
	-- REGISTER FILE
	-----------------
	RegisterFile: component RegisterFileBS PORT MAP(
		clock => N_MCLK,
		CL => CL,
		RFC => RFC,				
		AddrA => IR (5 downto 3),			--RFC(0)-Enable Decoder
		AddrB => IR(8 downto 6),			--RFC(1)-OR Reg R5 / SelMuxR5
		AddrSD => "001",	--IR(2 downto 0),			--RFC(2)-OR Reg R6
		DestData => DestData_sig,						--RFC(3)-OR Reg R7
		flagsIN => flags_sig,							--RFC(4)-MUX do MUXaddrA
		OpA => OpA_sig,									--RFC(5)-Enable R7
		OpB => OpB_sig,
		SC => DataOut_sig,
		flagsOUT => flagsCtrl_sig,
		PC => PC_sig);
		

	--------------------
	-- DATA PROCESSOR
	--------------------
	DataProcessor: component Data_Processor PORT MAP(
		OpA => OpA_sig,
		OpB => OpB_sig,
		CYin => flagsCtrl_sig(1),
		Func => IR (15 downto 10),	--IR10 , 11, 12, 13, 14, 15
		Const => IR (10 downto 3),
		Ctr => ALUCtrl_sig,						--0-SigExt 1-ZeroFill 2-ZeroFillx2 3-OpB 4-OpBx2
		Result => Result_sig,
		FlagsOut => flags_sig);					-- 0-Zero 1-CyBw 2-GE 3-Parity 
		
		
	---------------------------
	-- Seleção da origem do
	-- ADDRESS para a BIU
	---------------------------
	DirZF: DirZeroFill PORT MAP( 
		Input => IR (9 downto 3),
      Output => DirZFout);
	
	muxSelAddr: MUX2x16bits PORT MAP(
		Sel => SelAddr,
		In0 => PC_sig, 
		In1 => Result_sig,
		In2 => DirZFout,
		In3 => "0000000000000000", -- Entrada não utilizada
		outdata => Addr_sig);	

	------------------------
	-- BUS INTERFACE UNIT
	------------------------

	S0 <= S1S0_port_out(0);
	S1 <= S1S0_port_out(1);

	Bus_interface: BIU PORT MAP(
		Clock 	=> N_MCLK,
		CL 		=> CL,
		DataOut 	=> DataOut_sig,
		BusCtr 	=> BusCtr_sig,					-- 0-WrByte, 1-DataOut, 2-Addr, 3-Ale
		Addr 		=> Addr_sig(15 downto 1),	--Addr 15 downto 1
		AD 		=> AD0_15,						--Bus address and data
		S1S0_in	=> S1S0_sig,					-- 0-S0, 1-S1
		S1S0_out	=> S1S0_port_out,				-- 0-S0, 1-S1			  
		RD 		=> RD_ctrl_sig,
		nRD 		=> RD,
		WRL 		=> WR_ctrl_sig(0),
		nWRL 		=> WRL,
		WRH 		=> WR_ctrl_sig(1),
		nWRH 		=> WRH,
		RDY 		=> RDY_sig,				-- do lado da memoria
		BRQ 		=> BRQ_sig,				-- do lado da memoria
		BGT_in 	=> BGT_sig,
		BGT_out 	=> BGT,
		DataIn 	=> DataIn_sig,
		Sync 		=> Sync_sig,			-- 0- BRQ, 1-RDY
		ALE		=> ALE,
		RESOUT 	=> RESOUT );


	-----------------
	-- CONTROL
	-----------------
	
	Controlo: Control_V2 PORT MAP(
		A0 		=>	Addr_sig(0), 					-- A0 obtido da saída do multiplexer SelAddr
		Flags 	=>	flagsCtrl_sig(2 downto 0), -- 0-Zero 1-Carry 2-GE
		OpCode 	=> IR( 15 downto 9), -- bits de 15 a 9
		INTP 		=> INTP_sig, 						-- bit para indicar uma interrupção?
		Clock 	=>	N_MCLK,
		CL 		=>	CL,
		Sync 		=> Sync_sig,--: in  STD_LOGIC_VECTOR(1 downto 0); -- 0- BRQ, 1-RDY
		BusCtr 	=> BusCtr_sig,--: out  STD_LOGIC_VECTOR(3 downto 0); -- 0-WrByte, 1-DataOut, 2-Addr, 3-ALE
		RFC 		=> RFC, -- 0-Decoder, 1-OR Reg R5/SelMuxR5, 2-OR Reg R6/SelMuxR6, 3-OR Reg R7/SelMuxR7, 4-MUXaddrA, 5-enable Reg R7(para os jumps)
		ALUC 		=> ALUCtrl_sig,--: out  STD_LOGIC_VECTOR(2 downto 0);
		SelAddr 	=> SelAddr,
		SelData	=> SelData,
		Sellmm 	=> SelImm, 
		RD 		=> RD_ctrl_sig,--: out	 STD_LOGIC; -- ACTIVE LOW
		WR			=> WR_ctrl_sig, -- 0-WRL, 1-WRH
		BGT		=> BGT_sig,--: out	 STD_LOGIC;
		S1S0 		=> S1S0_sig,--: out	 STD_LOGIC_VECTOR(1 downto 0);
		EIR		=> EIR--: out	 STD_LOGIC
		);


	
end Structural;

