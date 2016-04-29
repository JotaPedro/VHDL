----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:01:41 04/19/2016 
-- Design Name: 
-- Module Name:    Barrel_shift - Behavioral 
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

entity Barrel_shift is
    Port ( A : in  bit_16;
           B : inout  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  bit_16;
           Ctl_3bit : in  STD_LOGIC_VECTOR(2 downto 0); --IR10 , 11, 12
           Cy : out  STD_LOGIC);
end Barrel_shift;

architecture Behavioral of Barrel_shift is

Signal Mp2to1_j : integer := 0;
Signal Mp2to1_in: STD_LOGIC_VECTOR(16 downto 0); --todas as entradas dos multiplexers 2para1.
Signal Mp2to1_sel: STD_LOGIC_VECTOR(15 downto 0); --selectores dos multiplexers 2para1
Signal Mplex16to1_input: bit_16_array(15 downto 0); --array de 2D 16x16
Signal Output_Carry: STD_LOGIC;
Signal MpCtl_3bit_2to1_in: STD_LOGIC_VECTOR(1 downto 0); -- IR10 e A15
Signal MpCtl_3bit_2to1_out: STD_LOGIC;
Signal B_negativo: STD_LOGIC_VECTOR(3 downto 0);
Signal Decoder_1_out: STD_LOGIC_VECTOR(15 downto 0);
Signal Decoder_2_out: STD_LOGIC_VECTOR(15 downto 0);
Signal Or_tree_out_A: STD_LOGIC_VECTOR(15 downto 0);
Signal Or_tree_out_B: STD_LOGIC_VECTOR(15 downto 0);

