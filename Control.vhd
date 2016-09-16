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
use pds16_types.ALL;

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
			  S0 			: out	 STD_LOGIC;
			  S1 			: out	 STD_LOGIC;
			  EIR			: out	 STD_LOGIC
	);
end Control;

architecture Behavioral of Control is

	type STATE_TYPE is (SReset, SFetch_Addr, SFetch_Inst, SFetch_Decod, SExecution, SExec_Addr, SExec_RW, SInterrupt, SBreak, SHold_Fetch, SHold_Exec, SWait_Fetch, SWait_Exec);
	signal CurrentState, NewState : STATE_TYPE;
	type INSTRUCTION_TYPE is (LDI, LDIH, LD_Direct, LD_IndConst, LD_Indexed, ST_Direct, ST_IndConst, ST_Indexed, Aritmetic, Aritmetic_Const, Logic, Shifts, Jumps, JZ, JNZ, JC, JNC, JMP, JMPL, NOP, IRET);
	signal CurrentInst : INSTRUCTION_TYPE;
	signal loadstoremem : STD_LOGIC; --sinal que indica que a operação em uso é load/store com acesso à memoria.
	
begin

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

                when SFetch_Inst => if (Sync(1)= '0') then --Ready activo
													 NewState <= SWait_Fetch;
												else
													 NewState <= SFetch_Decod;
												end if;
--loadStoreMem significa operações load (não contar com a operação load immediato) ou store.--------------------------------------------------------
                when SFetch_Decod =>if (( loadstoremem = '1' ) and (Sync(0)= '1')) then --BRQ activo
													 NewState <= SHold_Exec;
												else
													if (( loadstoremem = '1' ) and (Sync(0)= '0')) then
														NewState <= SExec_Addr;
													 else
														NewState <= SExecution;
													end if;
												end if;
 
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

	 
	 Inst_Decode: --ATENÇÂO!!!! CORRIGIR A INTRODUÇÂO DOS JZ,JC,ETC!!!!
	 --Tenho de introduzir este código no outro process, pois não posso ter dois processos com o mesmo sinal a ser afectado (CurrentState).
	 process (CurrentState)
    begin
        if (CurrentState = SFetch_Decod) then
		  --Identificar a instrução para depois facilitar a descodificação dos sinais acima.
--		  type INSTRUCTION_TYPE is (LDI, LDIH, LD_Direct, LD_IndConst, LD_Indexed, ST_Direct, ST_IndConst, ST_Indexed, Aritmetic, Aritmetic_Const, Logic, Shifts, JZ, JNZ, JC, JNC, JMP, JMPL, NOP, IRET);
--			signal CurrentInst : INSTRUCTION_TYPE;
		  --OpCode 	: in  STD_LOGIC_VECTOR(6 downto 0);-- bits de 15 a 9
		  
            case (OpCode(6 downto 2)) is
