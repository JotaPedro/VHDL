----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  RegisterFileBS - Descrição Estrutural

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pds16_types.ALL;


entity RegisterFileBS is
    Port ( clock : in  STD_LOGIC;
			  RFC : in  STD_LOGIC_VECTOR (13 downto 0);
			  destData : in  STD_LOGIC_VECTOR (15 downto 0);
           flagsIn : in  STD_LOGIC_VECTOR (5 downto 0);
           AddrSD : in  STD_LOGIC_VECTOR (2 downto 0);
           AddrA : in  STD_LOGIC_VECTOR (2 downto 0);
           AddrB : in  STD_LOGIC_VECTOR (2 downto 0);
           RES : in  STD_LOGIC;					--SINAL DE SAIDA DO FF DE RESET
			  --interrupt : in  STD_LOGIC;
           flagsOut : out  STD_LOGIC_VECTOR (5 downto 0);
           PCout : out  STD_LOGIC_VECTOR (15 downto 0);
           OpA : out  STD_LOGIC_VECTOR (15 downto 0);
           OpB : out  STD_LOGIC_VECTOR (15 downto 0);
           Sc : out  STD_LOGIC_VECTOR (15 downto 0));
end RegisterFileBS;

architecture Structural of RegisterFileBS is

	Signal en_decodR0_R5: STD_LOGIC;
	Signal outDecodR0_R5: STD_LOGIC_VECTOR(7 downto 0);
	Signal en_decodR0i_R5i: STD_LOGIC;
	Signal outDecodR0i_R5i: STD_LOGIC_VECTOR(7 downto 0);
	Signal outDecodR5_R5i: STD_LOGIC_VECTOR(1 downto 0);
	Signal outDecodR6_R7: STD_LOGIC_VECTOR(7 downto 0);
	Signal ER: STD_LOGIC_VECTOR(7 downto 0);
	Signal ERi: STD_LOGIC_VECTOR(5 downto 0);
	
	Signal R0_5dataIn: bit_16_array(5 downto 0);
	Signal R5D: STD_LOGIC_VECTOR(15 downto 0);
	Signal In1R6dataIn: STD_LOGIC_VECTOR(15 downto 0);
	Signal In3R6dataIn: STD_LOGIC_VECTOR(15 downto 0);
	Signal R6D: STD_LOGIC_VECTOR(15 downto 0);
	Signal IncPC: STD_LOGIC_VECTOR(15 downto 0);
	Signal int_vec: STD_LOGIC_VECTOR(15 downto 0);
	Signal R7D: STD_LOGIC_VECTOR(15 downto 0);
	Signal R0_5Q: bit_16_array(5 downto 0);		--array 6x16
	Signal R6Q: STD_LOGIC_VECTOR(15 downto 0);
	Signal R7Q: STD_LOGIC_VECTOR(15 downto 0);
	Signal R0i_5idataIn: bit_16_array(5 downto 0);	
	Signal R0iD: STD_LOGIC_VECTOR(15 downto 0);
	Signal R5iD: STD_LOGIC_VECTOR(15 downto 0);
	Signal R0i_5iQ: bit_16_array(5 downto 0);		--array 6x16
		
	Signal SelOpA: STD_LOGIC_VECTOR(2 downto 0);
	Signal Sel_outMuxA: STD_LOGIC_VECTOR(3 downto 0);
	Signal Sel_outMuxB: STD_LOGIC_VECTOR(3 downto 0);
	Signal Sel_outMuxSC: STD_LOGIC_VECTOR(3 downto 0);

	