begin
		---------------------Bloco B/-B------------------------------
	process(A,B,Ctl_3bit)	
		begin
			if (ctl_3bit(1) = '1') then
				B <= not B_negativo;
			end if;
	end process;

		---------------------multiplexers 16para1------------------------------
			Mplex16to1_input(0)	<= A;
			Mplex16to1_input(1)	<= A(14 downto 0) & A(15);
			Mplex16to1_input(15)	<= A(0) & A(15 downto 1);
			
			Mplex16to1_input_for:
			for i in 2 to 14 generate
				Mplex16to1_input(i) <=(A(15-i downto 0) & A(15 downto 16-i));
			end generate;

			Mp0: Mplex16to1 PORT MAP(
				Input => Mplex16to1_input(0),
				Sel => B_negativo,
				Output => Mp2to1_in(0)
			);
			Mp1: Mplex16to1 PORT MAP(
				Input => Mplex16to1_input(1),
				Sel => B_negativo,
				Output => Mp2to1_in(1)
			);
			Mp15: Mplex16to1 PORT MAP(
				Input => Mplex16to1_input(15),
				Sel => B_negativo,
				Output => Mp2to1_in(15)
			);	
			Mplex16to1_generate:
			for i in 2 to 14 generate
				Mp_intermedios: Mplex16to1 PORT MAP(
					Input => Mplex16to1_input(i),
					Sel => B_negativo,
					Output => Mp2to1_in(i)
				);
			end generate;
			
			--multiplexer de ctl_3bit
			MpCtl_3bit_2to1_in <= (A(15) & ctl_3bit(0));
			MpCtl_3bit_2to1: Mplex2to1 PORT MAP( 
				Input => MpCtl_3bit_2to1_in,
				Output => MpCtl_3bit_2to1_out,
				Sel => ctl_3bit(2)
			);
			
			---------------------multiplexers 2para1------------------------------

			Mp0_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(0),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(15),
				Sel => Mp2to1_sel(0)
			);
			Mp1_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(1),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(14),
				Sel => Mp2to1_sel(1)
			);
			Mp2_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(2),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(13),
				Sel => Mp2to1_sel(2)
			);
			Mp3_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(3),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(12),
				Sel => Mp2to1_sel(3)
			);
			Mp4_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(4),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(11),
				Sel => Mp2to1_sel(4)
			);
			Mp5_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(5),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(10),
				Sel => Mp2to1_sel(5)
			);
			Mp6_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(6),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(9),
				Sel => Mp2to1_sel(6)
			);
			Mp7_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(7),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(8),
				Sel => Mp2to1_sel(7)
			);
			Mp8_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(8),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(7),
				Sel => Mp2to1_sel(8)
			);
			Mp9_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(9),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(6),
				Sel => Mp2to1_sel(9)
			);
			Mp10_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(10),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(5),
				Sel => Mp2to1_sel(10)
			);
			Mp11_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(11),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(4),
				Sel => Mp2to1_sel(11)
			);
			Mp12_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(12),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(3),
				Sel => Mp2to1_sel(12)
			);
			Mp13_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(13),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(2),
				Sel => Mp2to1_sel(13)
			);
			Mp14_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(14),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(1),
				Sel => Mp2to1_sel(14)
			);
			Mp15_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(15),
				Input(1) => MpCtl_3bit_2to1_out,
				Output => Output(0),
				Sel => Mp2to1_sel(15)
			);
			--multiplexer de carry
			MpCarry_2to1: Mplex2to1 PORT MAP( 
				Input(0) => Mp2to1_in(15),
				Input(1) => Mp2to1_in(0),
				Output => Output_Carry,
				Sel => ctl_3bit(1)
			);
			
			---------------------Decoders------------------------------

			Decoder4to16_1: Decoder4to16 PORT MAP( 
				Sel => B,
				Enable =>ctl_3bit(0),--IR10
				decoder_out => Decoder_1_out
			);
			Decoder4to16_2: Decoder4to16 PORT MAP( 
				Sel => B,
				Enable => ctl_3bit(1),--IR11
				decoder_out => Decoder_2_out
			);
			
			---------------------Or tree------------------------------PARA CONFIRMAR!!!!!!
			Or_tree_1: Or_tree PORT MAP( 
				Input => Decoder_1_out,
				Output => Or_tree_out_A
			);
			Or_tree_2: Or_tree PORT MAP( 
				Input => Decoder_2_out,
				Output => Or_tree_out_B
			);
			---------------------Selector multiplexers 2para1------------------------------
			Mp2to1_sel(0) <= Or_tree_out_A(1);
			Mp2to1_sel(1) <= Or_tree_out_A(2) or Or_tree_out_B(15);
			Mp2to1_sel(2) <= Or_tree_out_A(3) or Or_tree_out_B(14);
			Mp2to1_sel(3) <= Or_tree_out_A(4) or Or_tree_out_B(13);
			Mp2to1_sel(4) <= Or_tree_out_A(5) or Or_tree_out_B(12);
			Mp2to1_sel(5) <= Or_tree_out_A(6) or Or_tree_out_B(11);
			Mp2to1_sel(6) <= Or_tree_out_A(7) or Or_tree_out_B(10);
			Mp2to1_sel(7) <= Or_tree_out_A(8) or Or_tree_out_B(9);
			Mp2to1_sel(8) <= Or_tree_out_A(9) or Or_tree_out_B(8);
			Mp2to1_sel(9) <= Or_tree_out_A(10) or Or_tree_out_B(7);
			Mp2to1_sel(10) <= Or_tree_out_A(11) or Or_tree_out_B(6);
			Mp2to1_sel(11) <= Or_tree_out_A(12) or Or_tree_out_B(5);
			Mp2to1_sel(12) <= Or_tree_out_A(13) or Or_tree_out_B(4);
			Mp2to1_sel(13) <= Or_tree_out_A(14) or Or_tree_out_B(3);
			Mp2to1_sel(14) <= Or_tree_out_A(15) or Or_tree_out_B(2);
			Mp2to1_sel(15) <= Or_tree_out_B(1);
			
			
	
Cy <= ((B(0) or B(1)) and Output_Carry);
end Behavioral;

