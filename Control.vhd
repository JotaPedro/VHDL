----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:31 04/25/2016 
-- Design Name: 
-- Module Name:    Control - Behavioral 
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

entity Control is
    Port ( A0 			: in  STD_LOGIC;
           Flags 		: in  STD_LOGIC_VECTOR(2 downto 0);-- 0-Zero 1-Carry 2-GE
           OpCode 	: in  STD_LOGIC_VECTOR(6 downto 0);-- bits de 15 a 9
           INTP 		: in  STD_LOGIC;
           Clock 		: in  STD_LOGIC;
           CL 			: in  STD_LOGIC;
           Sync 		: in  STD_LOGIC_VECTOR(1 downto 0); -- 0- BRQ, 1-RDY
           BusCtr 	: out  STD_LOGIC_VECTOR(3 downto 0); -- 0-WrByte, 1-DataOut, 2-Addr, 3-ALE
           RFC 		: out  STD_LOGIC_VECTOR(5 downto 0); -- 0-Decoder, 1-OR Reg R5/SelMuxR5, 2-OR Reg R6/SelMuxR6, 3-OR Reg R7/SelMuxR7, 4-MUXaddrA, 5-enable Reg R7(para os jumps)
           ALUC 		: out  STD_LOGIC_VECTOR(2 downto 0);
           SelAddr 	: out  STD_LOGIC_VECTOR(1 downto 0);
           SelData	: out  STD_LOGIC_VECTOR(1 downto 0);
           Sellmm 	: out  STD_LOGIC;
			  RD 			: out	 STD_LOGIC; -- ACTIVE LOW
			  WR			: out  STD_LOGIC_VECTOR(1 downto 0); -- 0-WRL, 1-WRH
			  BGT			: out	 STD_LOGIC;
			  S1S0 		: out	 STD_LOGIC_VECTOR(1 downto 0);
			  EIR			: out	 STD_LOGIC;
			  --Apartir daqui os signais são apenas para ver no testbench (apagar depois)
			  CState		:out STATE_TYPE;
			  inst		: out INST_TYPE
	);
end Control;

architecture Behavioral of Control is

	--type STATE_TYPE is (SReset, SFetch_Addr, SFetch_Inst, SFetch_Decod, SExecution, SExec_Addr, SExec_RW, SInterrupt, SBreak, SHold_Fetch, SHold_Exec, SWait_Fetch, SWait_Exec);
	signal CurrentState 	: STATE_TYPE := SFetch_Addr; -- Estado inicial
	signal NewState 		: STATE_TYPE;
	
	--sinais só para testes
	signal LDST : STD_LOGIC;
	
	signal instruction : INST_TYPE;
	signal flagUpdate	 : STD_LOGIC;
	
begin
	
	CState <= CurrentState;
	inst <= instruction;
	
	id: InstDecode Port map(
		OpCode 		=> OpCode,
		Inst			=> instruction,
		FlagUpdate	=> flagUpdate
	);
	
    ---------------------------------------------------------------------------
    -- faz a transição de estado com o Clock, se não existir necessidades de Hold,Wait ou Interrupt, i.e. se os sinais de Ready, BGT ou Reset estiverem activos
    ---------------------------------------------------------------------------
    State_Change: 
	 process (Clock)
    begin
        if rising_edge(Clock) then
            CurrentState <= NewState;
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- Determinar o proximo estado
    ---------------------------------------------------------------------------
	 
	 -- Sinais que vão sair para blocos que não o BIU - RFC, ALUC, SelAddr, SelData, SelImm
	 
	 --Sinais por tratar:
	--	 RFC
	--	 ALUC
	--	 SelAddr
	--	 SelData
	--	 SelImm
	--	 Sync
	--	 BusCtr
	--	 WL = A0 - sinal que sai do bit menos significante do Addr0-15
	--	 Flags
	--	 OpCode
	--	 INTP
	--	 CL
	 
    Nxt_State_Eval : 
	 process (CL, Sync, INTP,  CurrentState)
    begin
        if (CL = '1') then
            NewState <= SReset; --se Clear for activo, o estado seguinte é o Reset.
        else
            case (CurrentState) is
			
                when SFetch_Addr => NewState <= SFetch_Inst;

                when SFetch_Inst => if (Sync(1)= '0') then --Sync(Ready) activo
													 NewState <= SWait_Fetch;
												else
													 NewState <= SFetch_Decod;
												end if;
