----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Rotate_Block - Descrição Hardware

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.pds16_types.ALL;

entity Rotate_Block is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
			  CyIn : in STD_LOGIC;
			  Sel : in STD_LOGIC_VECTOR(3 downto 0);
			  LnR : in STD_LOGIC;
			  out_rotate : out STD_LOGIC_VECTOR(15 downto 0));
end Rotate_Block;

architecture Structural of Rotate_Block is

	Signal IN0 : bit_16_array(15 downto 0);
	Signal IN1 : bit_16_array(15 downto 0);

begin

	IN0(15) <= A(13)& A(12) & A(11) & A(10) & A(9)& A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15);
	IN1(15) <= A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15);
		
	rotate_15: rotateBitBlock PORT MAP(
		in0 => IN0(15),
		in1 => IN1(15),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(15));
		
		
	IN0(14) <= A(12) & A(11) & A(10) & A(9)& A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14);
	IN1(14) <= CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14);
		
	rotate_14: rotateBitBlock PORT MAP(
		in0 => IN0(14),
		in1 => IN1(14),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(14));
		
	
	IN0(13) <= A(11) & A(10) & A(9)& A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13);
	IN1(13) <= A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13);
		
	rotate_13: rotateBitBlock PORT MAP(
		in0 => IN0(13),
		in1 => IN1(13),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(13));
		
	
	IN0(12) <= A(10) & A(9)& A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12);
	IN1(12) <= A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12);
		
	rotate_12: rotateBitBlock PORT MAP(
		in0 => IN0(12),
		in1 => IN1(12),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(12));
		
		
	IN0(11) <= A(9)& A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11);
	IN1(11) <= A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11);
		
	rotate_11: rotateBitBlock PORT MAP(
		in0 => IN0(11),
		in1 => IN1(11),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(11));
		
		
	IN0(10) <= A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10);
	IN1(10) <= A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10);
		
	rotate_10: rotateBitBlock PORT MAP(
		in0 => IN0(10),
		in1 => IN1(10),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(10));
		
		
	IN0(9) <= A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9);
	IN1(9) <= A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9);
		
	rotate_9: rotateBitBlock PORT MAP(
		in0 => IN0(9),
		in1 => IN1(9),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(9));
		
		
	IN0(8) <= A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9) & A(8);
	IN1(8) <= A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8);
		
	rotate_8: rotateBitBlock PORT MAP(
		in0 => IN0(8),
		in1 => IN1(8),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(8));
		
		
	IN0(7) <= A(5) & A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9) & A(8) & A(7);
	IN1(7) <= A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7);
		
	rotate_7: rotateBitBlock PORT MAP(
		in0 => IN0(7),
		in1 => IN1(7),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(7));
		
		
	IN0(6) <= A(4) & A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9) & A(8) & A(7) & A(6);
	IN1(6) <= A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6);
		
	rotate_6: rotateBitBlock PORT MAP(
		in0 => IN0(6),
		in1 => IN1(6),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(6));
		
		
	IN0(5) <= A(3) & A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9) & A(8) & A(7) & A(6) & A(5);
	IN1(5) <= A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4) & A(5);
		
	rotate_5: rotateBitBlock PORT MAP(
		in0 => IN0(5),
		in1 => IN1(5),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(5));
		
		
	IN0(4) <= A(2) & A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9) & A(8) & A(7) & A(6) & A(5) & A(4);
	IN1(4) <= A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3) & A(4);
		
	rotate_4: rotateBitBlock PORT MAP(
		in0 => IN0(4),
		in1 => IN1(4),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(4));
		
		
	IN0(3) <= A(1) & A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9) & A(8) & A(7) & A(6) & A(5) & A(4) & A(3);
	IN1(3) <= A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2) & A(3);
		
	rotate_3: rotateBitBlock PORT MAP(
		in0 => IN0(3),
		in1 => IN1(3),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(3));
		
		
	IN0(2) <= A(0) & CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9) & A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2);
	IN1(2) <= A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1) & A(2);
		
	rotate_2: rotateBitBlock PORT MAP(
		in0 => IN0(2),
		in1 => IN1(2),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(2));
	
	
	IN0(1) <= CyIn & A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9) & A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1);
	IN1(1) <= A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0) & A(1);
		
	rotate_1: rotateBitBlock PORT MAP(
		in0 => IN0(1),
		in1 => IN1(1),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(1));
		
		
	IN0(0) <= A(15) & A(14) & A(13) & A(12) & A(11) & A(10) & A(9) & A(8) & A(7) & A(6) & A(5) & A(4) & A(3) & A(2) & A(1) & A(0);
	IN1(0) <= A(2) & A(3) & A(4) & A(5) & A(6) & A(7) & A(8) & A(9) & A(10) & A(11) & A(12) & A(13) & A(14) & A(15) & CyIn & A(0);
		
	rotate_0: rotateBitBlock PORT MAP(
		in0 => IN0(0),
		in1 => IN1(0),
		sel_LnR => LnR,
		sel_rotate => Sel,
		out_rotate_bit => out_rotate(0));
		
end Structural;

