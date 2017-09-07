----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  RotateBitBlock - Descrição Hardware

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pds16_types.ALL;

entity rotateBitBlock is
    Port ( in0 : in STD_LOGIC_VECTOR(15 downto 0);
			  in1 : in STD_LOGIC_VECTOR(15 downto 0);
			  sel_LnR : in STD_LOGIC;
			  sel_rotate : in STD_LOGIC_VECTOR(3 downto 0);
			  out_rotate_bit : out STD_LOGIC );
end rotateBitBlock;

architecture Structural of rotateBitBlock is

	Signal rotateBit_out : STD_LOGIC_VECTOR(15 downto 0);

begin
	
	rotateBit: BlockRotate_MUX1x1bit PORT MAP(
		Sel => sel_LnR,			
		in_block_0 => in0,
		in_block_1 => in1,
		out_block => rotateBit_out);

	MUX_Shifter: MUX4x1bit PORT MAP(
		Sel => sel_rotate,
		Mux_In => rotateBit_out,
		outdata => out_rotate_bit );

end Structural;

