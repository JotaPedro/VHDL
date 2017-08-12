----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:38:23 04/30/2017 
-- Design Name: 
-- Module Name:    RegisterFile8x16 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
use work.pds16_types.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile8x16 is
    Port ( clock : in  STD_LOGIC;
           CL : in  STD_LOGIC;
           RFC : in  STD_LOGIC_VECTOR (5 downto 0);				
           AddrA : in  STD_LOGIC_VECTOR (2 downto 0);				--RFC(0)-Enable Decoder
           AddrB : in  STD_LOGIC_VECTOR (2 downto 0);				--RFC(1)-OR Reg R5 / SelMuxR5
           AddrSD : in  STD_LOGIC_VECTOR (2 downto 0);			--RFC(2)-OR Reg R6
           DestData : in  STD_LOGIC_VECTOR (15 downto 0);		--RFC(3)-OR Reg R7
           flagsIN : in  STD_LOGIC_VECTOR (3 downto 0);			--RFC(4)-MUX do MUXaddrA
           OpA : out  STD_LOGIC_VECTOR (15 downto 0);				--RFC(5)-enable Reg R7(para os jumps)
           OpB : out  STD_LOGIC_VECTOR (15 downto 0);
           SC : out  STD_LOGIC_VECTOR (15 downto 0);
           flagsOUT : out  STD_LOGIC_VECTOR (4 downto 0);
           PCout : out  STD_LOGIC_VECTOR (15 downto 0));
end RegisterFile8x16;

architecture Structural of RegisterFile8x16 is
	
	signal R0Q: STD_LOGIC_VECTOR (15 downto 0);
	signal R1Q: STD_LOGIC_VECTOR (15 downto 0);
	signal R2Q: STD_LOGIC_VECTOR (15 downto 0);
	signal R3Q: STD_LOGIC_VECTOR (15 downto 0);
	signal R4Q: STD_LOGIC_VECTOR (15 downto 0);
	signal R5Q: STD_LOGIC_VECTOR (15 downto 0);
	signal R6Q: STD_LOGIC_VECTOR (15 downto 0);
	signal R7Q: STD_LOGIC_VECTOR (15 downto 0);
	signal ER: STD_LOGIC_VECTOR (7 downto 0);			
	signal R5Data: STD_LOGIC_VECTOR (15 downto 0);
	signal R6Data: STD_LOGIC_VECTOR (15 downto 0);	
	signal R7Data: STD_LOGIC_VECTOR (15 downto 0);	
	signal SelOpA: STD_LOGIC_VECTOR (2 downto 0);
	signal ELink: STD_LOGIC;
	signal EPSW: STD_LOGIC;
	signal EPC: STD_LOGIC;
	signal IncPC: STD_LOGIC_VECTOR (15 downto 0);
	signal In1MuxR6: STD_LOGIC_VECTOR (15 downto 0);

begin

	--------------------------
	-- Decoder
	--------------------------
	decod: component Decoder3bits port map(
		E => RFC(0),
		S => AddrSD,
      O => ER);
		
	--------------------------
	-- Registos	R0->4
	--------------------------
	R0: component Register16bits port map(
		clkReg => clock,
		En => ER(0),
		D => DestData,
      Q => R0Q);
      
	R1: component Register16bits port map(
		clkReg => clock,
		En => ER(1),
		D => DestData,
      Q => R1Q);
		
	R2: component Register16bits port map(
		clkReg => clock,
		En => ER(2),
		D => DestData,
      Q => R2Q);
      
	R3: component Register16bits port map(
		clkReg => clock,
		En => ER(3),
		D => DestData,
      Q => R3Q);

	R4: component Register16bits port map(
		clkReg => clock,
		En => ER(4),
		D => DestData,
      Q => R4Q);
	
	--------------------------
	-- Registo R5 => LINK
	--------------------------
	muxR5: component MUX1x16bits port map(
		Sel => RFC(1),
		In0 => DestData,
      In1 => R7Q,
      outdata => R5Data);	

	ELink <= ER(5) OR RFC(1);

	R5: component Register16bits port map(
		clkReg => clock,
		En => ELink,
		D => R5Data,
      Q => R5Q);
      
	--------------------------
	-- Registo R6 => PSW
	--------------------------
	In1MuxR6(15 downto 0) <= "000000000000" & flagsIN;

	muxR6: component MUX1x16bits port map(
		Sel => RFC(2),
		In0 => DestData,
      In1 => In1MuxR6,
      outdata => R6Data);

	EPSW <= ER(6) OR RFC(2);

	R6: component Register16bitsCL port map(
		clkReg => clock,
		En => EPSW,
		Cl => CL,
		D => R6Data,
      Q => R6Q);
      
		
		
	--------------------------
	-- Registo R7 => PC
	--------------------------
	-----------------SOMADOR-----------------
	Somador: component Alu_aritmetico port map(
		Op => '0', --soma
		A => R7Q,
	   B => "0000000000000010", 
	   Cin => '0',
	   Result => IncPC,
	   Flags_out => open);

	muxR7: component MUX1x16bits port map(
		Sel => RFC(3),
		In0 => DestData,
      In1 => IncPC,	
      outdata => R7Data);

	EPC <= ER(7) OR RFC(3) OR RFC(5);--adicionei o RFC(5) para conseguir fazer as instruções de jumps (fazer a introdução no R7 quando a instrução não usa o R7 como registo de soma com o offset)
	
	R7: component Register16bitsCL port map(
		clkReg => clock,  
		En => EPC,
		Cl => CL,
		D => R7Data,
      Q => R7Q);
 
	--------------------------
	-- Definicao das saidas
	--------------------------
	--	Multiplexer do porto de saida A
	muxMuxA: component MUX1x3bits port map(
		Sel => RFC(4),
		In0 => AddrA,
      In1 => AddrSD,
      outdata => SelOpA);

	muxA: component MUX3x16bits port map(
		Sel => SelOpA,
		In0 => R0Q,
      In1 => R1Q,
		In2 => R2Q,
		In3 => R3Q,
		In4 => R4Q,
		In5 => R5Q,
		In6 => R6Q,
		In7 => R7Q,
      outdata => OpA);

	muxB: component MUX3x16bits port map(
      Sel => AddrB,
		In0 => R0Q,
      In1 => R1Q,
		In2 => R2Q,
		In3 => R3Q,
		In4 => R4Q,
		In5 => R5Q,
		In6 => R6Q,
		In7 => R7Q,
      outdata => OpB);
		
	muxSC: component MUX3x16bits port map(
      Sel => AddrSD,
		In0 => R0Q,
      In1 => R1Q,
		In2 => R2Q,
		In3 => R3Q,
		In4 => R4Q,
		In5 => R5Q,
		In6 => R6Q,
		In7 => R7Q,
      outdata => SC);

	-- 
	flagsOUT <= R6Q(4 downto 0);
	
	-- 
	PCout <= R7Q;
		
end Structural;

