library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstDecode_V2 is
    Port (  OpCode 	: in  STD_LOGIC_VECTOR(6 downto 0);-- bits de 15 a 9
				Inst		: out INST_TYPE; --Que instrução é a descodificada.
				FlagUpdate: out STD_LOGIC --Se é para atualizar o registo de flags. true/false
	);
end InstDecode_V2;

architecture Behavioral of InstDecode_V2 is
	
	--type INST_TYPE is (LDI, LDIH, LD_Direct, LD_IndConst, LD_Indexed, ST_Direct, ST_IndConst, ST_Indexed, ADD, ADDC, ADD_const, ADDC_const, SUB, SBB, SUB_const, SBB_const, ANL, ORL, XRL, NT, SHL,SHR,RRL,RRM,RCR,RCL,JZ,JNZ,JC,JNC,JMP,JMPL,IRET,NOP);
	signal instruction : INST_TYPE;
	
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
			when "1001000"|"1001001"|"1001010"|"1001011" => instruction	<=	ADDC;
			when "1000100"|"1000101"|"1000110"|"1000111" => instruction	<=	SUB;
			when "1001100"|"1001101"|"1001110"|"1001111" => instruction	<=	SBB;
			
			when "1010000"|"1010001"|"1010010"|"1010011" => instruction	<=	ADD_const;
			when "1011000"|"1011001"|"1011010"|"1011011" => instruction	<=	ADDC_const;
			when "1010100"|"1010101"|"1010110"|"1010111" => instruction	<=	SUB_const;
			when "1011100"|"1011101"|"1011110"|"1011111" => instruction	<=	SBB_const;
			
			when "1100000"|"1100001"|"1100010"|"1100011" => instruction	<=	ANL;
			when "1100100"|"1100101"|"1100110"|"1100111" => instruction	<=	ORL;
			when "1101000"|"1101001"|"1101010"|"1101011" => instruction	<=	XRL;
			when "1101100"|"1101101"|"1101110"|"1101111" => instruction	<=	NT;
			
			when "1110000"|"1110001"|"1110010"|"1110011" => instruction	<=	SHL;
			when "1110100"|"1110101"|"1110110"|"1110111" => instruction	<=	SHR;
			when "1111000"|"1111001"							=> instruction	<=	RRL;
			when "1111010"|"1111011"							=> instruction	<=	RRM;
			when "1111100"|"1111101"							=> instruction	<=	RCR;
			when "1111110"|"1111111"							=> instruction	<=	RCL;
			
			when "0100000"|"0100001"|"0100010"|"0100011" => instruction	<=	JZ;
			when "0100100"|"0100101"|"0100110"|"0100111" => instruction	<=	JNZ;
			when "0101000"|"0101001"|"0101010"|"0101011" => instruction	<=	JC;
			when "0101100"|"0101101"|"0101110"|"0101111" => instruction	<=	JNC;
			when "0110000"|"0110001"|"0110010"|"0110011" => instruction	<=	JMP;
			when "0110100"|"0110101"|"0110110"|"0110111" => instruction	<=	JMPL;
			
			when "0111000"|"0111001"|"0111010"|"0111011" => instruction	<=	IRET;
			when "0111100"|"0111101"|"0111110"|"0111111" => instruction	<=	NOP;
			
			when others => instruction	<=	NOP;
		end case;
	
--	FlagUpdate <= OpCode(1); -- Apenas faz sentido quando a instrução é logica/aritmética com 3 registos e aritmética com constante, mas não lógica com constante.
--	Inst <= instruction;
	end process;
	
	
	FlagUpdate <= '1' when (OpCode(6 downto 4) = "111") OR (((OpCode(6 downto 4) = "110") OR (OpCode(6 downto 5) = "10")) and (OpCode(1) = '1')) else 
					  '0'; -- Apenas faz sentido quando a instrução é logica/aritmética com 3 registos e aritmética com constante, mas não lógica com constante.
	Inst <= instruction;
	
end Behavioral;