--loadStoreMem significa operações load (não contar com a operação load immediato) ou store.--------------------------------------------------------
                when SFetch_Decod =>if (( LDST = '1' ) and (Sync(0)= '1')) then --BRQ activo
													 NewState <= SHold_Exec;
												else
													if (( LDST = '1' ) and (Sync(0)= '0')) then
														NewState <= SExec_Addr;
													 else
														NewState <= SExecution;
													end if;
												end if;

				--	when SExecution => NewState <= SFetch_Addr;
					
					when SExecution => if (Sync(0)= '1') then --BRQ activo
													 NewState <= SHold_Fetch;
												else
													if (INTP = '1') then
													 NewState <= SInterrupt;
													else --VER O QUE É A BREAK CONDITION -------------------------------------
														if (breakCondition) then
															NewState <= SBreak;
														else
															NewState <= SFetch_Addr;
														end if;
													end if;
												end if;
												
					when SExec_Addr => 	NewState <= SExec_RW;
																
					when SExec_RW => if (Sync(1)= '0') then -- ready activo
												NewState <= SWait_Exec;
											else 
												NewState <= SExecution;
											end if;
											
					when SInterrupt => if (Sync(0)= '1') then -- BRQ activo
												NewState <= SHold_Fetch;
											else
												if(breakCondition) then
													NewState <= SBreak;
												else
													NewState <= SFetch_Addr;
												end if;
											end if;
					
				--	when SBreak => NewState <= SFetch_Addr;
					when SBreak => if (GO = '0') then -- Se não existir sinal para continuar, mantemos o Break.
												NewState <= SBreak;
										else
												NewState <= SFetch_Addr;
										end if;
										
					when SHold_Fetch => if (Sync(0)= '1') then -- BRQ activo
												NewState <= SHold_Fetch;
											else
												if(breakCondition) then
													NewState <= SBreak;
												else
													NewState <= SFetch_Addr;
												end if;
											end if;		

					when SHold_Exec =>if (Sync(0)= '1') then -- BRQ activo
													NewState <= SHold_Fetch;
											else
													NewState <= SExec_Addr;										
											end if;
					
					when SWait_Fetch =>if (Sync(1)= '0') then -- Ready activo
													NewState <= SWait_Fetch;
											else
													NewState <= SFetch_Decod;										
											end if;
					
					when SWait_Exec =>if (Sync(1)= '0') then -- Ready activo
													NewState <= SWait_Exec;
											else
													NewState <= SExecution;										
											end if;												
                when others =>   NewState <= SBreak;
            end case;
        end if;
    end process;

				
    ---------------------------------------------------------------------------
    -- Signal assignment statements for 
    ---------------------------------------------------------------------------

-- 0-WrByte	 
		BusCtr(0)	<= '0' when (OpCode(1) = '1') and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed)) and (CurrentState = SExec_RW)	else -- Word
							'1' when (OpCode(1) = '0') and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed)) and (CurrentState = SExec_RW)	else 
							'0';
-- 1-DataOut							
		BusCtr(1)	<= '1' when ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed)) and (CurrentState = SExec_RW)	else
							'0';
-- 2-Addr							
		BusCtr(2)	<= '1' when (CurrentState = SFetch_Addr) or (CurrentState = SExec_Addr)  else -- Quando estamos no estado T1 Fetch Address
							'0';
