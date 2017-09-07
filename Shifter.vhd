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
use work.pds16_types.ALL;

entity Shifter is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
			  Cyin : in STD_LOGIC;
           Shifter_Ctrl : in STD_LOGIC_VECTOR(2 downto 0); --IR12 IR11 IR10
			  Output : out STD_LOGIC_VECTOR(15 downto 0);
           Cy : out STD_LOGIC);
end Shifter;

architecture Structural of Shifter is

	Signal B_sel_sig : STD_LOGIC;
	Signal BnB_sig : STD_LOGIC_VECTOR(3 downto 0);
	Signal shiftMuxs_out : STD_LOGIC_VECTOR(15 downto 0);
	Signal In1_MUX_Sin_A15 : STD_LOGIC;
	Signal MUX_Sin_A15_out : STD_LOGIC;
	Signal sel_outshiftMuxs : STD_LOGIC_VECTOR(15 downto 0);
	Signal outshiftMuxs_out : STD_LOGIC_VECTOR(15 downto 0);
	Signal enable_right_decod : STD_LOGIC;
	Signal right_decod_out : STD_LOGIC_VECTOR(15 downto 0);
	Signal enable_left_decod : STD_LOGIC;
	Signal left_decod_out : STD_LOGIC_VECTOR(15 downto 0);
	Signal RC_MUXs_out : STD_LOGIC_VECTOR(15 downto 0);
	Signal outputMUXs_sel : STD_LOGIC;
	Signal CySHL_RC_in0 : STD_LOGIC_VECTOR(15 downto 0);
	Signal CySHL_RC_in1 : STD_LOGIC_VECTOR(15 downto 0);
	Signal CySHL_RC_out : STD_LOGIC_VECTOR(15 downto 0);
	Signal cy_SHL_RC : STD_LOGIC;
	Signal CySHR_RR_MUX_in : STD_LOGIC_VECTOR(15 downto 0);
	Signal cy_SHR_RR : STD_LOGIC;
	Signal CyOutMUX_sel : STD_LOGIC;
	
	Signal CySHL_RC_sel : STD_LOGIC;
	
begin

	-----------------------------
	-- Shift / Rotate Rigth MUXs
	-----------------------------
		B_sel_sig <= Shifter_Ctrl(1) or ((not Shifter_Ctrl(1)) and Shifter_Ctrl(2));
	
		--Bloco B/-B--
		BlocoB: BnB PORT MAP (
			B_sel => B_sel_sig,
			B => B,
			B_negativo => BnB_sig);

		-- MUX 4x16bits para1el --		
		Block_shiftMUXs: Block_MUX4x16bits PORT MAP (
          Sel => BnB_sig, 					--selector
			 A => A,								--Entradas dos Mplex
			 out_Block => shiftMuxs_out);	--Saidas dos Mplex
      
		-- Sin/A15 MUXs --
		In1_MUX_Sin_A15 <= Shifter_Ctrl(0) AND A(15);	--IR10 AND A15 -> RRM
		
		MUX_Sin_A15: MUX1x1bit PORT MAP( 
			Sel => Shifter_Ctrl(2),			--IR12
			In0 => Shifter_Ctrl(0),			-- -> SHL/SHR
		   In1 => In1_MUX_Sin_A15,			-- -> RRM
			outdata => MUX_Sin_A15_out);
			
		-- Shift / Rotate Right outMUXs
		Block_outshiftMuxs: Block_MUX1x1bit PORT MAP (
			Sel => sel_outshiftMuxs,				
			in_block_0 => shiftMuxs_out,
			in_block_1 => MUX_Sin_A15_out,
         out_block => outshiftMuxs_out);
			
		-- Seletores Shift / Rotate Right outMUXs
			--Right Enable Decoder--
