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

	
	Component DFlipFlop is
    Port ( D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Clk : in  STD_LOGIC;
           CL : in  STD_LOGIC);
	end Component;
	
	Component FullAdder is
    Port ( Ax : in  STD_LOGIC;
           Bx : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sx : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
			  Op : in STD_LOGIC);
	end Component;
	
	Component Adder16bit is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           Cin : in  STD_LOGIC;
           Result : out  STD_LOGIC_VECTOR(15 downto 0);
           Cout : out  STD_LOGIC);
	end Component;
	
	Component Alu_aritmetico is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           Cin : in  STD_LOGIC;
           Result : out  STD_LOGIC_VECTOR(15 downto 0);
           Flags_out : out  STD_LOGIC_VECTOR(1 downto 0);
			  Op : in STD_LOGIC);
	end Component;
	
	Component Mplex16bit_5to1 is
    Port ( Input_port : in  bit_16_array(4 downto 0);
			  Selector_MP: in STD_LOGIC_VECTOR(2 downto 0);
           Output_port : out  bit_16
			 );
	end Component;
	
	Component SigExt is
    Port ( Const8x2 : in  STD_LOGIC_VECTOR(7 downto 0);
           Output16bit : out  bit_16);
	end Component;
	
	Component Zero_Fill is
    Port ( Const4bit : in  STD_LOGIC_VECTOR(3 downto 0);
           Output16bit : out  bit_16);
	end Component;
	
	Component Alu is
    Port ( Oper : in  STD_LOGIC_VECTOR(3 downto 0); --IR10 , 11, 12, 13
           LnA : in  STD_LOGIC; --IR14
           B : in  bit_16; 
           A : in  bit_16; 
           CyBw : in  STD_LOGIC;
           R : out  bit_16;
           flags : out  STD_LOGIC_VECTOR(3 downto 0) --P,Z,CyBw,GE
		);
	end Component;
		
	Component Alu_logico is
    Port ( Input_B : in  bit_16;
           Input_A : in  bit_16;
           Op : in  STD_LOGIC_VECTOR(1 downto 0);
           Output : out  bit_16);
	end Component;
	
	Component Mplex16to1 is
    Port ( Input : in  bit_16;
           Sel : in  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  STD_LOGIC);
	end Component;
	
	Component Mplex2to1 is
    Port ( Input : in  STD_LOGIC_VECTOR(1 downto 0);
           Output : out  STD_LOGIC;
           Sel : in  STD_LOGIC);
	end Component;
	
	Component Decoder4to16 is
    Port ( Sel : in  STD_LOGIC_VECTOR(3 downto 0);
           Enable : in  STD_LOGIC;
           decoder_out : out  STD_LOGIC_VECTOR(15 downto 0)
	 );
	end Component;
	
	Component Or_tree is
    Port ( Input : in  STD_LOGIC_VECTOR(15 downto 0);
           Output : inout  STD_LOGIC_VECTOR(15 downto 0);
			  enable : in STD_LOGIC
		);
	end Component;
	
	Component Barrel_shift is
    Port ( A : in  bit_16;
           B : inout  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  bit_16;
           Ctl_3bit : in  STD_LOGIC_VECTOR(2 downto 0); --IR10 , 11, 12
           Cy : out  STD_LOGIC);
	end Component;
	
	Component Mplex4to1 is
    Port ( Input : in  STD_LOGIC_VECTOR(3 downto 0);
           Sel : in  STD_LOGIC;
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
         clr : in  STD_LOGIC; --só deve ser activado para o PSW e PC
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
         Oper : out  STD_LOGIC_VECTOR(3 downto 0);--Vou incluir o bit13, pois é usado no interior da alu.
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
           Output : out  bit_8);
	end component;
	
	component DirZeroFill is
    Port ( Input : in  STD_LOGIC_VECTOR(6 downto 0);
           Output : out  bit_16);
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