-- 3-ALE							
		BusCtr(3)	<= '1' when (CurrentState = SFetch_Addr) or (CurrentState = SExec_Addr) else -- Quando estamos no estado T1 Fetch Address ou no T5 Execute Address
							'0';
--Decoder							
		RFC(0)		<= '1' when ((instruction = LDI) or (instruction = LDIH) or (instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed) or (instruction = ADD) or (instruction = ADDC) or (instruction = ADD_const) or (instruction = ADDC_const) or (instruction = SUB) or (instruction = SBB) or (instruction = SUB_const) or (instruction = SBB_const) or (instruction = ANL) or (instruction = ORL) or (instruction = XRL) or (instruction = NT) or (instruction = SHL) or (instruction = SHR) or (instruction = RRL) or (instruction = RRM) or (instruction = RCR) or (instruction = RCL)) and (CurrentState = SExecution)	else
							'0';
--mplexr5 -Link						
		RFC(1)		<= '1' when (instruction = JMPL) and (CurrentState = SFetch_Decod) else
							'0';
--mplexr6 -flags
		RFC(2)		<= '1' when (flagUpdate = '1') and (CurrentState = SExecution)	else
							'0';
--mplexr7 -PC							
		RFC(3)		<= '1' when (CurrentState = SFetch_Inst) else -- Quando estamos no estado T2 Fetch Instruction, para incrementar o PC
							'0';
--mplexAddrA	
		RFC(4)		<= '1' when (((Flags(0) = '1') and (instruction = JZ)) or ((Flags(0) = '0') and (instruction = JNZ)) or ((Flags(1) = '1') and (instruction = JC)) or ((Flags(1) = '0') and (instruction = JNC)) or (instruction = JMP) or (instruction = JMPL)) and (CurrentState = SFetch_Decod)	else
							'0';
--Enable R7 PC		
		RFC(5)		<= '1' when (((Flags(0) = '1') and (instruction = JZ)) or ((Flags(0) = '0') and (instruction = JNZ)) or ((Flags(1) = '1') and (instruction = JC)) or ((Flags(1) = '0') and (instruction = JNC)) or (instruction = JMP) or (instruction = JMPL)) and (CurrentState = SExecution) else
							'0'
		
		ALUC			<= "000" when (((Flags(0) = '1') and (instruction = JZ)) or ((Flags(0) = '0') and (instruction = JNZ)) or ((Flags(1) = '1') and (instruction = JC)) or ((Flags(1) = '0') and (instruction = JNC)) or (instruction = JMP) or (instruction = JMPL)) and (CurrentState = SFetch_Decod)	else
							"001" when (((OpCode(1) = '0') and ((instruction = LD_IndConst) or (instruction = ST_IndConst))) or or ((instruction = ADD_const) or (instruction = ADDC_const) or (instruction = SUB_const) or (instruction = SBB_const) or (instruction = SHL) or (instruction = SHR) or (instruction = RRL) or (instruction = RRM))) and (CurrentState = SFetch_Decod)	else
							"010" when ((OpCode(1) = '1') and ((instruction = LD_IndConst) or (instruction = ST_IndConst))) and (CurrentState = SFetch_Decod)	else
							"011" when (((OpCode(1) = '0') and ((instruction = LD_Indexed) or (instruction = ST_Indexed))) or ((instruction = ADD) or (instruction = ADDC) or (instruction = SUB) or (instruction = SBB) or (instruction = ANL) or (instruction = ORL) or (instruction = XRL) or (instruction = NT))) and (CurrentState = SFetch_Decod)	else
							"100" when ((OpCode(1) = '1') and ((instruction = LD_Indexed) or (instruction = ST_Indexed))) and (CurrentState = SFetch_Decod)	else
							"000";