--					when ("00)=>
						-- is Data transfer
--						case(OpCode(4 downto 2)) is
					when("00000")=> CurrentInst	<=	LDI; --LDI
					when("00001")=> CurrentInst	<=	LDIH;  --LDIH
					when("00010")=> CurrentInst	<=	;  --LD_direct,LD_indconst,LD_Indexed
					when("110")=> CurrentInst	<=	;  --ST_direct,ST_indconst,ST_Indexed
--				end case;
						
					when ("01")=>
						-- is Jumps, nop and iret
						if(OpCode(4)='0') then
							 CurrentInst	<=	Jumps; --JMPs condicionais
						end if;
						case(OpCode(4 downto 2)) is
							when("100")=> CurrentInst	<=	JMP;  --JMP
							when("101")=> CurrentInst	<=	JMPL;  --JMPL
							when("110")=> CurrentInst	<=	IRET;  --IRET
							when("111")=> CurrentInst	<=	NOP;  --NOP
							when others=> CurrentInst	<=	NOP;  --NOP
						end case;
										
					when ("10")=>
						-- is Aritmetic
						if(OpCode(4)='0') then
							 CurrentInst	<=	Aritmetic; --Aritmetic
						else if(OpCode(4)='0') then
							 CurrentInst	<=	Aritmetic_Const; --Aritmetic_const
							end if;
						end if;
						
					when ("11")=>
						-- is Logic and shifts
						if(OpCode(4)='0') then
							 CurrentInst	<=	Logic; --Logic
						else if(OpCode(4)='0') then
							 CurrentInst	<=	Shifts; --Shifts
							end if;
						end if;
						
				end case;
			end if;
	end process;
							
    ---------------------------------------------------------------------------
    -- Signal assignment statements for 
    ---------------------------------------------------------------------------
--	 exemplo:
--	 sa_lin_cntr_en_assignment:
--	 sa_lin_cntr_en <= SA_READY      when (CS = SInit)  else
--                    inbuffers_rdy when (CS = SLdL)   else
--                    inbuffers_rdy when (CS = SWaitR) else
--					 		 inbuffers_rdy when (CS = SLdR)   else
--                    inbuffers_rdy when (CS = SWaitL) else
--                    '0';

--type INSTRUCTION_TYPE is (LDI, LDIH, LD_Direct, LD_IndConst, LD_Indexed, ST_Direct, ST_IndConst, ST_Indexed,
--Aritmetic, Aritmetic_Const, Logic, Shifts, JZ, JNZ, JC, JNC, JMP, JMPL, NOP, IRET);

-- 0-WrByte	 
		BusCtr(0)	<= '0' when ((CurrentState = SFetch_Decod) and (CurrentInst = ST_Direct) and (OpCode(1)='0'))		else -- Word
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst) and (OpCode(1)='0')	else -- Word
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed) and (OpCode(1)='0')	else -- Word
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Direct) and (OpCode(1)='1')		else -- Byte
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst) and (OpCode(1)='1')	else -- Byte
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed) and (OpCode(1)='1')	else -- Byte
--							OpCode(1) when (CurrentState = SExecution or SExec_RW) and (OpCode(4)='1') else	--store
							'0';
-- 1-DataOut							
		BusCtr(1)	<= '1' when (CurrentState = SExec_RW) and (CurrentInst = ST_Direct) and (OpCode(1)='0')		else 
							'1' when (CurrentState = SExec_RW) and (CurrentInst = ST_IndConst) and (OpCode(1)='1')	else 
							'1' when (CurrentState = SExec_RW) and (CurrentInst = ST_Indexed) and (OpCode(1)='0')		else 
--							'0' when (CurrentState = SExec_RW) and (OpCode(4)='0')	 		else	--load
							'0';
-- 2-Addr							
		BusCtr(2)	<= '1' when (CurrentState = SFetch_Addr) 												else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = LD_Direct) 		else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = LD_IndConst) 	else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = LD_Indexed) 		else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = ST_Direct) 		else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = ST_IndConst) 	else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = ST_Indexed) 		else
--							'0' when (CurrentState = SFetch_Inst) 									else
--							'0' when (CurrentState = SExec_RW) and (OpCode(4)='0')	 		else	--load
							'0';
-- 3-ALE							
		BusCtr(3)	<= '1' when (CurrentState = SFetch_Addr)						 						else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = LD_Direct) 		else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = LD_IndConst) 	else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = LD_Indexed) 		else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = ST_Direct) 		else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = ST_IndConst) 	else
							'1' when (CurrentState = SExec_Addr) and (CurrentInst = ST_Indexed) 		else
--							'1' when (CurrentState = SExec_RW) and (OpCode(4)='1')	else--store
							'0';
--Decoder							
		RFC(0)		<= '1' when (CurrentState = SFetch_Decod) and (CurrentInst = LDI) 		else
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = LDIH) 		else
							'1' when (CurrentState = SExecution) and (CurrentInst = LD_Direct) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = LD_IndConst) else
							'1' when (CurrentState = SExecution) and (CurrentInst = LD_Indexed) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Aritmetic) and (OpCode(0)='0')	else
							'0' when (CurrentState = SExecution) and (CurrentInst = Aritmetic) and (OpCode(0)='1')	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Aritmetic_Const) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Logic) and (OpCode(0)='0')	else
							'0' when (CurrentState = SExecution) and (CurrentInst = Logic) and (OpCode(0)='1')	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Shifts) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = JZ) and (Flags(0)='1') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JNZ) and (Flags(0)='0') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JC) and (Flags(1)='1') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JNC) and (Flags(1)='0') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JMP) else
							'1' when (CurrentState = SExecution) and (CurrentInst = JMPL) else
							
