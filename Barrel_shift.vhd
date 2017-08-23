----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Barrel_shift - Descrição Hardware

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;


entity Barrel_shift is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           Shifter_Ctrl : in STD_LOGIC_VECTOR(2 downto 0); --IR12 IR11 IR10
			  Output : out STD_LOGIC_VECTOR(15 downto 0);
           Cy : out STD_LOGIC);
end Barrel_shift;

architecture Behavioral of Barrel_shift is

	Signal BnB_sig: STD_LOGIC_VECTOR(3 downto 0);
	Signal MUX_RC_CY_A15_out: STD_LOGIC;
	Signal shiftMuxs_in: STD_LOGIC_VECTOR(15 downto 0);
	Signal shiftMuxs_out: STD_LOGIC_VECTOR(15 downto 0); --todas as entradas dos multiplexers 2para1.
	Signal MUX_RC_CY_A15_sel: STD_LOGIC;
	Signal Cy_interno: STD_LOGIC;
	Signal MUX_sin_CY_IR12_out: STD_LOGIC;
	

--	Signal Mp2to1_j : integer := 0;
	
--	Signal Mp2to1_sel: STD_LOGIC_VECTOR(15 downto 0):= (others => '0'); --selectores dos multiplexers 2para1
--	Signal Output_Carry: STD_LOGIC := '0';
--	Signal MpCtl_3bit_2to1_in: STD_LOGIC_VECTOR(1 downto 0):= (others => '0'); -- IR10 e A15
--	Signal MpCtl_3bit_2to1_out: STD_LOGIC := '0';
	
--	Signal Decoder_1_out: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
--	Signal Decoder_2_out: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
--	Signal Decoder_1_enable: STD_LOGIC;
--	Signal Decoder_2_enable: STD_LOGIC;
	
	
--	
	
--	Signal Mplex_IR12_IR10_CY_out: STD_LOGIC;


begin
		
		
	-----------------
	-- Shift MUXs
	-----------------
		--Bloco B/-B--
		BlocoB: BnB PORT MAP (
			IR11 => Shifter_Ctrl(1),
			B => B,
			B_negativo => BnB_sig);

		-- MUX 4x16bits para1el --
		shiftMuxs_in <= MUX_RC_CY_A15_out & A(14 downto 0);
		
		Block_shiftMUXs: Block_MUX4x16bits PORT MAP (
          Sel => BnB_sig, 					--selector
			 A => shiftMuxs_in,				--Entradas dos Mplex
			 out_Block => shiftMuxs_out	--Saidas dos Mplex
      );
		
				
	--------------------------------
	-- Rotate w/ Carry and Sin MUXs
	--------------------------------
		--multiplexers 2para1--
		MUX_RC_CY_A15_sel <= (Shifter_Ctrl(2) and Shifter_Ctrl(1)); --Activa quando é Rotate with Carry=IR12 adn IR11
		
		MUX_RC_CY_A15: MUX1x1bit PORT MAP( 
			Sel : MUX_RC_CY_A15_sel;
			In0 : A(15);
		   In1 : Cy_interno;
			outdata : MUX_RC_CY_A15_out);
		
		MUX_sin_CY_IR12: MUX1x1bit PORT MAP( 
			Sel : Shifter_Ctrl(2);
			In0 : Shifter_Ctrl(0);
		   In1 : MUX_RC_CY_A15_out;
			outdata : MUX_sin_CY_IR12_out);
		
		
		
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
			Decoder_2_enable <= (not ctl_3bit(1));--IR11
			
			Decoder_1: Decoder_16out PORT MAP( 
				Enable => Decoder_1_enable, --ctl_3bit(0),--Decoder_1_enable,--IR11 & NOT IR12 (apenas activo no SHR)   				old--ctl_3bit(0),--IR10
				Sel => B,
				Output => Decoder_1_out
			);
			Decoder_2: Decoder_16out PORT MAP( 
				Enable => Decoder_2_enable,
				Sel => B,
				Output => Decoder_2_out
			);			

Cy_interno <= ((B(0) or B(1) or B(2) or B(3)) and Output_Carry);
Cy <= Cy_interno;

end Behavioral;

