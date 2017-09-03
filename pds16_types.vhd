--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;

package pds16_types is

	constant unit_delay : time := 1 ns; --valor default
	subtype bit_16 is STD_LOGIC_VECTOR( 15 downto 0 );
	type bit_16_array is array (integer range <>) of bit_16;
	subtype bit_3 is STD_LOGIC_VECTOR( 2 downto 0 );
	type bit_3_array is array (integer range <>) of bit_3;
	subtype bit_8 is STD_LOGIC_VECTOR( 7 downto 0 );
	type bit_8_array is array (integer range <>) of bit_8;
	type INST_TYPE is (LDI, LDIH, LD_Direct, LD_IndConst, LD_Indexed, ST_Direct, ST_IndConst, ST_Indexed, ADD, ADDC, ADD_const, ADDC_const, SUB, SBB, SUB_const, SBB_const, ANL, ORL, XRL, NT, SHL,SHR,RRL,RRM,RCR,RCL,JZ,JNZ,JC,JNC,JMP,JMPL,IRET,NOP);
	type STATE_TYPE is (SReset, SFetch_Addr, SFetch_Inst, SFetch_Decod, SExecution, SExec_Addr, SExec_RW, SInterrupt, SBreak, SHold_Fetch, SHold_Exec, SWait_Fetch, SWait_Exec);

	
	Component MplexWrByte is
    Port ( 	Input0 : in  std_logic_vector(7 downto 0); -- Parte Alta
				Input1 : in  std_logic_vector(7 downto 0); -- Parte Baixa
				Sel : in  STD_LOGIC;
				Output : out  std_logic_vector(15 downto 0));
	end Component;
	
	Component Ram2 is
    port (

        AD 		:in    std_logic_vector (14 downto 0);  		-- address Input
        DATA   :inout std_logic_vector (15 downto 0);  -- data bi-directional
        nWR    :in    std_logic_vector(1 downto 0);             -- Write Enable (High/Low)
        nRD    :in    std_logic                                 	-- Read Enable
    );
	end Component;
	
	
	
	
	Component DFlipFlop is
    Port ( D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Clk : in  STD_LOGIC;
          En : in  STD_LOGIC
			 );
	end Component;
	
	Component FullAdder is
    Port ( Ax : in  STD_LOGIC;
           Bx : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sx : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
	end Component;
	
	Component PC_Adder is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           Result : out  STD_LOGIC_VECTOR(15 downto 0));
	end Component;
	
	Component Adder16bit is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           Cin : in  STD_LOGIC;
           Result : out  STD_LOGIC_VECTOR(15 downto 0);
           Cout : out  STD_LOGIC);
	end Component;
	
	Component Alu_aritmetico is
    Port ( Op : in STD_LOGIC_VECTOR(1 downto 0) ; -- IR12 IR11
			  A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           Cin : in  STD_LOGIC;
           Result : out  STD_LOGIC_VECTOR(15 downto 0);
           Flags_out : out  STD_LOGIC_VECTOR(1 downto 0));
	end Component;
	
	Component Mplex16bit_5to1 is
    Port ( Input_port : in  bit_16_array(4 downto 0);
			  Selector_MP: in STD_LOGIC_VECTOR(2 downto 0);
           Output_port : out  bit_16
			 );
	end Component;
	
	Component Sig_Ext is
    Port ( Const8x2 : in  STD_LOGIC_VECTOR(8 downto 0);
           Output16bit : out  bit_16);
	end Component;
	
	Component Zero_Fill is
    Port ( Const4bit : in  STD_LOGIC_VECTOR(3 downto 0);
           Output16bit : out  bit_16);
	end Component;
	
	Component Alu is
    Port ( aluFunc : in STD_LOGIC_VECTOR(5 downto 0); -- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
			  CyBw : in STD_LOGIC; 
			  A : in STD_LOGIC_VECTOR(15 downto 0);
			  B : in STD_LOGIC_VECTOR(15 downto 0);
			  R : out STD_LOGIC_VECTOR(15 downto 0);
			  flags : out  STD_LOGIC_VECTOR(3 downto 0) -- 0-Zero 1-CyBw 2-GE 3-Parity 
		); 
	end Component;
		
	Component Alu_logico is
    Port ( Input_A : in  STD_LOGIC_VECTOR(15 downto 0);
           Input_B : in  STD_LOGIC_VECTOR(15 downto 0);
           Op : in  STD_LOGIC_VECTOR(1 downto 0); -- IR12 IR11
           Output : out  STD_LOGIC_VECTOR(15 downto 0));
	end Component;
	
