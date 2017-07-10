--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:42:10 05/29/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/Alfa_pds16fpga.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TB_Data_Processor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
use work.pds16_types.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Alfa_pds16fpga IS
END Alfa_pds16fpga;
 
ARCHITECTURE behavior OF Alfa_pds16fpga IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Data_Processor
    PORT(
         Const : IN  std_logic_vector(7 downto 0);
         OpB : IN  std_logic_vector(15 downto 0);
         OpA : IN  std_logic_vector(15 downto 0);
         CYin : IN  std_logic;
         Ctr : IN  std_logic_vector(2 downto 0);
         Func : IN  std_logic_vector(5 downto 0);
         Result : OUT  std_logic_vector(15 downto 0);
         FlagsOut : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT RegisterFile8x16
    Port ( clock : in  STD_LOGIC;
           CL : in  STD_LOGIC;
           RFC : in  STD_LOGIC_VECTOR (4 downto 0);				
           AddrA : in  STD_LOGIC_VECTOR (2 downto 0);				--RFC(0)-Enable Decoder
           AddrB : in  STD_LOGIC_VECTOR (2 downto 0);				--RFC(1)-OR Reg R5 / SelMuxR5
           AddrSD : in  STD_LOGIC_VECTOR (2 downto 0);			--RFC(2)-OR Reg R6
           DestData : in  STD_LOGIC_VECTOR (15 downto 0);		--RFC(3)-OR Reg R7
           flagsIN : in  STD_LOGIC_VECTOR (3 downto 0);			--RFC(4)-MUX do MUXaddrA
           OpA : out  STD_LOGIC_VECTOR (15 downto 0);
           OpB : out  STD_LOGIC_VECTOR (15 downto 0);
           SC : out  STD_LOGIC_VECTOR (15 downto 0);
           flagsOUT : out  STD_LOGIC_VECTOR (4 downto 0);
           PCout : out  STD_LOGIC_VECTOR (15 downto 0)
		    );
	end COMPONENT;
	
	COMPONENT Mplex16bit_4to1
    Port ( Input : in  bit_16_array(3 downto 0);
           Sel : in  STD_LOGIC_VECTOR(1 downto 0);
           Output : out  bit_16);
	end COMPONENT;
	
	COMPONENT Mplex8bit_2to1
    Port ( Input : in  bit_8_array(1 downto 0);
           Sel : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(7 downto 0));
	end COMPONENT;
	
	COMPONENT HiZeroFill
    Port ( Input : in  STD_LOGIC_VECTOR(7 downto 0);
			  A0 : in STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(15 downto 0));
	end COMPONENT;

	COMPONENT ImmZeroFill
    Port ( LSB : in  STD_LOGIC_VECTOR(7 downto 0);
           SelImm : in  STD_LOGIC;
           Output : out  bit_16;
           Input : in  STD_LOGIC_VECTOR(7 downto 0)
	 );
	end COMPONENT;

	COMPONENT Register16bits
	Port ( D : in  STD_LOGIC_VECTOR (15 downto 0);
          Q : out  STD_LOGIC_VECTOR (15 downto 0);
          En : in  STD_LOGIC;
			 clkReg : in  STD_LOGIC);
	end COMPONENT;
	
	------------------------------------------------------------------------
	--Clocks in here
	constant clk_period : time := 10 ns;
	Signal clk1 : std_logic := '0';
	Signal clk2 : std_logic := '0';
	------------------------------------------------------------------------
	--Variables here:
	--Control
	Signal SelData : std_logic_vector(1 downto 0)  := (others => '0');
	Signal RFC 	   : std_logic_vector(4 downto 0)  := (others => '0');
	Signal RES	   : std_logic							  := '0';
	Signal ALUC    : std_logic_vector(2 downto 0)  := (others => '0');
	Signal Sel_Imm : std_logic							  := '0';
	Signal EIR	   : std_logic							  := '0';
	Signal A0	   : std_logic							  := '0';
	
	--Inputs
	Signal DataIn  : std_logic_vector(15 downto 0) := (others => '0');
	
	--Outputs
	Signal DataOut : std_logic_vector(15 downto 0) := (others => '0');
	Signal PCOut 	: std_logic_vector(15 downto 0) := (others => '0');
	Signal flagsOut_RF: std_logic_vector(4 downto 0) := (others => '0');
	Signal flagsOut_DP: std_logic_vector(3 downto 0) := (others => '0');
	
	--Signals to connect blocks
	Signal mplex_hi_low_Output : std_logic_vector(7 downto 0)  := (others => '0');
	Signal HiZeroFill_Output   : std_logic_vector(15 downto 0) := (others => '0');
	Signal mplex_sel_Output    : std_logic_vector(15 downto 0) := (others => '0');
	Signal IR_Data			      : std_logic_vector(15 downto 0) := (others => '0');
	Signal ImmZeroFill_Output  : std_logic_vector(15 downto 0) := (others => '0');
	Signal OpA					   : std_logic_vector(15 downto 0) := (others => '0');
	Signal OpB  					: std_logic_vector(15 downto 0) := (others => '0');
	Signal Result_DP				: std_logic_vector(15 downto 0) := (others => '0');
	
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)

	mplex_hi_low: Mplex8bit_2to1
    Port map( 
			  Input(0) 	=> DataIn(15 downto 8),
           Input(1) 	=> DataIn(7 downto 0),
			  Sel 		=> A0,
           Output 	=> mplex_hi_low_Output
			  );
	
	Hi_ZeroFill: HiZeroFill
    Port map( 
			  Input 	=> mplex_hi_low_Output,
			  A0 		=> A0,
           Output => HiZeroFill_Output
			  );

	mplex_sel: Mplex16bit_4to1
    Port map( 
			  Input(0) => ImmZeroFill_Output,
			  Input(1) => DataIn,
			  Input(2) => HiZeroFill_Output,
			  Input(3) => Result_DP,
           Sel		  => SelData,	
           Output   => mplex_sel_Output
			  );
	
	instreg: Register16bits
	 Port map( 
			 D 		=> DataIn,
          Q 		=> IR_Data,
          En		=> EIR,
			 clkReg  => clk1
			 );

	Imm_ZeroFill: ImmZeroFill
    Port map( 
			  LSB 		=> DataOut(7 downto 0),
           SelImm 	=> Sel_Imm,
           Output 	=> ImmZeroFill_Output,
           Input 		=> IR_Data(10 downto 3)
	);
	 
	 RegisterFile: RegisterFile8x16
    Port map( 
	 
--	 clock : in  STD_LOGIC;
--           CL : in  STD_LOGIC;
--           RFC : in  STD_LOGIC_VECTOR (4 downto 0);				
--           AddrA : in  STD_LOGIC_VECTOR (2 downto 0);				--RFC(0)-Enable Decoder
--           AddrB : in  STD_LOGIC_VECTOR (2 downto 0);				--RFC(1)-OR Reg R5 / SelMuxR5
--           AddrSD : in  STD_LOGIC_VECTOR (2 downto 0);			--RFC(2)-OR Reg R6
--           DestData : in  STD_LOGIC_VECTOR (15 downto 0);		--RFC(3)-OR Reg R7
--           flagsIN : in  STD_LOGIC_VECTOR (3 downto 0);			--RFC(4)-MUX do MUXaddrA
--           OpA : out  STD_LOGIC_VECTOR (15 downto 0);
--           OpB : out  STD_LOGIC_VECTOR (15 downto 0);
--           SC : out  STD_LOGIC_VECTOR (15 downto 0);
--           flagsOUT : out  STD_LOGIC_VECTOR (4 downto 0);
--           PCout : out  STD_LOGIC_VECTOR (15 downto 0)
	 
	 
			 DestData 	=> mplex_sel_Output,
          AddrA 		=> IR_Data(5 downto 3),	--RFC(0)-Enable Decoder
          AddrB 		=> IR_Data(8 downto 6),	--RFC(1)-OR Reg R5 / SelMuxR5
          AddrSD 		=> IR_Data(2 downto 0),	--RFC(2)-OR Reg R6
          clock 		=> clk2,						--RFC(3)-OR Reg R7
          RFC 			=> RFC,						--RFC(4)-MUX do MUXaddrA
          flagsIN 	=> flagsOut_DP,
          CL 			=> RES,
          OpA 			=> OpA,
          OpB 			=> OpB,
          SC 			=> DataOut,
          flagsOUT 	=> flagsOut_RF,
          PCout 		=> PCOut
			);
	
	 Dataprocessor: Data_Processor
    PORT MAP(
         Const 	=> IR_Data(10 downto 3), --const4 = IR_Data(9 downto 6), o resto é para o offset dos jumps
         OpB 		=> OpB,
         OpA 		=> OpA,
         CYin 		=> flagsOut_RF(1),
         Ctr 		=> ALUC,
         Func 		=> IR_Data(15 downto 10),
         Result 	=> Result_DP,
         FlagsOut => flagsOut_DP
        );
			 
   -- Clock process definitions
   clk_process :process
   begin 
		clk1 <= '0';
		clk2 <= '1';
		wait for clk_period/2;
		clk1 <= '1';
		clk2 <= '0';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
   --para simular o bloco de controlo temos de criar pseudo estados
	--do processador, i.e., os estados de fetch e execute nesta versão simplista
	--do pds16fpga.
	--ordem do estados: Fetch addr, fetch instruction, fetch decode, execute.
	
	--NOTA: por enquanto estamos a ignorar o fetch addr pois não existe memória
	
	--LDI r1,#5
		--fetch instruction:
			DataIn <= "0000000000101001";
			--control signals
			EIR 		<= '1';
			--control signals not used
			--EIR 		<= '1';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			Sel_Imm 	<= '0';
			SelData  <= "00";
			RFC		<= "00000";
		wait for clk_period*2;
		--fetch decode/execute:
			Sel_Imm 	<= '0';
			SelData  <= "00";
			RFC		<= "00001"; --decoder enabled
			--control signals not used
			EIR 		<= '0';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			--Sel_Imm 	<= '0';
			--SelData  <= "00";
			--RFC		<= "00000";
		wait for clk_period*2;
		
	--LDIH r1,#5
		--fetch instruction:
			DataIn <= "0000100000101001";
			--control signals
			EIR 		<= '1';
			--control signals not used
			--EIR 		<= '1';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			Sel_Imm 	<= '0';
			SelData  <= "00";
			RFC		<= "00000";
		wait for clk_period*2;
		--fetch decode/execute:
			Sel_Imm 	<= '1';
			SelData  <= "00";
			RFC		<= "00001"; --decoder enabled
			--control signals not used
			EIR 		<= '0';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			--Sel_Imm 	<= '0';
			--SelData  <= "00";
			--RFC		<= "00000";
		wait for clk_period*2;

	--LDI r0,#7
		--fetch instruction:
			DataIn <= "0000000000111000";
			--control signals
			EIR 		<= '1';
			--control signals not used
			--EIR 		<= '1';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			Sel_Imm 	<= '0';
			SelData  <= "00";
			RFC		<= "00000";
		wait for clk_period*2;
		--fetch decode/execute:
			Sel_Imm 	<= '0';
			SelData  <= "00";
			RFC		<= "00001"; --decoder enabled
			--control signals not used
			EIR 		<= '0';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			--Sel_Imm 	<= '0';
			--SelData  <= "00";
			--RFC		<= "00000";
		wait for clk_period*2;
		
	--LDIH r0,#7
		--fetch instruction:
			DataIn <= "0000100000111000";
			--control signals
			EIR 		<= '1';
			--control signals not used
			--EIR 		<= '1';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			Sel_Imm 	<= '0';
			SelData  <= "00";
			RFC		<= "00000";
		wait for clk_period*2;
		--fetch decode/execute:
			Sel_Imm 	<= '1';
			SelData  <= "00";
			RFC		<= "00001"; --decoder enabled
			--control signals not used
			EIR 		<= '0';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			--Sel_Imm 	<= '0';
			--SelData  <= "00";
			--RFC		<= "00000";
		wait for clk_period*2;
			
	--ADD r2,r0,r1
		--fetch instruction:
			DataIn <= "1000000001000010";
			--control signals
			EIR 		<= '1';
			--control signals not used
			--EIR 		<= '1';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			Sel_Imm 	<= '0';
			SelData  <= "00";
			RFC		<= "00000";
		wait for clk_period*2;
		--fetch decode/execute::
			ALUC		<= "011";
			SelData  <= "11";
			RFC		<= "00001"; --decoder enabled
			--control signals not used
			EIR 		<= '0';
			RES		<= '0';
			--ALUC		<= "000";
			A0			<= '0';
			Sel_Imm 	<= '0';
			--SelData  <= "00";
			--RFC		<= "00000";
		wait for clk_period*2;
	
	--SHL r2,r2,#1 com introdução de sin
		--fetch instruction:
			DataIn <= "1110010001010011";
			--control signals
			EIR 		<= '1';
			--control signals not used
			--EIR 		<= '1';
			RES		<= '0';
			ALUC		<= "000";
			A0			<= '0';
			Sel_Imm 	<= '0';
			SelData  <= "00";
			RFC		<= "00000";
		wait for clk_period*2;
		--fetch decode/execute:
			ALUC		<= "001";
			SelData  <= "11";
			RFC		<= "00001"; --decoder enabled
			--control signals not used
			EIR 		<= '0';
			RES		<= '0';
			--ALUC		<= "000";
			A0			<= '0';
			Sel_Imm 	<= '0';
			--SelData  <= "00";
			--RFC		<= "00000";
		wait for clk_period*2;
		
		
		
		
			--control signals not used
			--RES			<= '0';
			--ALUC		<= "000";
			--A0			<= '0';
			--EIR 		<= '1';
			--Sel_Imm 	<= '0';
			--SelData  	<= "00";
			--RFC			<= "00001"; --decoder enabled
		
      wait;
   end process;

END;
