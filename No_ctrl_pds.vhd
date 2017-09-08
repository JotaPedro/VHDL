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


entity PDS16fpga is
    Port ( EXINT : in  STD_LOGIC;
           MCLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
			  RDY : in  STD_LOGIC;
           BRQ : in  STD_LOGIC;
           AD0_15 : inout  STD_LOGIC_VECTOR (15 downto 0);
           ALE : out  STD_LOGIC;
           S0 : out  STD_LOGIC;
           S1 : out  STD_LOGIC;
           RD : out  STD_LOGIC;
           WRL : out  STD_LOGIC;
           WRH : out  STD_LOGIC;
           BGT : out  STD_LOGIC;
           RESOUT : out  STD_LOGIC;
			  -- Saídas para teste apenas
			  DataIn_sig_out: out STD_LOGIC_VECTOR (15 downto 0);
			  instruction_out: out STD_LOGIC_VECTOR (15 downto 0);
			  PC_sig_out: out STD_LOGIC_VECTOR (15 downto 0);
			  Addr_sig_out: out STD_LOGIC_VECTOR (15 downto 0)
			  
			  );
end PDS16fpga;	

architecture Structural of PDS16fpga is
	Signal N_MCLK: STD_LOGIC:= NOT MCLK;
	Signal INTP_sig: STD_LOGIC;
	Signal IE: STD_LOGIC;	--flagsCtrl_sig(4)=IE
	Signal reset_q_sig: STD_LOGIC;	