--							'1' when (CurrentState = SFetch_Decod) and (OpCode(6 downto 5)='00') and (OpCode(4 downto 3) = '00')	else --LDI & LDIH
							'0';
--mplexr5 -Link						
		RFC(1)		<= '1' when (CurrentState = SFetch_Decod) and (CurrentInst = JMPL) else
							'0';
--mplexr6 -flags
		RFC(2)		<= '1' when (CurrentState = SExecution) and (CurrentInst = Aritmetic) and (OpCode(1)='0')	else
							'0' when (CurrentState = SExecution) and (CurrentInst = Aritmetic) and (OpCode(1)='1')	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Aritmetic_Const) and (OpCode(1)='0')	else
							'0' when (CurrentState = SExecution) and (CurrentInst = Aritmetic_Const) and (OpCode(1)='1')	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Logic) and (OpCode(1)='0')	else
							'0' when (CurrentState = SExecution) and (CurrentInst = Logic) and (OpCode(1)='1')	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Shifts) 	else
							'0';
--mplexr7 -PC							
		RFC(3)		<= '1' when (CurrentState = SFetch_Decod) and (CurrentInst = JZ) and (Flags(0)='0') else
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = JNZ) and (Flags(0)='1') else
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = JC) and (Flags(1)='0') else
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = JNC) and (Flags(1)='1') else
							'0';
--mplexAddrA	
		RFC(4)		<= '0' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_IndConst)	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_Indexed)	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst)	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed)	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Aritmetic)		else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Aritmetic_Const) 	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Logic) 	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Shifts) 	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JZ) and (Flags(0)='1') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JNZ) and (Flags(0)='0') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JC) and (Flags(1)='1') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JNC) and (Flags(1)='0') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JMP) else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JMPL) else
							'0';
							
		ALUC(0)		<= '0' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_IndConst) and (OpCode(1)='0')	else -- Word
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_IndConst) and (OpCode(1)='1')	else -- Byte
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_Indexed) and (OpCode(1)='0')	else -- Word
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_Indexed) and (OpCode(1)='1')	else -- Byte
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst) and (OpCode(1)='0')	else -- Word
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst) and (OpCode(1)='1')	else -- Byte
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed) and (OpCode(1)='0')	else -- Word
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed) and (OpCode(1)='1')	else -- Byte
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = Aritmetic)								else
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = Aritmetic_Const) 	else
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = Logic) 	else
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = Shifts) 	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JZ) and (Flags(0)='1') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JNZ) and (Flags(0)='0') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JC) and (Flags(1)='1') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JNC) and (Flags(1)='0') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JMP) else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JMPL) else
							'0';
							
		ALUC(1)		<= '1' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_IndConst) and (OpCode(1)='0')	else -- Word
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_IndConst) and (OpCode(1)='1')	else -- Byte
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_Indexed) and (OpCode(1)='0')	else -- Word
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_Indexed) and (OpCode(1)='1')	else -- Byte
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst) and (OpCode(1)='0')	else -- Word
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst) and (OpCode(1)='1')	else -- Byte
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed) and (OpCode(1)='0')	else -- Word
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed) and (OpCode(1)='1')	else -- Byte
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = Aritmetic)								else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Aritmetic_Const) 	else
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = Logic) 	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Shifts) 	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JZ) and (Flags(0)='1') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JNZ) and (Flags(0)='0') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JC) and (Flags(1)='1') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JNC) and (Flags(1)='0') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JMP) else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JMPL) else
							'0';
							
		ALUC(2)		<= '0' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_IndConst) and (OpCode(1)='0')	else -- Word
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_IndConst) and (OpCode(1)='1')	else -- Byte
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_Indexed) and (OpCode(1)='0')	else -- Word
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = LD_Indexed) and (OpCode(1)='1')	else -- Byte
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst) and (OpCode(1)='0')	else -- Word
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst) and (OpCode(1)='1')	else -- Byte
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed) and (OpCode(1)='0')	else -- Word
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed) and (OpCode(1)='1')	else -- Byte
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Aritmetic)								else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Aritmetic_Const) 	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Logic) 	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = Shifts) 	else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JZ) and (Flags(0)='1') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JNZ) and (Flags(0)='0') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JC) and (Flags(1)='1') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JNC) and (Flags(1)='0') else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JMP) else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = JMPL) else
							'0';
							
		SelAddr		<= "00" when (CurrentState = SFetch_Addr) 											else
							"10" when (CurrentState = SFetch_Decod) and (CurrentInst = LD_Direct)	else
							"01" when (CurrentState = SFetch_Decod) and (CurrentInst = LD_IndConst)	else
							"01" when (CurrentState = SFetch_Decod) and (CurrentInst = LD_Indexed)	else
							"10" when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Direct)	else
							"01" when (CurrentState = SFetch_Decod) and (CurrentInst = ST_IndConst)	else
							"01" when (CurrentState = SFetch_Decod) and (CurrentInst = ST_Indexed)	else