--		enable_right_decod <= Shifter_Ctrl(1) OR ((not Shifter_Ctrl(1)) AND Shifter_Ctrl(0));
		enable_right_decod <= Shifter_Ctrl(1) OR (Shifter_Ctrl(2) AND Shifter_Ctrl(0));
		
		right_decod: Decoder4bits PORT MAP( 
--			E => enable_right_decod, --IR11 OR (nIR11 AND IR10) -> SHR/RRM
			E => enable_right_decod, -- IR11 OR IR 12
			S => B,
			O => right_decod_out);
			
			--Left Enable Decoder--
		enable_left_decod <= (not Shifter_Ctrl(2)) and  (not Shifter_Ctrl(1));
		
		left_decod: Decoder4bits PORT MAP( 
			E => enable_left_decod,	--nIR11 AND nIR12
			S => B,
			O => left_decod_out);	
		
			--Selector para multiplexers 2para1--
		Selector_mplex: out_MUXs_Sel PORT MAP(
			Decoder_1 => right_decod_out,
			Decoder_2 => left_decod_out,
			selector => sel_outshiftMuxs);


	-----------------------------
	-- Rotate w/ Carry MUXs
	-----------------------------
		
		RC_MUXs: Rotate_Block PORT MAP(
			A => A,
			CyIn => Cyin,
			Sel => B,
			LnR => Shifter_Ctrl(0),
			out_rotate => RC_MUXs_out );
			
	
	-----------------------------
	-- Output Shifter
	-----------------------------
		
		outputMUXs_sel <= Shifter_Ctrl(1) AND Shifter_Ctrl(2);	--IR11 AND IR12
		
		outputMUXs: BlockRotate_MUX1x1bit PORT MAP(
			Sel => outputMUXs_sel,			
			in_block_0 => outshiftMuxs_out,
			in_block_1 => RC_MUXs_out,
			out_block => Output);

	-----------------------------
	-- Shifter Carry
	-----------------------------
--		-- Carry SHL / RCR / RCL
--		CySHL_RC_in0 <= A(14) & A(13)& A(12) & A(11) & A(10) & A(9)& A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & Cyin;
--		CySHL_RC_in1 <= A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & Cyin;
--		
--		CySHL_RC: BlockRotate_MUX1x1bit PORT MAP(
--			Sel => Shifter_Ctrl(0),			--IR10
--			in_block_0 => CySHL_RC_in0,
--			in_block_1 => CySHL_RC_in1,
--			out_block => CySHL_RC_out);
--
--		CySHL_RC_MUX: MUX4x1bit PORT MAP(
--			Sel => B,
--			Mux_In => CySHL_RC_out,
--			outdata => cy_SHL_RC );
--			
--		-- Carry SHR / RRM / RRL
--		CySHR_RR_MUX_in <= A(14) & A(13)& A(12) & A(11) & A(10) & A(9)& A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn;
--		
--		CySHR_RR_MUX: MUX4x1bit PORT MAP(
--			Sel => B,
--			Mux_In => CySHR_RR_MUX_in,
--			outdata => cy_SHR_RR );
--
--		-- Carry Out
--		CyOutMUX_sel <= Shifter_Ctrl(1) XOR Shifter_Ctrl(2);	-- IR11 XOR IR12
--		
--		CyOutMUX: MUX1x1bit PORT MAP(
--			Sel => CyOutMUX_sel,
--			In0 => cy_SHL_RC,
--			In1 => cy_SHR_RR,
--			outdata => Cy);

		CySHL_RC_in0 <= A(14) & A(13)& A(12) & A(11) & A(10) & A(9)& A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & Cyin;
		CySHL_RC_in1 <= A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & Cyin;

		CySHL_RC_sel <= (Shifter_Ctrl(2) AND Shifter_Ctrl(1) AND Shifter_Ctrl(0)) OR (NOT Shifter_Ctrl(2) AND NOT Shifter_Ctrl(1) AND NOT Shifter_Ctrl(0));
		
		CySHL_RC: BlockRotate_MUX1x1bit PORT MAP(
			Sel => CySHL_RC_sel,			--IR10
			in_block_0 => CySHL_RC_in0,
			in_block_1 => CySHL_RC_in1,
			out_block => CySHL_RC_out);
			
		CySHR_RR_MUX: MUX4x1bit PORT MAP(
			Sel => B,
			Mux_In => CySHL_RC_out,
			outdata => Cy );

end Structural;

