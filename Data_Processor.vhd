----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:13:18 04/07/2016 
-- Design Name: 
-- Module Name:    Data_Processor - Behavioral 
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
use ieee.numeric_std.ALL;
use work.pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Data_Processor is
    Port ( Const : in  STD_LOGIC_VECTOR(7 downto 0);
           OpB : in  bit_16;
           OpA : in  bit_16;
           CYin : in  STD_LOGIC;
           Ctr : in  STD_LOGIC_VECTOR(2 downto 0);			--Bits de seleção do multiplexer do OpB na entrada da Alu
																			--0-SigExt 1-ZeroFill 2-ZeroFillx2 3-OpB 4-OpBx2
			  Func : in  STD_LOGIC_VECTOR(5 downto 0);		--IR10 , 11, 12, 13, 14, 15
           Result : out  bit_16;
           FlagsOut : out  STD_LOGIC_VECTOR(3 downto 0)	-- 0-Zero 1-CyBw 2-GE 3-Parity 
		);
end Data_Processor;

architecture Behavioral of Data_Processor is

Signal B: bit_16;
Signal Mp_Data_in: bit_16_array(4 downto 0);
Signal SigExt_out: bit_16;
Signal Zero_Fill_out: bit_16;
Signal Alu_oper: STD_LOGIC_VECTOR(4 downto 0);

begin

			Func_gates: Sel_andgatesTree PORT MAP(
				Func => Func,
				Oper => Alu_oper(3 downto 0),
				LnA => Alu_oper(4)
			);
			
			Alu1: Alu PORT MAP(
				Oper => Alu_oper(3 downto 0), --: in  STD_LOGIC_VECTOR(3 downto 0); --IR10 , 11, 12, 13
				LnA  => Alu_oper(4),--: in  STD_LOGIC; --IR14
				B  => B,--: in  bit_16; 
				A => OpA,--: in  bit_16;
				CyBw => Cyin,--: in  STD_LOGIC;
				R  => Result,--: out  bit_16;
				flags  => FlagsOut--: out  STD_LOGIC_VECTOR(3 downto 0) -- 0-Zero 1-CyBw 2-GE 3-Parity 
			);
			
			
			SigExt1: SigExt PORT MAP(
				Const8x2 => Const,--é usado para o offset nos jumps.
				Output16bit => SigExt_out--: out  bit_16
			);
			Zero_Fill1: Zero_Fill PORT MAP(
				Const4bit => Const(6 downto 3),-- apenas a parte da const4 das instruções.
				Output16bit => Zero_Fill_out--: out  bit_16
			);
		
			
			Mp_Data_in(0) <= SigExt_out;
			Mp_Data_in(1) <= Zero_Fill_out;
			Mp_Data_in(2) <= Zero_Fill_out(Zero_Fill_out'length -2 downto 0) & '0'; -- ESTE É x2!!! é para fazer shift
			Mp_Data_in(3) <= OpB;
			Mp_Data_in(4) <= OpB(OpB'length -2 downto 0) & '0';-- ESTE É x2!!! é para fazer shift
			
			Mp_Data: Mplex16bit_5to1 PORT MAP(
				Input_port => Mp_Data_in,--: in  bit_16_array(4 downto 0);
				Selector_MP => Ctr,--: in STD_LOGIC_VECTOR(2 downto 0);
				Output_port => B--: out  bit_16
			);
			
			
--	process(Const,OpA,OpB,CYin,Ctr)
--		begin
--
--	end process;
end Behavioral;