begin
	--------------------------
	-- Registers Enable
	--------------------------
	en_decodR0_R5 <= RFC(0) AND (NOT R6Q(5));	--en_dest_data AND (NOT BS)
	
	decodR0_R5: component Decoder3bits port map(
		E => en_decodR0_R5,
		S => AddrSD,
		O => outDecodR0_R5);
	
	en_decodR0i_R5i <= RFC(0) AND R6Q(5);		--en_dest_data AND BS
	
	decodR0i_R5i: component Decoder3bits port map(
		E => en_decodR0i_R5i,
		S => AddrSD,
		O => outDecodR0i_R5i);
	
	decodR5_R5i: component Decoder1bit port map(
		E => RFC(1),			--en_link
		S => R6Q(5),			--BS
		O => outDecodR5_R5i);
	
	decodR6_R7: component Decoder3bits port map(
		E => RFC(0),			--en_dest_data
		S => AddrSD,
		O => outDecodR6_R7);
		
	ER(0) <= outDecodR0_R5(0);
	ER(1) <= outDecodR0_R5(1);
	ER(2) <= outDecodR0_R5(2);
	ER(3) <= outDecodR0_R5(3);
	ER(4) <= outDecodR0_R5(4);
	ER(5) <= outDecodR0_R5(5) OR outDecodR5_R5i(0);
	ER(6) <= outDecodR6_R7(0) OR RFC(13) OR RFC(2);	--en_psw
	ER(7) <= outDecodR6_R7(1) OR RFC(13) OR RFC(3);	--en_pc
	ERi(0) <= RFC(13) OR outDecodR0i_R5i(0);
	ERi(1) <= outDecodR0i_R5i(1);
	ERi(2) <= outDecodR0i_R5i(2);
	ERi(3) <= outDecodR0i_R5i(3);
	ERi(4) <= outDecodR0i_R5i(4);
	ERi(5) <= outDecodR0i_R5i(5) OR outDecodR5_R5i(1) OR RFC(13);
	
	
	--------------------------
	-- Aplication Bank
	--------------------------
	
	-- Registos R0 --> R5
	R5dataIn: component MUX1x16bits port map(
		Sel => RFC(5),		--SLINK
		In0 => destData,
		In1 => R7Q,
		outdata => R5D);
	
	R0_5dataIn (5 downto 0) <= (5 => R5D, 4 => destData, 3 => destData, 2 => destData, 1 => destData, 0 => destData);
	
	R0_R5: component RegisterBank0_5 port map(
		clk => clock,
		enable => ER(5 downto 0),
		dataIn => R0_5dataIn,
--		dataIn => R5D & destData & destData & destData & destData & destData,
		dataOut => R0_5Q);
	
	-- Registo R6
	In1R6dataIn(15 downto 0) <= "0000000000" & flagsIn;
	In3R6dataIn(15 downto 0) <= R6Q AND ("00000000000" & RFC(12) & "00000"); --NAO É ISTO!!!!
	
	R6dataIn: component MUX2x16bits port map(
		Sel => RFC(7 downto 6),		--SPSW
		In0 => destData,
		In1 => In1R6dataIn,
		In2 => R0i_5iQ(0),
		In3 => In3R6dataIn,
		outdata => R6D);
	
	R6: component Register16bitsCL port map(
		clkReg => clock,
		En => ER(6),
		Cl => RES,
		D => R6D,
      Q => R6Q);
		
	-- Registo R7
	Somador: component Alu_aritmetico port map(
		Op => "00", --soma
		A => R7Q,
	   B => "0000000000000010", 
	   Cin => '0',
	   Result => IncPC,
	   Flags_out => open);
		
	R7dataIn: component MUX2x16bits port map(
		Sel => RFC(9 downto 8),		--SPSW
		In0 => destData,
		In1 => int_vec,
		In2 => IncPC,
		In3 => R0i_5iQ(5),
		outdata => R7D);
		
	R7: component Register16bitsCL port map(
		clkReg => clock,
		En => ER(7),
		Cl => RES,
		D => R7D,
      Q => R7Q);
		
	--------------------------
	-- Interrupt Bank
	--------------------------
	R0idataIn: component MUX1x16bits port map(
		Sel => RFC(10),		--SR0i
		In0 => destData,
		In1 => R6Q,
		outdata => R0iD);
		
	R5idataIn: component MUX1x16bits port map(
		Sel => RFC(11),		--SR5i
		In0 => destData,
		In1 => R7Q,
		outdata => R5iD);	


	R0i_5idataIn (5 downto 0) <= (5 => R5iD, 4 => destData, 3 => destData, 2 => destData, 1 => destData, 0 => R0iD);

	R0i_R5i: component RegisterBank0_5 port map(
		clk => clock,
		enable => ERi(5 downto 0),
--		dataIn => R5iD & destData & destData & destData & destData & R0iD,
		dataIn => R0i_5idataIn,
		dataOut => R0i_5iQ);

		
	--------------------------
	-- OutData
	--------------------------

	-- OpA
	mux_OutMuxA: component MUX1x3bits port map(
		Sel => RFC(4),
		In0 => AddrA,
		In1 => AddrSD,
		outdata => SelOpA);
	
	Sel_outMuxA <= R6Q(5) & SelOpA;
	
	outMuxA: component MUX4x16bits port map(
		Sel => Sel_outMuxA,
		In0 => R0_5Q(0),
		In1 => R0_5Q(1),
		In2 => R0_5Q(2),
		In3 => R0_5Q(3),
		In4 => R0_5Q(4),
		In5 => R0_5Q(5),
		In6 => R6Q,
		In7 => R7Q,
		In8 => R0i_5iQ(0),
		In9 => R0i_5iQ(1),
		In10 => R0i_5iQ(2),
		In11 => R0i_5iQ(3),
		In12 => R0i_5iQ(4),
		In13 => R0i_5iQ(5),
		In14 => R6Q,
		In15 => R7Q,
		outdata => OpA);
	
	-- OpB
	Sel_outMuxB <= R6Q(5) & AddrB;
	
	outMuxB: component MUX4x16bits port map(
		Sel => Sel_outMuxB,
		In0 => R0_5Q(0),
		In1 => R0_5Q(1),
		In2 => R0_5Q(2),
		In3 => R0_5Q(3),
		In4 => R0_5Q(4),
		In5 => R0_5Q(5),
		In6 => R6Q,
		In7 => R7Q,
		In8 => R0i_5iQ(0),
		In9 => R0i_5iQ(1),
		In10 => R0i_5iQ(2),
		In11 => R0i_5iQ(3),
		In12 => R0i_5iQ(4),
		In13 => R0i_5iQ(5),
		In14 => R6Q,
		In15 => R7Q,
		outdata => OpB);
		
	-- Sc
	Sel_outMuxSC <= R6Q(5) & AddrSD;
	
	outMuxSC: component MUX4x16bits port map(
		Sel => Sel_outMuxSC,
		In0 => R0_5Q(0),
		In1 => R0_5Q(1),
		In2 => R0_5Q(2),
		In3 => R0_5Q(3),
		In4 => R0_5Q(4),
		In5 => R0_5Q(5),
		In6 => R6Q,
		In7 => R7Q,
		In8 => R0i_5iQ(0),
		In9 => R0i_5iQ(1),
		In10 => R0i_5iQ(2),
		In11 => R0i_5iQ(3),
		In12 => R0i_5iQ(4),
		In13 => R0i_5iQ(5),
		In14 => R6Q,
		In15 => R7Q,
		outdata => Sc);
	
	flagsOut <= R6Q(5 downto 0);
	PCout <= R7Q;
	
end Structural;

