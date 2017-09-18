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

entity Barrel_Shift is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
			  Cyin : in STD_LOGIC;
           Shifter_Ctrl : in STD_LOGIC_VECTOR(2 downto 0); --IR12 IR11 IR10
			  Output : out STD_LOGIC_VECTOR(15 downto 0);
           Cy : out STD_LOGIC);
end Barrel_Shift;

architecture Structural of Barrel_Shift is

	-- Bloco de seleção de operações p/ a esquerda (left) ou direita (right) 
	Signal left_op : STD_LOGIC;
	Signal right_op : STD_LOGIC;
	-- B Select
	Signal selB_sel : STD_LOGIC;
	Signal selB_out : STD_LOGIC_VECTOR (3 downto 0);
	-- Shift MUXs
	Signal BnB_sig : STD_LOGIC_VECTOR (3 downto 0);
	Signal shiftMuxs_out : STD_LOGIC_VECTOR (15 downto 0);
	-- SIN, MSb, CY MUXs
	Signal MUX_sin_MSb_out : STD_LOGIC;
	Signal MUX_sin_MSb_CY_out : STD_LOGIC;
	Signal MUX_sin_MSb_CY_sel : STD_LOGIC;
	-- Out MUXs
	Signal Output_Carry : STD_LOGIC;
	-- Select dos MUXs de saida
	Signal sel_MUXs_outdata : STD_LOGIC_VECTOR (15 downto 0);
	Signal rightDec_en : STD_LOGIC;
	Signal leftDec_en : STD_LOGIC;
	Signal rightDec_out : STD_LOGIC_VECTOR (15 downto 0);
	Signal leftDec_out : STD_LOGIC_VECTOR (15 downto 0);
	

begin

	-----------------
	-- Bloco de seleção de operações p/ a esquerda (left) ou direita (right) 
	-----------------
			-- left_op = SHL or RCL
		left_op <= (not Shifter_Ctrl(2) and not Shifter_Ctrl(1)) or (Shifter_Ctrl(2) and Shifter_Ctrl(1) and Shifter_Ctrl(0));
			-- right_op = not (SHL or RCL)
		right_op <= not left_op;
	
	
	-----------------
	-- B Select
	-----------------	
		selB_sel <= Shifter_Ctrl(2) and Shifter_Ctrl(1);
		
		selB: Block_4MUX1x1bit PORT MAP (
			Sel => selB_sel,	
			in0 => B,
			in1 => "0001",
			out_block => selB_out);

	-----------------
	-- Shift MUXs
	-----------------
		--Bloco B/-B--
		BlocoB: BnB PORT MAP (
			B_sel => right_op,
			B => selB_out,
			B_negativo => BnB_sig);

		-- MUX 4x16bits para1el --
		Block_shiftMUXs: Block_MUX4x16bits PORT MAP (
          Sel => BnB_sig, 					
			 A => A,								
			 out_Block => shiftMuxs_out	
      );


	--------------------------------
	-- SIN, MSb, CY MUXs
	--------------------------------
		--multiplexers 16 entradas a 1 bit--
		MUX_sin_MSb: MUX1x1bit PORT MAP( 
			Sel => Shifter_Ctrl(2),
			In0 => Shifter_Ctrl(0), 		--sin
		   In1 => A(15),
			outdata => MUX_sin_MSb_out);
		
		MUX_sin_MSb_CY_sel <= Shifter_Ctrl(2) and Shifter_Ctrl(1);
		
		MUX_sin_MSb_CY: MUX1x1bit PORT MAP( 
			Sel => MUX_sin_MSb_CY_sel,
			In0 => MUX_sin_MSb_out,
		   In1 => Cyin,
			outdata => MUX_sin_MSb_CY_out);

	-------------
	-- Out MUXs
	-------------
		--multiplexers 2 entradas a 1 bit--	
		Block_outdataMuxs: Block_MUX1x1bit PORT MAP (
			Sel => sel_MUXs_outdata,
			in_block_0 => shiftMuxs_out,
			in_block_1 => MUX_sin_MSb_CY_out,
         out_block => Output);
			
		--mux de saida CY--
		Mux_Carry: MUX1x1bit PORT MAP( 
			Sel => right_op,
			In0 => shiftMuxs_out(0),
			In1 => shiftMuxs_out(15),
			outdata => Output_Carry);
				
		Cy <= ((selB_out(0) or selB_out(1) or selB_out(2) or selB_out(3)) and Output_Carry);

	----------------------------------------
	-- Select dos MUXs de saida
	----------------------------------------	
		--Decoders--
		rightDec_en <= (not Shifter_Ctrl(2) and Shifter_Ctrl(1)) or 							--SHR
							(Shifter_Ctrl(2) and not Shifter_Ctrl(1) and Shifter_Ctrl(0)) or 	--RRM
							(Shifter_Ctrl(2) and Shifter_Ctrl(1) and not Shifter_Ctrl(0));		--RCR
		
		rightDec: Decoder4bits PORT MAP( 
			E => rightDec_en, 		--SHR or RRM or RCR
			S => selB_out,
			O => rightDec_out);
			
		
		leftDec_en <= left_op;
		
		leftDec: Decoder4bits PORT MAP( 
			E => leftDec_en,			-- SHL or RCL
			S => selB_out,
			O => leftDec_out);			
		
		--Selector para multiplexers da saida de DATA--
			Selector_mplex: out_MUXs_Sel PORT MAP(
				Decoder_1 => rightDec_out,
				Decoder_2 => leftDec_out,
				selector => sel_MUXs_outdata);
				
				
end Structural;

