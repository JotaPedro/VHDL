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
    Port ( WL 			: in  STD_LOGIC;
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

					when SExecution => NewState <= SFetch_Addr;
					
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
		BusCtr(0)	<= '0' when (instruction = LDI) or (instruction = LDIH) or (instruction = ADD)	else -- Word
							'1' when (instruction = (NOP)) else 
							'0';
-- 1-DataOut							
		BusCtr(1)	<= '0' when (instruction = LDI) or (instruction = LDIH) or (instruction = ADD)	else 
							'1' when (instruction = (NOP))	else
							'0';
-- 2-Addr							
		BusCtr(2)	<= '1' when (CurrentState = SFetch_Addr) else -- Quando estamos no estado T1 Fetch Address
							--'1' when (instruction = LDI) and (CurrentState = SFetch_Addr) else
							--'1' when (instruction = LDIH) and (CurrentState = SFetch_Addr) else
							--'1' when (instruction = ADD) and (CurrentState = SFetch_Addr) else
							'0';
-- 3-ALE							
		BusCtr(3)	<= '1' when (CurrentState = SFetch_Addr) else -- Quando estamos no estado T1 Fetch Address
--							'1' when (instruction = LDI) and (CurrentState = SFetch_Addr) else
--							'1' when (instruction = LDIH) and (CurrentState = SFetch_Addr) else
--							'1' when (instruction = ADD) and (CurrentState = SFetch_Addr) else
							'0';
--Decoder							
		RFC(0)		<= '1' when ((instruction = LDI) or (instruction = LDIH) or (instruction = ADD)) and (CurrentState = SFetch_Decod)	else
							'0';
--mplexr5 -Link						
		RFC(1)		<= '0' when (instruction = LDI) or (instruction = LDIH) or (instruction = ADD) else
							'1' when (instruction = (NOP)) else
							'0';
--mplexr6 -flags
		RFC(2)		<= '0' when (instruction = LDI) or (instruction = LDIH) or ((instruction = ADD) and (OpCode(1)='1'))	else
							'1' when (instruction = (NOP))	else
							'0';
--mplexr7 -PC							
		RFC(3)		<= '1' when (CurrentState = SFetch_Inst) else -- Quando estamos no estado T2 Fetch Instruction, para incrementar o PC
							--'1' when ((instruction = LDI) or (instruction = LDIH) or (instruction = ADD)) and (CurrentState = SFetch_Inst)	else
							'0';
--mplexAddrA	
		RFC(4)		<= '0' when (instruction = LDI) or (instruction = LDIH) or (instruction = ADD)	else
							'1' when (instruction = (NOP))	else
							'0';
							
		ALUC(0)		<= '1' when ((instruction = ADD)) and (CurrentState = SFetch_Decod)	else
							'0';
							
		ALUC(1)		<= '1' when ((instruction = ADD)) and (CurrentState = SFetch_Decod)	else
							'0';
							
		ALUC(2)		<= '0' when ((instruction = ADD)) and (CurrentState = SFetch_Decod)	else
							'1';
							
		SelAddr		<= "00" when (CurrentState = SFetch_Addr) else -- Quando estamos no estado T1 Fetch Address
						--	"00" when ((instruction = LDI) or (instruction = LDIH) or (instruction = ADD)) and (CurrentState = SFetch_Addr)	else
							"01" when (instruction = (NOP))	else
							"10" when (instruction = (NOP))	else
							"11" when (instruction = (NOP))	else
							"00";
							
		SelData(0)	<= '0' when ((instruction = LDI) or (instruction = LDIH)) and (CurrentState = SFetch_Decod)	else
							'1' when ((instruction = ADD)) and (CurrentState = SFetch_Decod)	else
							'0';
							
		SelData(1)	<= '0' when ((instruction = LDI) or (instruction = LDIH)) and (CurrentState = SFetch_Decod)	else
							'1' when ((instruction = ADD)) and (CurrentState = SFetch_Decod)	else
							'0';
							
		Sellmm		<= '1' when ((instruction = LDIH) ) and (CurrentState = SFetch_Decod)	else
							'0' when ((instruction = LDI) ) and (CurrentState = SFetch_Decod)	else
							'0';
							
		RD 			<= '1' when (CurrentState = SFetch_Inst) else -- Quando estamos no estado T2 Fetch Instruction
							--'1' when ((instruction = LDI) or (instruction = LDIH) or (instruction = ADD)) and (CurrentState = SFetch_Inst)	else
							'0';
--LOW														
		WR(0)			<= '0' when (instruction = LDI) or (instruction = LDIH) or (instruction = ADD)	else -- Word
							'1' when (instruction = (NOP))	else
							'0';
--HIGH
		WR(1)			<= '0' when (instruction = LDI) or (instruction = LDIH) or (instruction = ADD)	else -- Word
							'1' when (instruction = (NOP))	else
							'0';
			
		LDST			<= '0' when (instruction = LDI) or (instruction = LDIH) or (instruction = ADD)	else
							'1' when (instruction = (NOP))	else --LDI
							'0';
							
		BGT			<=	'0' when ((instruction = (NOP))) else
							'1' when ((instruction = (NOP))) else
							'0';
							
		S1S0 			<= "00" when ((instruction = LDI) or (instruction = LDIH) or (instruction = ADD)) and ((CurrentState = SFetch_Addr) or (CurrentState = SFetch_Inst) or (CurrentState = SFetch_Decod))	else
							"01" when ((instruction = LDI) or (instruction = LDIH) or (instruction = ADD)) and ((CurrentState = SExecution) or (CurrentState = SExec_Addr) or (CurrentState = SExec_RW))	else 
							"10" when ((instruction = (NOP)))	else
							"11" when ((instruction = (NOP)))	else
							"00";
							
		EIR			<= '1' when (CurrentState = SFetch_Inst) else -- Quando estamos no estado T2 Fetch Instruction
							--'1' when ((instruction = LDI) or (instruction = LDIH) or (instruction = ADD)) and (CurrentState = SFetch_Inst)	else
							'0';

end Behavioral;

