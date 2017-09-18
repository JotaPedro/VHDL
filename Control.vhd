----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Control - Descrição Comportamental

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


entity Control is
    Port ( A0 			: in  STD_LOGIC;
           Flags 		: in  STD_LOGIC_VECTOR(2 downto 0);-- 0-Zero 1-Carry 2-GE
           OpCode 	: in  STD_LOGIC_VECTOR(6 downto 0);-- IR9_15
           INTP 		: in  STD_LOGIC;
           Clock 		: in  STD_LOGIC;
           CL 			: in  STD_LOGIC;
           Sync 		: in  STD_LOGIC_VECTOR(1 downto 0);  -- 0- BRQ, 1-RDY
           BusCtr 	: out  STD_LOGIC_VECTOR(3 downto 0); -- 0-WrByte, 1-DataOut, 2-Addr, 3-ALE
           RFC 		: out  STD_LOGIC_VECTOR(12 downto 0);
           ALUC 		: out  STD_LOGIC_VECTOR(2 downto 0);
           SelAddr 	: out  STD_LOGIC_VECTOR(1 downto 0);
           SelData	: out  STD_LOGIC_VECTOR(1 downto 0);
           Sellmm 	: out  STD_LOGIC;
			  RD 			: out	 STD_LOGIC; 
			  WR			: out  STD_LOGIC_VECTOR(1 downto 0); -- 0-WRL, 1-WRH
			  BGT			: out	 STD_LOGIC;
			  S1S0 		: out	 STD_LOGIC_VECTOR(1 downto 0);
			  EIR			: out	 STD_LOGIC
	);
end Control;

architecture Behavioral of Control is

	signal CurrentState 	: STATE_TYPE := SReset;
	signal NewState 		: STATE_TYPE;
	signal LDST : STD_LOGIC;
	signal instruction : INST_TYPE;
	signal flagUpdate	 : STD_LOGIC;
	
begin
	
	inst: InstDecode Port map (  
		OpCode 		=>  OpCode,
		Inst			=> instruction,
		FlagUpdate	=> flagUpdate
	);


    State_Change: 
	 process (Clock)
    begin
        if rising_edge(Clock) then
            CurrentState <= NewState;
        end if;
    end process;

    ---------------------
    -- Proximo estado
    ---------------------
    Nxt_State_Eval : 
	 process (CL, Sync, INTP,  CurrentState)
    begin
        if (CL = '1') then
            NewState <= SReset; 
        else
            case (CurrentState) is
					
					 when SReset =>if (Sync(0)= '1') then 			-- BRQ activo
													NewState <= SHold_Exec;
											else
													NewState <= SFetch_Addr;										
											end if;
			
                when SFetch_Addr => NewState <= SFetch_Inst;

                when SFetch_Inst => if (Sync(1)= '0') then 	--Sync(Ready) activo
													 NewState <= SWait_Fetch;
												else
													 NewState <= SFetch_Decod;
												end if;


                when SFetch_Decod =>if (( LDST = '1' ) and (Sync(0)= '1')) then --BRQ activo
													 NewState <= SHold_Exec;
												else
													if (( LDST = '1' ) and (Sync(0)= '0')) then
														NewState <= SExec_Addr;
													 else
														NewState <= SExecution;
													end if;
												end if;

					
					when SExecution => if (Sync(0)= '1') then 			--BRQ activo
													 NewState <= SHold_Fetch;
												else
													if (INTP = '1') then
													 NewState <= SInterrupt;
													else 
--														if (breakCondition) then
--															NewState <= SBreak;
--														else
															NewState <= SFetch_Addr;
--														end if;
													end if;
												end if;
												
					when SExec_Addr => 	NewState <= SExec_RW;
																
					when SExec_RW => if (Sync(1)= '0') then 	-- ready activo
												NewState <= SWait_Exec;
											else 
												NewState <= SExecution;
											end if;
											
					when SInterrupt => if (Sync(0)= '1') then -- BRQ activo
												NewState <= SHold_Fetch;
											else
--												if(breakCondition) then
--													NewState <= SBreak;
--												else
													NewState <= SFetch_Addr;
--												end if;
											end if;
					
--					when SBreak => if (GO = '0') then -- Se não existir sinal para continuar, mantemos o Break.
--												NewState <= SBreak;
--										else
--												NewState <= SFetch_Addr;
--										end if;
										
					when SHold_Fetch => if (Sync(0)= '1') then -- BRQ activo
												NewState <= SHold_Fetch;
											else
--												if(breakCondition) then
--													NewState <= SBreak;
--												else
													NewState <= SFetch_Addr;