--							"01" when (CurrentState = SExec_Addr) and (OpCode(3 downto 2)='11') 	else --indexado
--							"10" when (CurrentState = SExec_Addr) 											else --direct
							"00";
							
		SelData(0)	<= '0' when (CurrentState = SFetch_Decod) and (CurrentInst = LDI) 		else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = LDIH) 		else
							'1' when (CurrentState = SExec_RW) and (CurrentInst = LD_Direct) 		else
							'1' when (CurrentState = SExec_RW) and (CurrentInst = LD_IndConst) 	else
							'1' when (CurrentState = SExec_RW) and (CurrentInst = LD_Indexed) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Aritmetic) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Aritmetic_Const) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Logic) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Shifts) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = JZ) and (Flags(0)='1') else --Confirmar possivel problema da mudança das flags antes de se terminar o JZ
							'1' when (CurrentState = SExecution) and (CurrentInst = JNZ) and (Flags(0)='0') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JC) and (Flags(1)='1') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JNC) and (Flags(1)='0') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JMP) else
							'1' when (CurrentState = SExecution) and (CurrentInst = JMPL) else
--							'0' when (CurrentState = SFetch_Decod) and (OpCode(6 downto 5)='00') and (OpCode(4 downto 3) = '00')	else --LDI & LDIH
							'0';
							
		SelData(1)	<= '0' when (CurrentState = SFetch_Decod) and (CurrentInst = LDI) 		else
							'0' when (CurrentState = SFetch_Decod) and (CurrentInst = LDIH) 		else
							'0' when (CurrentState = SExec_RW) and (CurrentInst = LD_Direct) 		else
							'0' when (CurrentState = SExec_RW) and (CurrentInst = LD_IndConst) 	else
							'0' when (CurrentState = SExec_RW) and (CurrentInst = LD_Indexed) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Aritmetic) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Aritmetic_Const) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Logic) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = Shifts) 	else
							'1' when (CurrentState = SExecution) and (CurrentInst = JZ) and (Flags(0)='1') else --Confirmar possivel problema da mudança das flags antes de se terminar o JZ
							'1' when (CurrentState = SExecution) and (CurrentInst = JNZ) and (Flags(0)='0') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JC) and (Flags(1)='1') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JNC) and (Flags(1)='0') else
							'1' when (CurrentState = SExecution) and (CurrentInst = JMP) else
							'1' when (CurrentState = SExecution) and (CurrentInst = JMPL) else
							'0';
							
		Sellmm		<= '0' when (CurrentState = SFetch_Decod) and (CurrentInst = LDI) 		else
							'1' when (CurrentState = SFetch_Decod) and (CurrentInst = LDIH) 		else
--							'0' when (CurrentState = SFetch_Decod) and (OpCode(6 downto 5)='00') and (OpCode(4 downto 2) = '000')	else --LDI
--							'0' when (CurrentState = SFetch_Decod) and (OpCode(6 downto 5)='00') and (OpCode(4 downto 2) = '001')	else --LDIH
							'0';
							
		RD 			<= '1' when (CurrentState = SExec_RW) and (CurrentInst = LD_Direct) 		else
							'1' when (CurrentState = SExec_RW) and (CurrentInst = LD_IndConst) 	else
							'1' when (CurrentState = SExec_RW) and (CurrentInst = LD_Indexed) 	else
--							'1' when (CurrentState = SFetch_Inst) 	else	-- ACTIVE LOW
--							'0' when (CurrentState = SFetch_Decod) else
--							'1' when (CurrentState = SExec_RW) and (OpCode(4)='0')	 		else	--load
							'0';
