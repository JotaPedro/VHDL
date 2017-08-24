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
	Signal Output_Carry: STD_LOGIC;
	Signal Decoder_1_out: STD_LOGIC_VECTOR(15 downto 0);
	Signal Decoder_2_out: STD_LOGIC_VECTOR(15 downto 0);
	Signal sel_MUXs_outdata: STD_LOGIC_VECTOR(15 downto 0); --selectores dos multiplexers de saida de dados
	
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
		--multiplexers 16 entradas a 1 bit--
		MUX_RC_CY_A15_sel <= (Shifter_Ctrl(2) and Shifter_Ctrl(1)); --Activa quando é Rotate with Carry=IR12 adn IR11
		
		MUX_RC_CY_A15: MUX1x1bit PORT MAP( 
			Sel => MUX_RC_CY_A15_sel,
			In0 => A(15),
		   In1 => Cy_interno,
			outdata => MUX_RC_CY_A15_out);
		
		MUX_sin_CY_IR12: MUX1x1bit PORT MAP( 
			Sel => Shifter_Ctrl(2),
			In0 => Shifter_Ctrl(0),
		   In1 => MUX_RC_CY_A15_out,
			outdata => MUX_sin_CY_IR12_out);
		
	----------------------------------------
	-- MUXs de saida do bloco Barrel Shift
	----------------------------------------
		--multiplexers 2 entradas a 1 bit--	
		Block_outdataMuxs: Block_MUX1x1bit PORT MAP (
			Sel => sel_MUXs_outdata,
			in_block_0 => shiftMuxs_out,
			in_block_1 => MUX_sin_CY_IR12_out,
         out_block => Output);
			
		--mux de saida CY--
		Mux_Carry: MUX1x1bit PORT MAP( 
			Sel => Shifter_Ctrl(1), --IR11
			In0 => shiftMuxs_out(15),
			In1 => shiftMuxs_out(0),
			outdata => Output_Carry);
		
		Cy_interno <= ((B(0) or B(1) or B(2) or B(3)) and Output_Carry);
		Cy <= Cy_interno;
		
	----------------------------------------
	-- Select dos MUXs de saida
	----------------------------------------	
		--Decoders--
		Decoder_1: Decoder4bits PORT MAP( 
			E => (Shifter_Ctrl(1) and not Shifter_Ctrl(2)), --IR11 AND nIR12 (apenas activo no SHR)   				old--ctl_3bit(0),--IR10
			S => B,
			O => Decoder_1_out);
			
		Decoder_2: Decoder4bits PORT MAP( 
			E => (not Shifter_Ctrl(1)),	--nIR11
			S => B,
			O => Decoder_2_out);			
		
		--Selector para multiplexers 2para1----------------
			Selector_mplex: out_MUXs_Sel PORT MAP(
				Decoder_1 => Decoder_1_out,
				Decoder_2 => Decoder_2_out,
				selector => sel_MUXs_outdata);
		

end Behavioral;

