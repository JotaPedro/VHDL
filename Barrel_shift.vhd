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
           B : in  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  bit_16;
           Ctl_3bit : in  STD_LOGIC_VECTOR(2 downto 0); --IR10 , 11, 12
           Cy : out  STD_LOGIC);
end Barrel_shift;

architecture Behavioral of Barrel_shift is

Signal Mp2to1_j : integer := 0;
Signal Mp2to1_in: STD_LOGIC_VECTOR(15 downto 0):= (others => '0'); --todas as entradas dos multiplexers 2para1.
Signal Mp2to1_sel: STD_LOGIC_VECTOR(15 downto 0):= (others => '0'); --selectores dos multiplexers 2para1
Signal Output_Carry: STD_LOGIC := '0';
Signal MpCtl_3bit_2to1_in: STD_LOGIC_VECTOR(1 downto 0):= (others => '0'); -- IR10 e A15
Signal MpCtl_3bit_2to1_out: STD_LOGIC := '0';
Signal B_negativo: STD_LOGIC_VECTOR(3 downto 0):=(others => '0');
Signal Decoder_1_out: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
Signal Decoder_2_out: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
Signal Decoder_1_enable: STD_LOGIC;

begin

		---------------------Bloco B/-B------------------------------
			BlocoB: BnB PORT MAP (
          B => B,
          IR11 => ctl_3bit(1),
          B_negativo => B_negativo
        );

		---------------------multiplexers 16para1------------------------------
		Mplex16to1: Block_Mplex16to1 PORT MAP (
          A => A,							--Entradas dos Mplex
          Mp2to1_in => Mp2to1_in,	--Saidas dos Mplex
          B_negativo => B_negativo 	--selector
      );

		--multiplexer de ctl_3bit
		MpCtl_3bit_2to1_in <= (A(15) & ctl_3bit(0));
		MpCtl_3bit_2to1: Mux_2in PORT MAP( 
			Input => MpCtl_3bit_2to1_in,
			Output => MpCtl_3bit_2to1_out,
			Sel => ctl_3bit(2)
		);
		
			---------------------Selector para multiplexers 2para1----------------
			Selector_mplex: Shifter_Sel_mplex2to1 PORT MAP(
				Decoder_1 => Decoder_1_out,
				Decoder_2 => Decoder_2_out,
				Mp2to1_sel => Mp2to1_sel
			);
		
			---------------------multiplexers 2para1 + Mplex Carry - Output(16)------------------------------
			Mplex2to1: Block_Mplex2to1 PORT MAP (
          Input1 => Mp2to1_in,
          Input2 => MpCtl_3bit_2to1_out,
          Output => Output,
			 Output_Carry => Output_Carry,
          Sel => Mp2to1_sel,
			 IR11 => ctl_3bit(1)
        );
			
			---------------------Decoders------------------------------
			Decoder_1_enable <= (ctl_3bit(1) and not ctl_3bit(2)); --Criei este Signal para evitar o erro gerado pelo compilador. (Enable is not a static signal);

			Decoder_1: Decoder_16out PORT MAP( 
				Enable => ctl_3bit(0),--Decoder_1_enable,--IR11 & NOT IR12 (apenas activo no SHR)   				old--ctl_3bit(0),--IR10
				Sel => B,
				Output => Decoder_1_out
			);
			Decoder_2: Decoder_16out PORT MAP( 
				Enable => (not ctl_3bit(1)),--IR11
				Sel => B,
				Output => Decoder_2_out
			);			
	
Cy <= ((B(0) or B(1)) and Output_Carry);

end Behavioral;