--LOW														
		WR(0)			<= '0' when (CurrentState = SExec_RW) and (CurrentInst = ST_Direct) and (OpCode(1)='0')		else -- Word
							'1' when (CurrentState = SExec_RW) and (CurrentInst = ST_Direct) and (OpCode(1)='1')		else -- Byte
							'0' when (CurrentState = SExec_RW) and (CurrentInst = ST_IndConst) and (OpCode(1)='0')	else -- Word
							'1' when (CurrentState = SExec_RW) and (CurrentInst = ST_IndConst) and (OpCode(1)='1')	else -- Byte
							'0' when (CurrentState = SExec_RW) and (CurrentInst = ST_Indexed) and (OpCode(1)='0')		else -- Word
							'1' when (CurrentState = SExec_RW) and (CurrentInst = ST_Indexed) and (OpCode(1)='1')		else -- Byte
--							'1' when (CurrentState = SExec_RW) and (OpCode(4)='1') and (OpCode(1)='0')	else
--							'0' when (CurrentState = SExec_RW) and (OpCode(4)='1') and (OpCode(1)='1')	else
							'0';
--HIGH
		WR(1)			<= '1' when (CurrentState = SExec_RW) and (CurrentInst = ST_Direct) and (OpCode(1)='0')		else -- Word
							'0' when (CurrentState = SExec_RW) and (CurrentInst = ST_Direct) and (OpCode(1)='1')		else -- Byte
							'1' when (CurrentState = SExec_RW) and (CurrentInst = ST_IndConst) and (OpCode(1)='0')	else -- Word
							'0' when (CurrentState = SExec_RW) and (CurrentInst = ST_IndConst) and (OpCode(1)='1')	else -- Byte
							'1' when (CurrentState = SExec_RW) and (CurrentInst = ST_Indexed) and (OpCode(1)='0')		else -- Word
							'0' when (CurrentState = SExec_RW) and (CurrentInst = ST_Indexed) and (OpCode(1)='1')		else -- Byte
--							'1' when (CurrentState = SExec_RW) and (OpCode(4)='1') and (OpCode(1)='1')	else
--							'0' when (CurrentState = SExec_RW) and (OpCode(4)='1') and (OpCode(1)='0')	else
							'0';
							
		BGT			<=	'0' when (CurrentState = SFetch_Addr) 												else
							'0' when (CurrentState = SExec_Addr) and (CurrentInst = LD_Direct) 		else
							'0' when (CurrentState = SExec_Addr) and (CurrentInst = LD_IndConst) 	else
							'0' when (CurrentState = SExec_Addr) and (CurrentInst = LD_Indexed) 		else
							'0' when (CurrentState = SExec_Addr) and (CurrentInst = ST_Direct) 		else
							'0' when (CurrentState = SExec_Addr) and (CurrentInst = ST_IndConst) 	else
							'0' when (CurrentState = SExec_Addr) and (CurrentInst = ST_Indexed) 		else
							'0' when (CurrentState = SExec_RW) and (CurrentInst = LD_Direct) 			else
							'0' when (CurrentState = SExec_RW) and (CurrentInst = LD_IndConst) 		else
							'0' when (CurrentState = SExec_RW) and (CurrentInst = LD_Indexed) 		else
							'0' when (CurrentState = SExec_RW) and (CurrentInst = ST_Direct) 			else
							'0' when (CurrentState = SExec_RW) and (CurrentInst = ST_IndConst) 		else
							'0' when (CurrentState = SExec_RW) and (CurrentInst = ST_Indexed) 		else
--							'0' when (CurrentState = SExec_RW) and (OpCode(4)='1')					else--store
--							'0' when (CurrentState = SFetch_Inst)										  	else
							'0';
							
		S0 			<= '0' when (CurrentState = SFetch_Addr)										  	else
							'0';
							
		S1 			<= '0' when (CurrentState = SFetch_Addr) 											else
							'0';
							
		EIR			<= '1' when (CurrentState = SFetch_Inst)											else
							'0';
			
		loadstoremem<= '1' when ((CurrentState = SFetch_Decod) and (OpCode(6 downto 5)="00") and (OpCode(4 downto 2) = "010"))	else --LDI
							'0';



end Behavioral;

