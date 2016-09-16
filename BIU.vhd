----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:17:10 04/25/2016 
-- Design Name: 
-- Module Name:    BIU - Behavioral 
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
use work.pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BIU is
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
           DataIn : out  STD_LOGIC_VECTOR (15 downto 0));
end BIU;

architecture Behavioral of BIU is

	Signal ALE_flipflop_output: STD_LOGIC;
	Signal Data_to_mem: bit_16;
	Signal Mplex_DataOut_input: bit_8_array(1 downto 0);
	Signal TS_DataOut_Enable: STD_LOGIC;
	Signal TS_Addr_Enable: STD_LOGIC;
	Signal TS_Addr_Input: bit_16;
	
begin
	
	-- init var & sig
	TS_Addr_Enable 	<= (BusCtr(2) and (not BGT_in));
	TS_DataOut_Enable	<= (BusCtr(1) and (not BGT_in));
	TS_Addr_Input		<= Addr & '0';
--	TS_MBR_Enable		<= ;
	ALE <= (BusCtr(3) AND (NOT ALE_flipflop_output));
	RESOUT <= CL; --será que deve ser assim?
	S0_out <= S0_in;
	S1_out <= S1_in;
	BGT_out <= BGT_in;
	
	-- Tri-State Buffer control
	-- Data_to_mem input :
	--AD <= Data_to_mem when (WRL = '1' or WRH = '1') else (others=>'Z');	
	
	TS_DataOut: Tristate PORT MAP(
		Input => Data_to_mem,
      Enable => TS_DataOut_Enable,
      Output => AD
	);
	
	TS_Addr: Tristate PORT MAP(
		Input => TS_Addr_Input,
      Enable => TS_Addr_Enable,
      Output => AD
	);
	
--vou introduzir outro tristate para quando se faz o Read????. AD 0_15 => MBR
--	TS_MBR: Tristate PORT MAP(
--		Input => ,
--      Enable => TS_MBR_Enable,
--      Output => AD
--	);
		
	MBR1: MBR PORT MAP( 
		enable => RD,--: in  STD_LOGIC;
		d => AD,--: in  bit_16;
		q => DataIn--: out  bit_16
	);
	
	Mplex_DataOut_input(0) <= DataOut(15 downto 8);
	Mplex_DataOut_input(1) <= DataOut(7 downto 0);
	--Data_to_mem <= x"00" & DataOut(7 downto 0); Isto era o quê?
	
	Mplex_DataOut: Mplex8bit_2to1 PORT MAP(
		Input => Mplex_DataOut_input,--: in  bit_8_array(1 downto 0);
      Sel => BusCtr(0),--: in  STD_LOGIC;
      Output => Data_to_mem--: out  bit_16
	);
	
--	Mplex_DataOut: Mplex8bit_2to1 PORT MAP(
--		Input => Mplex_DataOut_input,--: in  bit_8_array(1 downto 0);
--      Sel => BusCtr(0),--: in  STD_LOGIC;
--      Output => Data_to_mem(15 downto 8)--: out  bit_8
--	);

	RDY_flipflop: DFlipFlop PORT MAP(
		D => RDY,
      Q => Sync(1),--Sync(RDY)
      Clk => Clock,
      CL => '0'
	);
	BRQ_flipflop: DFlipFlop PORT MAP(
		D => BRQ,
      Q => Sync(0),--Sync(BRQ)
      Clk => Clock,
      CL => '0'
	);
	ALE_flipflop: DFlipFlop PORT MAP(
		D => BusCtr(3),--BusCtr(ALE)
      Q => ALE_flipflop_output,
      Clk => Clock,
      CL => '0'
	);


	
--	process(BGT_in,BusCtr(2),BusCtr(1))
--		begin
--			if BusCtr(2)='1' and BGT_in='0' then -- BusCtr(2)-Addr
--				AD <= Addr & '0';
--				else if BusCtr(1)='1' and BGT_in='0' then -- BusCtr(1)-DataOut
--					AD <= Data_to_mem;
--				end if;
--			end if;
----			if BGT_in='0' then
----				nRD  <= NOT RD;
----				nWRH <= NOT WRH;
----				nWRL <= NOT WRL;
----				else if BGT_in='1' then
----					nWRH <= 'Z';
----					nWRL <= 'Z';
----					nRD  <= 'Z';
----				end if;
----			end if;
--	end process;
	
	process(RD,WRH,WRL,BGT_in)
		begin
			if BGT_in='0' then
				nRD  <= NOT RD;
				nWRH <= NOT WRH;
				nWRL <= NOT WRL;
				else if BGT_in='1' then
					nWRH <= 'Z';
					nWRL <= 'Z';
					nRD  <= 'Z';
				end if;
			end if;
	end process;
			
--	process(BGT_in)
--		begin
--			if BGT_in='0' then
--				nWRH <= NOT WRH;
--				nWRL <= NOT WRL;
--				nRD  <= NOT RD;
--				else if BTG_in='1' then
--					nWRH <= 'Z';
--					nWRL <= 'Z';
--					nRD  <= 'Z';
--				end if;
--			end if;
--	end process;

end Behavioral;