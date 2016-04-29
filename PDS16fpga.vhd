----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:51:49 04/28/2016 
-- Design Name: 
-- Module Name:    PDS16fpga - Behavioral 
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

entity PDS16fpga is
    Port ( EXINT : in  STD_LOGIC;
           MCLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           AD_0_15 : inout  bit_16;
           ALE : out  STD_LOGIC;
           SO : out  STD_LOGIC;
           S1 : out  STD_LOGIC;
           RD : out  STD_LOGIC;
           WRL : out  STD_LOGIC;
           WRH : out  STD_LOGIC;
           RDY : in  STD_LOGIC;
           BRQ : in  STD_LOGIC;
           BGT : out  STD_LOGIC;
           RESOUT : out  STD_LOGIC);
end PDS16fpga;

architecture Behavioral of PDS16fpga is

Signal INTP_Input: STD_LOGIC;
Signal IE: STD_LOGIC;
Signal Reset_flipflop_output: STD_LOGIC;
Signal RES: STD_LOGIC:= Reset_flipflop_output OR (NOT RESET);
Signal N_MCLK: STD_LOGIC:= NOT MCLK;
Signal Mplex_selData_input: bit_16_array(3 downto 0);
Mplex_selData_input(0) <= 
Mplex_selData_input(1) <=
Mplex_selData_input(2) <=
Mplex_selData_input(3) <=
Signal Mplex_selAddr_input: bit_16_array(3 downto 0);
Mplex_selAddr_input(3) <= (15 downto 0 => '0'); --Esta entrada não conta para o multiplexer
Mplex_selAddr_input(0) <= 
Mplex_selAddr_input(1) <= 


begin

	Reset_flipflop: DFlipFlop PORT MAP(
		D <= Reset_flipflop_output,
      Q <= NOT RESET,
      Clk <= N_MCLK,
      CL <= '0'
	);
	EXINT_flipflop: DFlipFlop PORT MAP(
		D <= EXINT,
      Q <= INTP_Input,
      Clk <= N_MCLK,
      CL <= IE
	);
	Mplex_selData: Mplex16bit_4to1 PORT MAP(
		Input <= ,--: in  bit_16_array(3 downto 0);
		Sel <= ,--: in  STD_LOGIC_VECTOR(1 downto 0);
		Output <= --: out  bit_16
	);
	Mplex_selAddr: Mplex16bit_4to1 PORT MAP(--ATENÇÃO, este multiplexer de 4para1 é para ser usado no lugar do multiplexer 3 para 1 com a ultima porta sempre a 0;
		Input <= ,--: in  bit_16_array(3 downto 0);
		Sel <= ,--: in  STD_LOGIC_VECTOR(1 downto 0);
		Output <= --: out  bit_16
	);
	Mplex_D07: Mplex8bit_2to1 PORT MAP(
		Input <= ,--: in  bit_8_array(1 downto 0);
      Sel <= ,--: in  STD_LOGIC;
      Output <= --: out  bit_8
	);
	DirZeroFill: DirZeroFill PORT MAP( 
		Input <= Mplex_selAddr_input(2),--: in  STD_LOGIC_VECTOR(6 downto 0);
      Output <= --: out  bit_16
	);


end Behavioral;