-- LDI, LDIH, LD_Direct, LD_IndConst, LD_Indexed, ST_Direct, ST_IndConst, ST_Indexed, ADD, ADDC, ADD_const, ADDC_const, SUB, 
-- SBB, SUB_const, SBB_const, ANL, ORL, XRL, NT, SHL,SHR,RRL,RRM,RCR,RCL,JZ,JNZ,JC,JNC,JMP,JMPL,IRET,NOP		
					
		SelAddr		<= "00" when (CurrentState = SFetch_Addr) else -- Quando estamos no estado T1 Fetch Address
							"01" when ((instruction = LD_IndConst) or (instruction = LD_Indexed) or (instruction = ST_IndConst) or (instruction = ST_Indexed)) and (CurrentState = SFetch_Decod)	else
							"10" when ((instruction = LD_Direct) or (instruction = ST_Direct)) and (CurrentState = SFetch_Decod)	else
							"00";
							
		SelData		<= "00" when ((instruction = LDI) or (instruction = LDIH)) and (CurrentState = SFetch_Decod) else
							"01" when (OpCode(1) = '1') and ((instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed)) and (CurrentState = SExec_RW)	else
							"10" when (OpCode(1) = '0') and ((instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed)) and (CurrentState = SExec_RW)	else
							"11" when (((instruction = ADD) or (instruction = ADDC) or (instruction = ADD_const) or (instruction = ADDC_const) or (instruction = SUB) or (instruction = SBB) or (instruction = SUB_const) or (instruction = SBB_const) or (instruction = ANL) or (instruction = ORL) or (instruction = XRL) or (instruction = NT) or (instruction = SHL) or (instruction = SHR) or (instruction = RRL) or (instruction = RRM) or (instruction = RCR) or (instruction = RCL) ) and (CurrentState = SFetch_Decod)) or ((((Flags(0) = '1') and (instruction = JZ)) or ((Flags(0) = '0') and (instruction = JNZ)) or ((Flags(1) = '1') and (instruction = JC)) or ((Flags(1) = '0') and (instruction = JNC)) or (instruction = JMP) or (instruction = JMPL)) and (CurrentState = SExecution))	else
							"00";
							
		Sellmm		<= '1' when ((instruction = LDIH) ) and (CurrentState = SFetch_Decod)	else
							'0' when ((instruction = LDI) ) and (CurrentState = SFetch_Decod)	else
							'0';
							
		RD 			<= '1' when (CurrentState = SFetch_Inst) or ((CurrentState = SExec_Addr) and ((instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed))) else
							'0';
--LOW														
		WR(0)			<= '0' when ((OpCode(1) = '0') and (A0 = 0) and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed))) and (CurrentState = SExec_RW)	else -- Word
							'1' when (((OpCode(1) = '1') or ((OpCode(1) = '0') and (A0 = 1) )) and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed))) and (CurrentState = SExec_RW)	else
							'0';
--HIGH
		WR(1)			<= '0' when ((OpCode(1) = '0') and (A0 = 1) and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed))) and (CurrentState = SExec_RW)	else
							'1' when (((OpCode(1) = '1') or ((OpCode(1) = '0') and (A0 = 0) )) and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed))) and (CurrentState = SExec_RW)	else
							'0';
-- Indica se a instrução é de acesso há memória.		
		LDST			<= '1' when (instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed) or (instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed)	else --LDI
							'0';
							
		BGT			<=	'1' when () else
							'0';
							
		S1S0 			<= "00" when ((CurrentState = SFetch_Addr) or (CurrentState = SFetch_Inst) or (CurrentState = SFetch_Decod))	else
							"01" when ((CurrentState = SExecution) or (CurrentState = SExec_Addr) or (CurrentState = SExec_RW))	else 
							"10" when ((CurrentState = SBreak))	else 
							"11" when ((CurrentState = SInterrupt))	else
							"00";
							
		EIR			<= '1' when (CurrentState = SFetch_Inst) else -- Quando estamos no estado T2 Fetch Instruction
							'0';

end Behavioral;