--												end if;
											end if;		

					when SHold_Exec =>if (Sync(0)= '1') then -- BRQ activo
													NewState <= SHold_Exec;
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

				
    ------------------------
    -- Signal assignment
    ------------------------

-- 0-WrByte	 
		BusCtr(0)	<= '1' when (OpCode(1) = '0') and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed)) and (CurrentState = SExec_RW)	else 
							'0';
-- 1-DataOut							
		BusCtr(1)	<= '1' when ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed)) and (CurrentState = SExec_RW)	else
							'0';
-- 2-Addr							
		BusCtr(2)	<= '1' when (CurrentState = SFetch_Addr) or (CurrentState = SExec_Addr)  else 
							'0';
-- 3-ALE							
		BusCtr(3)	<= '1' when (CurrentState = SFetch_Addr) or (CurrentState = SExec_Addr) else 
							'0';
--en_dest_data							
		RFC(0)		<= '1' when ((instruction = LDI) or (instruction = LDIH) or (instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed) or (instruction = ADD) or (instruction = ADDC) or (instruction = ADD_const) or (instruction = ADDC_const) or (instruction = SUB) or (instruction = SBB) or (instruction = SUB_const) or (instruction = SBB_const) or (instruction = ANL) or (instruction = ORL) or (instruction = XRL) or (instruction = NT) or (instruction = SHL) or (instruction = SHR) or (instruction = RRL) or (instruction = RRM) or (instruction = RCR) or (instruction = RCL)) and (CurrentState = SExecution)	else
							'0';
--en_link						
		RFC(1)		<= '1' when (instruction = JMPL) and (CurrentState = SFetch_Decod) else
							'0';
--en_psw
		RFC(2)		<= '1' when (flagUpdate = '1' or instruction = IRET) and (CurrentState = SExecution)	else
							'0';
--en_pc							
		RFC(3)		<= '1' when (CurrentState = SFetch_Inst) or ((instruction = IRET) and (CurrentState = SExecution)) or ((((Flags(0) = '1') and (instruction = JZ)) or ((Flags(0) = '0') and (instruction = JNZ)) or ((Flags(1) = '1') and (instruction = JC)) or ((Flags(1) = '0') and (instruction = JNC)) or (instruction = JMP) or (instruction = JMPL)) and (CurrentState = SExecution)) else
							'0';
--s_jmp	
		RFC(4)		<= '1' when (((Flags(0) = '1') and (instruction = JZ)) or ((Flags(0) = '0') and (instruction = JNZ)) or ((Flags(1) = '1') and (instruction = JC)) or ((Flags(1) = '0') and (instruction = JNC)) or (instruction = JMP) or (instruction = JMPL)) and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution))	else
							'0';
--SLink		
		RFC(5)		<= '1' when (instruction = JMPL and CurrentState = SFetch_Decod) else
							'0';
--SPSW		
		RFC(7 downto 6)	<= "01" when ((instruction = ADD) or (instruction = ADDC) or (instruction = ADD_const) or (instruction = ADDC_const) or (instruction = SUB) or (instruction = SBB) or (instruction = SUB_const) or (instruction = SBB_const) or (instruction = ANL) or (instruction = ORL) or (instruction = XRL) or (instruction = NT) or (instruction = SHL) or (instruction = SHR) or (instruction = RRL) or (instruction = RRM) or (instruction = RCR) or (instruction = RCL)) and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution)) else
									"10" when (instruction = IRET and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution))) else
									"11" when (CurrentState = SInterrupt) else
									"00";
--SPC		
		RFC(9 downto 8)	<= "01" when (CurrentState = SInterrupt) else
									"10" when (CurrentState = SFetch_Inst) else
									"11" when (instruction = IRET and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution))) else
									"00";						
--SR0i		
		RFC(10)		<= '1' when (CurrentState = SInterrupt) else
							'0';	
--SR5i		
		RFC(11)		<= '1' when (CurrentState = SInterrupt) else
							'0';	
--interrupt		
		RFC(12)		<= '1' when (CurrentState = SInterrupt) else
							'0';	
