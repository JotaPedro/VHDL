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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile8x16 is
    Port ( DestData : in  STD_LOGIC_VECTOR (15 downto 0);
           AddrA : in  STD_LOGIC_VECTOR (2 downto 0);				--RFC(0)-Enable Decoder
           AddrB : in  STD_LOGIC_VECTOR (2 downto 0);				--RFC(1)-OR Reg R5 / SelMuxR5
           AddrSD : in  STD_LOGIC_VECTOR (2 downto 0);			--RFC(2)-OR Reg R6
           clock : in  STD_LOGIC;										--RFC(3)-OR Reg R7
           RFC : in  STD_LOGIC_VECTOR (4 downto 0);				--RFC(4)-MUX do MUXaddrA
           flagsIN : in  STD_LOGIC_VECTOR (3 downto 0);
           CL : in  STD_LOGIC;
           OpA : out  STD_LOGIC_VECTOR (15 downto 0);
           OpB : out  STD_LOGIC_VECTOR (15 downto 0);
           SC : out  STD_LOGIC_VECTOR (15 downto 0);
           flagsOUT : out  STD_LOGIC_VECTOR (4 downto 0);
           PCout : out  STD_LOGIC_VECTOR (15 downto 0));
end RegisterFile8x16;

architecture Behavioral of RegisterFile8x16 is
	
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
	signal ELink: STD_LOGIC := ER(5) OR RFC(1);
	signal EPSW: STD_LOGIC := ER(6) OR RFC(2);
	signal EPC: STD_LOGIC := ER(7) OR RFC(3);
	signal In1MuxR6: STD_LOGIC_VECTOR (15 downto 0) := "000000000000" & flagsIN;
	signal In1MuxR7: STD_LOGIC_VECTOR (15 downto 0) := R7Q; -- + 2;	COMO FAZER A SOMA?????
	

	component Decoder3bits is
    Port ( S : in  STD_LOGIC_VECTOR (2 downto 0);
           E : in  STD_LOGIC;
           O : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	component Register16bits is
	Port ( D : in  STD_LOGIC_VECTOR (15 downto 0);
          Q : out  STD_LOGIC_VECTOR (15 downto 0);
          En : in  STD_LOGIC;
			 clkReg : in  STD_LOGIC);
	end component;
	component Register16bitsCL is
	Port ( D : in  STD_LOGIC_VECTOR (15 downto 0);
          Q : out  STD_LOGIC_VECTOR (15 downto 0);
          En : in  STD_LOGIC;
			 clkReg : in  STD_LOGIC;
			 Cl : in STD_LOGIC);
	end component;
	component MUX3x16bits is
	 Port ( In0 : in  STD_LOGIC_VECTOR (15 downto 0);
           In1 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In2 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In3 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In4 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In5 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In6 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In7 : in  STD_LOGIC_VECTOR (15 downto 0);
           Sel : in  STD_LOGIC_VECTOR (2 downto 0);
           outdata : out  STD_LOGIC_VECTOR (15 downto 0));
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



begin
-----------------------------------------
-----------------------------------------
	flagsOUT <= R6Q(4 downto 0); -- É assim???????
	PCout <= R7Q;
----------------DECOD--------------------
	decod: component Decoder3bits port map(
		S => AddrSD,
      E => RFC(0),
      O => ER);
---------------Registos------------------
	R0: component Register16bits port map(
		D => DestData,
      Q => R0Q,
      En => ER(0),
		clkReg => clock);
		
	R1: component Register16bits port map(
		D => DestData,
      Q => R1Q,
      En => ER(1),
		clkReg => clock);
		
	R2: component Register16bits port map(
		D => DestData,
      Q => R2Q,
      En => ER(2),
		clkReg => clock);
	
	R3: component Register16bits port map(
		D => DestData,
      Q => R3Q,
      En => ER(3),
		clkReg => clock);
		
	R4: component Register16bits port map(
		D => DestData,
      Q => R4Q,
      En => ER(4),
		clkReg => clock);
		
	R5: component Register16bits port map(	--LINK
		D => R5Data,
      Q => R5Q,
      En => ELink,	--ELink
		clkReg => clock);
		
	R6: component Register16bitsCL port map( --PSW
		D => R6Data,
      Q => R6Q,
      En => EPSW,	--EPSW
		clkReg => clock,
		Cl => CL);
		
	R7: component Register16bitsCL port map( --PC
		D => R7Data,
      Q => R7Q,
      En => EPC,	--EPC
		clkReg => clock,
		Cl => CL);


------------------MUX--------------------
	muxA: component MUX3x16bits port map(
		In0 => R0Q,
      In1 => R1Q,
		In2 => R2Q,
		In3 => R3Q,
		In4 => R4Q,
		In5 => R5Q,
		In6 => R6Q,
		In7 => R7Q,
      Sel => SelOpA,
      outdata => OpA);

	muxB: component MUX3x16bits port map(
		In0 => R0Q,
      In1 => R1Q,
		In2 => R2Q,
		In3 => R3Q,
		In4 => R4Q,
		In5 => R5Q,
		In6 => R6Q,
		In7 => R7Q,
      Sel => AddrB,
      outdata => OpB);
		
	muxSC: component MUX3x16bits port map(
		In0 => R0Q,
      In1 => R1Q,
		In2 => R2Q,
		In3 => R3Q,
		In4 => R4Q,
		In5 => R5Q,
		In6 => R6Q,
		In7 => R7Q,
      Sel => AddrSD,
      outdata => SC);

	muxR5: component MUX1x16bits port map(
		In0 => DestData,
      In1 => R7Q,
      Sel => RFC(1),
      outdata => R5Data);	
	muxR6: component MUX1x16bits port map(
		In0 => DestData,
      In1 => In1MuxR6,			-- Fica assim?????
      Sel => RFC(2),
      outdata => R6Data);
	muxR7: component MUX1x16bits port map(
		In0 => DestData,
      In1 => In1MuxR7,	--IncPC					-- Fica assim?????
      Sel => RFC(3),
      outdata => R7Data);
	muxMuxA: component MUX1x3bits port map(
		In0 => AddrA,
      In1 => AddrSD,
      Sel => RFC(4),
      outdata => SelOpA);
		
		
end Behavioral;