--	Component Mplex16to1 is
--    Port ( Input : in  bit_16;
--           Sel : in  STD_LOGIC_VECTOR(3 downto 0);
--           Output : out  STD_LOGIC);
--	end Component;
--	
--	Component Mplex2to1 is
--    Port ( Input : in  STD_LOGIC_VECTOR(1 downto 0);
--           Output : out  STD_LOGIC;
--           Sel : in  STD_LOGIC);
--	end Component;
--	
--	Component Decoder4to16 is
--    Port ( Sel : in  STD_LOGIC_VECTOR(3 downto 0);
--           Enable : in  STD_LOGIC;
--           decoder_out : out  STD_LOGIC_VECTOR(15 downto 0)
--	 );
--	end Component;

	component Mux_2in is
		 Port ( Input: in STD_LOGIC_VECTOR(1 downto 0);
				  Output: out STD_LOGIC;
				  Sel: in STD_LOGIC
				 );
	end component;
	
	component Mux_4in is
	Port ( Input : in  STD_LOGIC_VECTOR(3 downto 0);
          Sel : in  STD_LOGIC_VECTOR(1 downto 0);
          Output : out  STD_LOGIC);
	end component;

	component Mux_16in is
		 Port ( In0 : in  STD_LOGIC_VECTOR(15 downto 0);
				  Sel : in  STD_LOGIC_VECTOR(3 downto 0);
				  Output : out  STD_LOGIC
				 );
	end component;

	component Shifter_Sel_mplex2to1 is
		 Port ( Decoder_1 : in  STD_LOGIC_VECTOR(15 downto 0);
				  Decoder_2 : in  STD_LOGIC_VECTOR(15 downto 0);
				  Mp2to1_sel : out  STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component Or_tree is
		 Port ( Input : in  STD_LOGIC_VECTOR(15 downto 0);
				  Output : buffer  STD_LOGIC_VECTOR(15 downto 0)
			);
	end Component;
	
	component Barrel_shift is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
			  Cyin: in STD_LOGIC;
           Shifter_Ctrl : in STD_LOGIC_VECTOR(2 downto 0); --IR12 IR11 IR10
			  Output : out STD_LOGIC_VECTOR(15 downto 0);
           Cy : out STD_LOGIC);
	end Component;
	
	Component Mplex4to1 is
    Port ( Input : in  STD_LOGIC_VECTOR(3 downto 0);
           Sel : in  STD_LOGIC_VECTOR(1 downto 0);
           Output : out  STD_LOGIC);
	end Component;
	
	component Mplex16bit_2to1
		Port ( 
			Input_port : in  bit_16_array(1 downto 0);
         Selector_MP : in  STD_LOGIC;
         Output_port : out  bit_16
		);
	end component;
  
  	component Decoder3_8
		port( 
			AddrSD_port : in  STD_LOGIC_VECTOR(2 downto 0);
			Enable_port : in  STD_LOGIC;
			Output_port : out  STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;
	
	component nbit_register
		Port ( 
			enable : in  STD_LOGIC;
         clk : in  STD_LOGIC;
         clr : in  STD_LOGIC; --s� deve ser activado para o PSW e PC
         d : in  bit_16;
         q : out  bit_16
		);
	end component;
	
	component Mplex16bit_8to1
		Port (--Input_port0 : in  STD_LOGIC_VECTOR(7 downto 0);
			Input_port : in  bit_16_array(7 downto 0);
			Selector_MP : in STD_LOGIC_VECTOR(2 downto 0);
			Output_port : out  bit_16
		);
	end component;
	
	component Mplex3bit_2to1
		Port (
			Input_port : in  bit_3_array(1 downto 0);
         Selector_MP : in  STD_LOGIC;
         Output_port : out  bit_3
		);
	end component;
	
	component Sel_andgatesTree 
		port(
			Func : in  STD_LOGIC_VECTOR(5 downto 0);
         Oper : out  STD_LOGIC_VECTOR(3 downto 0);--Vou incluir o bit13, pois � usado no interior da alu.
         LnA : out  STD_LOGIC
		);
	end component;

	component Mplex16bit_4to1 is
		 Port ( Input : in  bit_16_array(3 downto 0);
				  Sel : in  STD_LOGIC_VECTOR(1 downto 0);
				  Output : out  bit_16);
	end component;
	
	component Mplex8bit_2to1 is
    Port ( Input : in  bit_8_array(1 downto 0);
           Sel : in  STD_LOGIC;
           Output : out  std_logic_vector(7 downto 0));
	end component;
	
	component DirZeroFill is
    Port ( Input : in  STD_LOGIC_VECTOR(6 downto 0);
           Output : out  bit_16);
	end component;
	
	component MBR is
    Port ( enable : in  STD_LOGIC;
			  d : in  STD_LOGIC_VECTOR (15 downto 0);
           q : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component InstReg is
	 Port ( Input : in  STD_LOGIC;
           EIR : in  STD_LOGIC;
           Output : out  STD_LOGIC;
           Clk : in  STD_LOGIC);
	end component;

	component ImmZeroFill is
	 Port ( LSB : in  STD_LOGIC_VECTOR(7 downto 0);
           SelImm : in  STD_LOGIC;
           Output : out  bit_16;
           Input : in  STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
	component HiZeroFill is
    Port ( Input : in  STD_LOGIC;
           Output : out  STD_LOGIC);
	end component;
	
	component Control is
	 Port ( 	WL 			: in  STD_LOGIC;
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
				EIR			: out	 STD_LOGIC);
	end component;
	
	component BIU is
	 Port ( Clock : in  STD_LOGIC;
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
           DataIn : out  STD_LOGIC_VECTOR (15 downto 0);
			  
			  --para teste
--			  ALE_flipflop_out : out STD_LOGIC;
			  
			  Addr_out 	: out  STD_LOGIC_VECTOR(14 downto 0));
	end component;
	
	component Latch16bits is
		Port ( --clkReg : in  STD_LOGIC;
				En : in  STD_LOGIC;
				D : in  STD_LOGIC_VECTOR (15 downto 0);
				Q : out  STD_LOGIC_VECTOR (14 downto 0);
				A0: out STD_LOGIC);		 
	end component;
	
	component Data_Processor is
	 Port ( Const : in  STD_LOGIC_VECTOR(7 downto 0);
           OpB : in  bit_16;
           OpA : in  bit_16;
           CYin : in  STD_LOGIC;
           Ctr : in  STD_LOGIC_VECTOR(2 downto 0);
			  Func : in  STD_LOGIC_VECTOR(5 downto 0);--IR10 , 11, 12, 13, 14, 15
           Result : out  bit_16;
           FlagsOut : out  STD_LOGIC_VECTOR(3 downto 0)--P,Z,CyBw,GE
			  );
	end component;
	
	component RegisterFile8x16 is
	 Port ( clock : in  STD_LOGIC;
           addressSD : in  STD_LOGIC_VECTOR(2 downto 0);
           flags : in  STD_LOGIC_VECTOR(3 downto 0); -- 0-Zero 1-Carry 2-GE 3-Parity
           RFC : in  STD_LOGIC_VECTOR (4 downto 0); -- como � que os bits est�o distribuidos? 1-enablers 2-mplexr5 3-mplexr6 4-mplexr7 5-mplexAddrA
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
	end component;
	
--	component Shifter_Sel_mplex2to1 is
--    Port ( Decoder_1 : in  STD_LOGIC_VECTOR(15 downto 0);
--           Decoder_2 : in  STD_LOGIC_VECTOR(15 downto 0);
--           Mp2to1_sel : out  STD_LOGIC_VECTOR(15 downto 0));
--	end component;
	
	component BnB is
    Port ( B_sel : in  STD_LOGIC;
			  B : in  STD_LOGIC_VECTOR(3 downto 0);
           B_negativo : out  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component Block_Mplex16to1 is
	 Port ( A : in  bit_16;
           Mp2to1_in : out  bit_16;
           B_negativo : in  STD_LOGIC_VECTOR(3 downto 0));
	end component;
	
	component Block_Mplex2to1 is
    Port ( Input1 : in  STD_LOGIC_VECTOR(15 downto 0);
			  Input2 : in STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(15 downto 0);
			  Output_Carry: out STD_LOGIC;
           Sel : in  STD_LOGIC_VECTOR(15 downto 0);
			  ir11 : in STD_LOGIC);
	end component;

component Decoder_16out is
    Port ( Enable : in  STD_LOGIC;
			  Sel 	: in  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  STD_LOGIC_VECTOR(15 downto 0)
			 );
end component;

--component BnB is
--    Port ( OpB : in  STD_LOGIC_VECTOR(3 downto 0);
--           IR : in  STD_LOGIC; -- IR(11)
--           R_OpB : out  STD_LOGIC_VECTOR(15 downto 0)
--			 );
--end component;
	
	component Tristate is
    Port ( Input : in  bit_16;
           Enable : in  STD_LOGIC;
           Output : out  bit_16);
	end component;

	component Decoder3bits 
    Port ( S : in  STD_LOGIC_VECTOR (2 downto 0);
           E : in  STD_LOGIC;
           O : out STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component Register16bits
	Port ( D : in  STD_LOGIC_VECTOR (15 downto 0);
          Q : out  STD_LOGIC_VECTOR (15 downto 0);
          En : in  STD_LOGIC;
			 clkReg : in  STD_LOGIC);
	end component;
	
	component Register16bitsCL
	Port ( D : in  STD_LOGIC_VECTOR (15 downto 0);
          Q : out  STD_LOGIC_VECTOR (15 downto 0);
          En : in  STD_LOGIC;
			 clkReg : in  STD_LOGIC;
			 Cl : in STD_LOGIC);
	end component;

	component MUX1x16bits is
    Port ( In0 : in  STD_LOGIC_VECTOR (15 downto 0);
           In1 : in  STD_LOGIC_VECTOR (15 downto 0);
           Sel : in  STD_LOGIC;
           outdata : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	component MUX1x3bits is
    Port ( In0 : in  STD_LOGIC_VECTOR (2 downto 0);
           In1 : in  STD_LOGIC_VECTOR (2 downto 0);
           Sel : in  STD_LOGIC;
           outdata : out  STD_LOGIC_VECTOR (2 downto 0));
	end component;
	
	component MUX3x16bits is
	Generic (
		WIDTH : NATURAL := 16 );
	Port ( Sel : in  STD_LOGIC_VECTOR (2 downto 0);
		In0 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In1 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In2 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In3 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In4 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In5 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In6 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In7 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		outdata : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0));
	end component;
	
	component MUX2x16bits is
	Generic (
		WIDTH : NATURAL := 16 );
	Port ( Sel : in  STD_LOGIC_VECTOR (1 downto 0);
		In0 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In1 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In2 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		In3 : in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
		outdata : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0));
	end component;
	
	component MUX1x8bits is
	 Port ( Sel : in  STD_LOGIC;
	        In0 : in  STD_LOGIC_VECTOR (7 downto 0);
           In1 : in  STD_LOGIC_VECTOR (7 downto 0);
           outdata : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component MUX2x1bit is
    Port ( Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           In0 : in  STD_LOGIC;
           In1 : in  STD_LOGIC;
           In2 : in  STD_LOGIC;
           In3 : in  STD_LOGIC;
           outdata : out  STD_LOGIC);
	end component;
	
	component InstDecode is
    Port (  OpCode 	: in  STD_LOGIC_VECTOR(6 downto 0);
				Inst		: out INST_TYPE;
				FlagUpdate: out STD_LOGIC
			);
	end component;
	
	component MUX4x1bit is
	Port ( Sel : in  STD_LOGIC_VECTOR (3 downto 0);
			 Mux_In : in  STD_LOGIC_VECTOR (15 downto 0);
			 outdata : out  STD_LOGIC);
end component;

	component MUX1x1bit is
	Port ( Sel : in  STD_LOGIC;
			 In0 : in  STD_LOGIC;
		    In1 : in  STD_LOGIC;
			 outdata : out  STD_LOGIC);
end component;

	component out_MUXs_Sel is
	 Port ( Decoder_1 : in  STD_LOGIC_VECTOR(15 downto 0);
			  Decoder_2 : in  STD_LOGIC_VECTOR(15 downto 0);
			  selector : out  STD_LOGIC_VECTOR(15 downto 0));
end component;

	component Decoder4bits is
    Port ( E : in  STD_LOGIC;
	        S : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0));
end component;


	component Block_MUX1x1bit is
    Port ( Sel : in  STD_LOGIC_VECTOR(15 downto 0);
			  in_block_0 : in  STD_LOGIC_VECTOR(15 downto 0);
			  in_block_1 : in STD_LOGIC;
           out_block : out  STD_LOGIC_VECTOR(15 downto 0));
end component;
	
	component Block_MUX4x16bits is
	 Port ( Sel : in  STD_LOGIC_VECTOR(3 downto 0);
			  A : in  STD_LOGIC_VECTOR(15 downto 0);
           out_Block: out  STD_LOGIC_VECTOR(15 downto 0)); 
end component;

--  type <new_type> is
--    record
--        <type_name>        : std_logic_vector( 7 downto 0);
--        <type_name>        : std_logic;
--    end record;
--
---- Declare constants
--
--  constant unit_delay : time := 1 ns; --valor default
--  constant <constant_name>		: integer := <value>;
-- 
---- Declare functions and procedure
--
--  function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
--  procedure <procedure_name>	(<type_declaration> <constant_name>	: in <type_declaration>);

end pds16_types;


package body pds16_types is





---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;
--
--
---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;
--
---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end pds16_types;