--	Signal reset: STD_LOGIC;	
	Signal clear: STD_LOGIC;	
	Signal DataIn_sig: STD_LOGIC_VECTOR (15 downto 0); 
	Signal EIR_sig: STD_LOGIC;
	Signal instruction: STD_LOGIC_VECTOR (15 downto 0); --saída (Q) do InstReg
	Signal SelImm_sig: STD_LOGIC;
	Signal LSB_sig: STD_LOGIC_VECTOR (7 downto 0);
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
	Signal SelAddr_sig: STD_LOGIC_VECTOR (1 downto 0);
	Signal BusCtr_sig: STD_LOGIC_VECTOR(3 downto 0);
	Signal AD: std_logic_vector (15 downto 0);
	Signal S1S0_sig: STD_LOGIC_VECTOR (1 downto 0);
	Signal S1S0_port_out: STD_LOGIC_VECTOR (1 downto 0);
	Signal RD_ctrl_sig: STD_LOGIC;
	Signal RD_ram_sig: STD_LOGIC;
	Signal WR_ctrl_sig: STD_LOGIC_VECTOR (1 downto 0);
	Signal WR_ram_sig: STD_LOGIC_VECTOR (1 downto 0);
	Signal ALE_sig: STD_LOGIC;
	Signal RDY_sig: STD_LOGIC;
	Signal BGT_sig: STD_LOGIC;
	Signal Sync_sig: STD_LOGIC_VECTOR (1 downto 0);
	Signal BGT_port_sig: STD_LOGIC;
	Signal BRQ_sig: STD_LOGIC;
	Signal RESOUT_sig: STD_LOGIC;
	Signal EXINT_FF_D: STD_LOGIC;
	Signal Reset_FF_D: STD_LOGIC;
	signal EXINT_FF_CL: STD_LOGIC;
	
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
	
	IE <= flagsCtrl_sig(4); --flagsCtrl_sig(4)=IE
	LSB_sig <= DataOut_sig(7 downto 0);
	
	-----------------------
	-- External Interrupt
	-----------------------
	
	EXINT_FF_D	<= NOT EXINT;
	EXINT_FF_CL	<= NOT IE;
	
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
      Q => reset_q_sig);

	clear <= Reset_FF_D OR reset_q_sig;

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
	ImmZF: component ImmZeroFill PORT MAP( 
		SelImm => SelImm_sig, --sinal de saida do CONTROL
		LSB => LSB_sig,
		Input => instruction (10 downto 3),
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
		OpA => OpA_sig,									--RFC(5)-Enable R7
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
	DirZF: DirZeroFill PORT MAP( 
		Input => instruction (9 downto 3),
      Output => DirZFout);
	
	muxSelAddr: MUX2x16bits PORT MAP(
		Sel => SelAddr_sig,
		In0 => PC_sig,
		In1 => Result_sig,
		In2 => DirZFout,
		In3 => "0000000000000000", -- Entrada não utilizada
		outdata => Addr_sig);	


	-----------------
	-- CONTROL
	-----------------
	
	Controlo: Control PORT MAP(
		A0 		=>	Addr_sig(0), 					-- A0 obtido da saída do multiplexer SelAddr
		Flags 	=>	flagsCtrl_sig(2 downto 0), -- 0-Zero 1-Carry 2-GE
		OpCode 	=> instruction( 15 downto 9), -- bits de 15 a 9
		INTP 		=> INTP_sig, 						-- bit para indicar uma interrupção?
		Clock 	=>	MCLK,
		CL 		=>	clear,
		Sync 		=> Sync_sig,--: in  STD_LOGIC_VECTOR(1 downto 0); -- 0- BRQ, 1-RDY
		BusCtr 	=> BusCtr_sig,--: out  STD_LOGIC_VECTOR(3 downto 0); -- 0-WrByte, 1-DataOut, 2-Addr, 3-ALE
		RFC 		=> RFC_sig, -- 0-Decoder, 1-OR Reg R5/SelMuxR5, 2-OR Reg R6/SelMuxR6, 3-OR Reg R7/SelMuxR7, 4-MUXaddrA, 5-enable Reg R7(para os jumps)
		ALUC 		=> ALUCtrl_sig,--: out  STD_LOGIC_VECTOR(2 downto 0);
		SelAddr 	=> SelAddr_sig,
		SelData	=> SelData_sig,
		Sellmm 	=> SelImm_sig, 
		RD 		=> RD_ctrl_sig,--: out	 STD_LOGIC; -- ACTIVE LOW
		WR			=> WR_ctrl_sig, -- 0-WRL, 1-WRH
		BGT		=> BGT_sig,--: out	 STD_LOGIC;
		S1S0 		=> S1S0_sig,--: out	 STD_LOGIC_VECTOR(1 downto 0);
		EIR		=> EIR_sig--: out	 STD_LOGIC
		);

	
	------------------------
	-- BUS INTERFACE UNIT
	------------------------

	S0 <= S1S0_port_out(0);
	S1 <= S1S0_port_out(1);
	ALE <= ALE_sig;
	
	

	Bus_interface: BIU PORT MAP(
		Clock 	=> N_MCLK,--	: in  STD_LOGIC;
		CL 		=> clear,--	: in  STD_LOGIC; 
		DataOut 	=> DataOut_sig,--: in  STD_LOGIC_VECTOR(15 downto 0);
		BusCtr 	=> BusCtr_sig,--: in  STD_LOGIC_VECTOR(3 downto 0);-- 0-WrByte, 1-DataOut, 2-Addr, 3-Ale
		Addr 		=> Addr_sig(15 downto 1),--: in  STD_LOGIC_VECTOR(14 downto 0);--Addr 15 downto 1
		AD 		=> AD,--	: inout  STD_LOGIC_VECTOR(15 downto 0); --Bus address and data
		S1S0_in	=> S1S0_sig,--: in	STD_LOGIC_VECTOR(1 downto 0); -- 0-S0, 1-S1
		S1S0_out	=> S1S0_port_out,--: out	STD_LOGIC_VECTOR(1 downto 0); -- 0-S0, 1-S1			  
		RD 		=> RD_ctrl_sig,--	: in  STD_LOGIC;
		nRD 		=> RD_ram_sig,--: out  STD_LOGIC;
		WRL 		=> WR_ctrl_sig(0),--: in  STD_LOGIC;
		nWRL 		=> WR_ram_sig(0),--: out  STD_LOGIC;
		WRH 		=> WR_ctrl_sig(1),--: in  STD_LOGIC;
		nWRH 		=> WR_ram_sig(1),--: out  STD_LOGIC;
		RDY 		=> RDY_sig,--: in  STD_LOGIC; -- do lado da memoria
		BRQ 		=> BRQ_sig,--: in  STD_LOGIC; -- do lado da memoria
		BGT_in 	=> BGT_sig,--: in  STD_LOGIC;
		BGT_out 	=> BGT_port_sig,--: out  STD_LOGIC;
		DataIn 	=> DataIn_sig,--: out  STD_LOGIC_VECTOR (15 downto 0);
		Sync 		=> Sync_sig,-- 0- BRQ, 1-RDY
		ALE		=> ALE_sig,--	: out STD_LOGIC;
		RESOUT 	=> RESOUT_sig --: out  STD_LOGIC
		);
	
	------------------------
	-- RAM
	------------------------
	
	
	
	Ram: Ram2 PORT MAP(
		AD   	=> AD,--:inout std_logic_vector (15 downto 0);  -- bi-directional data/address
		nWR   => WR_ram_sig,--:in    std_logic_vector(1 downto 0);             -- Write Enable (High/Low)
		nRD   => RD_ram_sig,--:in    std_logic;                                 	-- Read Enable
		ALE	=> ALE_sig --:in	 std_logic
		);

	DataIn_sig_out		<= DataIn_sig;
	instruction_out	<= instruction;
	PC_sig_out			<= PC_sig;
	Addr_sig_out		<= Addr_sig;
	

end Structural;

