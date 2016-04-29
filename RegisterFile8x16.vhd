----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:43:42 03/29/2016 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile8x16 is
    Port ( clock : in  STD_LOGIC;
           addressSD : in  STD_LOGIC_VECTOR(2 downto 0);
           flags : in  STD_LOGIC_VECTOR(3 downto 0);
           RFC : in  STD_LOGIC_VECTOR (4 downto 0); -- como é que os bits estão distribuidos? 1-enablers 2-mplexr5 3-mplexr6 4-mplexr7 5-mplexAddrA
           CL : in  STD_LOGIC;
           addrA : in  STD_LOGIC_VECTOR(2 downto 0);
           addrB : in  STD_LOGIC_VECTOR(2 downto 0);
           DestData : in  bit_16;
           flags_output : out  STD_LOGIC_VECTOR(2 downto 0);
           PC : inout  bit_16;
           Output_A : out  bit_16;
           Output_B : out  bit_16;
           Output_Sc : out  bit_16
			  );
end RegisterFile8x16;

architecture Behavioral of RegisterFile8x16 is
	
	--type 16bit is array(7 downto 0) of std_logic_vector(15 downto 0);--Para usar nas entradas dos multiplexers
	
	signal bit_pc_add: bit_vector(15 downto 0) := "0000000000000010";
	signal enabler_register: STD_LOGIC_VECTOR(7 downto 0); -- sinal que se encontra entre o enable do registo e o decoder do addrSD
	signal Q_out: bit_16_array(7 downto 0);
	signal Input_Data_r5: bit_16;
	signal Input_Data_r6: bit_16;
	signal Input_Data_r7: bit_16;
	signal selector_mplexaddrA: bit_3;
	signal Input_Data_Mplex3bit: bit_3_array(1 downto 0);
	signal Input_Data_Mplex16bit_r5, Input_Data_Mplex16bit_r6, Input_Data_Mplex16bit_r7: bit_16_array(1 downto 0);
	signal Or_gate_r5: STD_LOGIC;
	signal Or_gate_r6: STD_LOGIC;
	signal Or_gate_r7: STD_LOGIC;
	
	--signal result_adder_pc: bit_16;
	--result_adder_pc <= (PC + bit_pc_add);
--	signal r5mplexinput: bit_16_array(1 downto 0);
--	r5mplexinput(0)<= DestData;
--	r5mplexinput(1):=PC;
--	signal r6mplexinput: bit_16_array(1 downto 0);
--	r6mplexinput(0):=DestData;
--	r6mplexinput(1):=flags;
--	signal r7mplexinput: bit_16_array(1 downto 0);
--	r7mplexinput(0):=DestData;
--	r7mplexinput(1):=result_adder_pc;
		
	--Falta implementar o somador do PC e os multiplexers2-1 dos R5,R6,R7.
begin

	Input_Data_Mplex16bit_r5(0) <= DestData;
	Input_Data_Mplex16bit_r5(1) <= Q_out(7);
	Input_Data_Mplex16bit_r6(0) <= DestData;
	Input_Data_Mplex16bit_r6(1) <= ("000000000000" & flags);
	Input_Data_Mplex16bit_r7(0) <= DestData;
	Input_Data_Mplex16bit_r7(1) <= Q_out(7);
	Input_Data_Mplex3bit(0) <= addrA;
	Input_Data_Mplex3bit(1) <= addressSD;
	Or_gate_r5 <= (enabler_register(5) or RFC(1));
	Or_gate_r6 <= (enabler_register(6) or RFC(2));
	Or_gate_r7 <= (enabler_register(7) or RFC(3));



	decoder: component Decoder3_8 port map(
			AddrSD_port => addressSD,
         Enable_port => RFC(0),
         Output_port => enabler_register
	);

----------------------------------registos---------------------------------------
	r0: component nbit_register port map(
			enable => enabler_register(0),
         clk => clock,
         clr => '0', --só deve ser activado para o PSW e PC
         d => DestData,
         q => Q_out(0) --para fazer um Bus de Buses. Pesquisar.
	);-- replicar para os restantes registos.
	
	--registos
	r1: component nbit_register port map(
			enable => enabler_register(1),
         clk => clock,
         clr => '0', --só deve ser activado para o PSW e PC
         d => DestData,
         q => Q_out(1) --para fazer um Bus de Buses. Pesquisar.
	);
	--registos
	r2: component nbit_register port map(
			enable => enabler_register(2),
         clk => clock,
         clr => '0', --só deve ser activado para o PSW e PC
         d => DestData,
         q => Q_out(2) --para fazer um Bus de Buses. Pesquisar.
	);-- replicar para os restantes registos.
	
	--registos
	r3: component nbit_register port map(
			enable => enabler_register(3),
         clk => clock,
         clr => '0', --só deve ser activado para o PSW e PC
         d => DestData,
         q => Q_out(3) --para fazer um Bus de Buses. Pesquisar.
	);	
	--registos
	r4: component nbit_register port map(
			enable => enabler_register(4),
         clk => clock,
         clr => '0', --só deve ser activado para o PSW e PC
         d => DestData,
         q => Q_out(4) --para fazer um Bus de Buses. Pesquisar.
	);-- replicar para os restantes registos.
	
	--registos
	r5: component nbit_register port map(
			enable => Or_gate_r5,
         clk => clock,
         clr => '0', --só deve ser activado para o PSW e PC
         d => DestData,
         q => Q_out(5) --para fazer um Bus de Buses. Pesquisar.
	);
	--registos
	r6: component nbit_register port map(
			enable => Or_gate_r6,
         clk => clock,
         clr => CL, --só deve ser activado para o PSW e PC
         d => DestData,
         q => Q_out(6) --para fazer um Bus de Buses. Pesquisar.
	);-- replicar para os restantes registos.
	
	--registos
	r7: component nbit_register port map(
			enable => Or_gate_r7,
         clk => clock,
         clr => CL, --só deve ser activado para o PSW e PC
         d => DestData,
         q => Q_out(7) --para fazer um Bus de Buses. Pesquisar.
	);	
----------------------------------------------------------------------------------

	Multiplexer_A: component Mplex16bit_8to1 port map(
			Input_port => Q_out,
			Selector_MP => selector_mplexaddrA,
         Output_port => Output_A
	);
	Multiplexer_B: component Mplex16bit_8to1 port map(
			Input_port => Q_out,
			Selector_MP => addrB,
         Output_port => Output_B
	);
	Multiplexer_Sc: component Mplex16bit_8to1 port map(
			Input_port => Q_out,
			Selector_MP => addressSD,
         Output_port => Output_Sc
	);
	
----------------------------------------------------------------------------------
	mplexAddrA: component Mplex3bit_2to1 port map(
			Input_port => Input_Data_Mplex3bit,
			Selector_MP => RFC(4),
			Output_port => selector_mplexaddrA
	);

	mplexr5: component Mplex16bit_2to1 port map( 
			Input_port => Input_Data_Mplex16bit_r5,
			Selector_MP => RFC(1),
			Output_port => Input_Data_r5
	);
	mplexr6: component Mplex16bit_2to1 port map( 
			Input_port => Input_Data_Mplex16bit_r6,
			Selector_MP => RFC(2),
			Output_port => Input_Data_r6
	);
	mplexr7: component Mplex16bit_2to1 port map( 
			Input_port => Input_Data_Mplex16bit_r7,
			Selector_MP => RFC(3),
			Output_port => Input_Data_r7
	);


end Behavioral;

