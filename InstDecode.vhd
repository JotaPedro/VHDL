library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstDecode is
    Port ( OpCode 	: in  STD_LOGIC_VECTOR(6 downto 0);-- bits de 15 a 9
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
			  EIR			: out	 STD_LOGIC;
			  LDST		: out	 STD_LOGIC 
	);
end InstDecode;

architecture Behavioral of InstDecode is
	
	type INSTRUCTION_TYPE is (LDI, LDIH, LD_Direct, LD_IndConst, LD_Indexed, ST_Direct, ST_IndConst, ST_Indexed, ADD, ADDC, ADD_const, ADDC_const, SUB, SBB, SUB_const, SBB_const, ANL, ORL, XRL, NT, SHL,SHR,RRL,RRM,RCR,RCL,JZ,JNZ,JC,JNC,JMP,JMP,JMPL,IRET,NOP);
	signal instruction : INSTRUCTION_TYPE;
	
begin

	 Inst_Decode:
	 process (OpCode)
    begin
		
		case (OpCode) is
			when "0000000"|"0000001"|"0000010"|"0000011" => instruction	<=	LDI;
			when "0000100"|"0000101"|"0000110"|"0000111" => instruction	<=	LDIH;
			
			when "0001000"|"0001001"|"0001010"|"0001011" => instruction	<=	LD_Direct;
			when "0001100"|"0001110"							=> instruction	<=	LD_IndConst;
			when "0001101"|"0001111"							=> instruction	<=	LD_Indexed;
			
			when "0011000"|"0011001"|"0011010"|"0011011" => instruction	<=	ST_Direct;
			when "0011100"|"0011110"							=> instruction	<=	ST_IndConst;
			when "0011101"|"0011111"							=> instruction	<=	ST_Indexed;
			when "1000000"|"1000001"|"1000010"|"1000011" => instruction	<=	ADD;
			when "1001000"|"1001001"|"1001010"|"1001011" => instruction	<=	ADDC
			when "1000100"|"1000101"|"1000110"|"1000111" => instruction	<=	SUB
			when "1001100"|"1001101"|"1001110"|"1001111" => instruction	<=	SBB
			
			when "1010000"|"1010001"|"1010010"|"1010011" => instruction	<=	ADD_const
			when "1011000"|"1011001"|"1011010"|"1011011" => instruction	<=	ADDC_const
			when "1010100"|"1010101"|"1010110"|"1010111" => instruction	<=	SUB_const
			when "1011100"|"1011101"|"1011110"|"1011111" => instruction	<=	SBB_const
			
			when "1100000"|"1100001"|"1100010"|"1100011" => instruction	<=	ANL
			when "1100100"|"1100101"|"1100110"|"1100111" => instruction	<=	ORL
			when "1101000"|"1101001"|"1101010"|"1101011" => instruction	<=	XRL
			when "1101100"|"1101101"|"1101110"|"1101111" => instruction	<=	NT
			
			when "1110000"|"1110001"|"1110010"|"1110011" => instruction	<=	SHL
			when "1110100"|"1110101"|"1110110"|"1110111" => instruction	<=	SHR
			when "1111000"|"1111001"							=> instruction	<=	RRL
			when "1111010"|"1111011"							=> instruction	<=	RRM
			when "1111100"|"1111101"							=> instruction	<=	RCR
			when "1111110"|"1111111"							=> instruction	<=	RCL
			
			when "0100000"|"0100001"|"0100010"|"0100011" => instruction	<=	JZ
			when "0100100"|"0100101"|"0100110"|"0100111" => instruction	<=	JNZ
			when "0101000"|"0101001"|"0101010"|"0101011" => instruction	<=	JC
			when "0101100"|"0101101"|"0101110"|"0101111" => instruction	<=	JNC
			when "0110000"|"0110001"|"0110010"|"0110011" => instruction	<=	JMP
			when "0110100"|"0110101"|"0110110"|"0110111" => instruction	<=	JMPL
			
			when "0111000"|"0111001"|"0111010"|"0111011" => instruction	<=	IRET
			when "0111100"|"0111101"|"0111110"|"0111111" => instruction	<=	NOP

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
			
		LDST			<= '1' when ((CurrentState = SFetch_Decod) and (OpCode(6 downto 5)="00") and (OpCode(4 downto 2) = "010"))	else --LDI
							'0';


end InstDecode;