--ALUC
		ALUC			<= "000" when (((Flags(0) = '1') and (instruction = JZ)) or ((Flags(0) = '0') and (instruction = JNZ)) or ((Flags(1) = '1') and (instruction = JC)) or ((Flags(1) = '0') and (instruction = JNC)) or (instruction = JMP) or (instruction = JMPL)) and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution))	else
							"001" when ((OpCode(1) = '0') and ((instruction = LD_IndConst) or (instruction = ST_IndConst)) and  ((CurrentState = SFetch_Decod) or (CurrentState = SExec_Addr))) else
							"001" when ((instruction = ADD_const) or (instruction = ADDC_const) or (instruction = SUB_const) or (instruction = SBB_const) or (instruction = SHL) or (instruction = SHR) or (instruction = RRL) or (instruction = RRM)) and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution))	else
							"010" when ((OpCode(1) = '1') and ((instruction = LD_IndConst) or (instruction = ST_IndConst))) and ((CurrentState = SFetch_Decod) or (CurrentState = SExec_Addr))	else
							"011" when ((OpCode(1) = '0') and ((instruction = LD_Indexed) or (instruction = ST_Indexed)) and ((CurrentState = SFetch_Decod) or (CurrentState = SExec_Addr)))	else
							"011" when ((instruction = ADD) or (instruction = ADDC) or (instruction = SUB) or (instruction = SBB) or (instruction = ANL) or (instruction = ORL) or (instruction = XRL) or (instruction = NT)) and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution))	else
							"100" when ((OpCode(1) = '1') and ((instruction = LD_Indexed) or (instruction = ST_Indexed))) and ((CurrentState = SFetch_Decod) or (CurrentState = SExec_Addr))	else
							"000";
					
		SelAddr		<= "01" when ((instruction = LD_IndConst) or (instruction = LD_Indexed) or (instruction = ST_IndConst) or (instruction = ST_Indexed)) and ((CurrentState = SFetch_Decod) or (CurrentState = SExec_Addr) or (CurrentState = SExecution))	else
							"10" when ((instruction = LD_Direct) or (instruction = ST_Direct)) and ((CurrentState = SFetch_Decod) or (CurrentState = SExec_Addr) or (CurrentState = SExecution))	else
							"00";
							
		SelData		<= "01" when (OpCode(1) = '1') and ((instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed)) and ((CurrentState = SExec_RW) or (CurrentState = SExecution))	else
							"10" when (OpCode(1) = '0') and ((instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed)) and ((CurrentState = SExec_RW) or (CurrentState = SExecution))	else
							"11" when ((instruction = ADD) or (instruction = ADDC) or (instruction = ADD_const) or (instruction = ADDC_const) or (instruction = SUB) or (instruction = SBB) or (instruction = SUB_const) or (instruction = SBB_const) or (instruction = ANL) or (instruction = ORL) or (instruction = XRL) or (instruction = NT) or (instruction = SHL) or (instruction = SHR) or (instruction = RRL) or (instruction = RRM) or (instruction = RCR) or (instruction = RCL) ) and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution)) else
							"11" when (( ((Flags(0) = '1') and (instruction = JZ)) or ((Flags(0) = '0') and (instruction = JNZ)) or ((Flags(1) = '1') and (instruction = JC)) or ((Flags(1) = '0') and (instruction = JNC)) or (instruction = JMP) or (instruction = JMPL)) and (CurrentState = SExecution))	else
							"00";
							
		Sellmm		<= '1' when ((instruction = LDIH) ) and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution))	else
							'0' when ((instruction = LDI) ) and ((CurrentState = SFetch_Decod) or (CurrentState = SExecution))	else
							'0';
							
		RD 			<= '1' when (CurrentState = SFetch_Inst) or ((CurrentState = SExec_RW) and ((instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed))) else
							'0';
--WR LOW									
		WR(0)			<= '1' when ((OpCode(1) = '0') and (A0 = '1') and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed))) and (CurrentState = SExec_RW)	else
							'1' when ((OpCode(1) = '1') and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed))) and (CurrentState = SExec_RW)	else
							'0';
--WR HIGH
		WR(1)			<= '1' when ((OpCode(1) = '0') and (A0 = '0') and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed))) and (CurrentState = SExec_RW)	else
							'1' when ((OpCode(1) = '1') and ((instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed))) and (CurrentState = SExec_RW)	else
							'0';
		
		LDST			<= '1' when (instruction = LD_Direct) or (instruction = LD_IndConst) or (instruction = LD_Indexed) or (instruction = ST_Direct) or (instruction = ST_IndConst) or (instruction = ST_Indexed)	else 
							'0';
							
		BGT			<=	'1' when ((CurrentState = SHold_Fetch) or (CurrentState = SHold_Exec)) else 
							'0';
							
		S1S0 			<= "00" when ((CurrentState = SFetch_Addr) or (CurrentState = SFetch_Inst) or (CurrentState = SFetch_Decod))	else
							"01" when ((CurrentState = SExecution) or (CurrentState = SExec_Addr) or (CurrentState = SExec_RW))	else 
							"10" when ((CurrentState = SBreak))	else 
							"11" when ((CurrentState = SInterrupt))	else
							"00";
							
		EIR			<= '1' when (CurrentState = SFetch_Inst) else
							'0';

end Behavioral;