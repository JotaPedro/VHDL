----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:42:17 04/09/2016 
-- Design Name: 
-- Module Name:    Alu_aritmetico - Behavioral 
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

entity Alu_aritmetico is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           Cin : in  STD_LOGIC;
           Result : out  STD_LOGIC_VECTOR(15 downto 0);
           Flags_out : out  STD_LOGIC_VECTOR(1 downto 0);-- 0-GE, 1-Carry
			  Op : in STD_LOGIC);
end Alu_aritmetico;

architecture Behavioral of Alu_aritmetico is
Signal Carry: STD_LOGIC_VECTOR(16 downto 0);
Signal B_input: STD_LOGIC_VECTOR(15 downto 0);
begin
--melhorar este processo, passar para portas lógicas!!!!
	process(A,B)
		begin
			if(A >= B) then
				Flags_out(0) <='1';
			else
				Flags_out(0) <='0';
			end if;
	end process;
	
	process(B,Op)
		begin
		-- Xor gate para decidir se vamos fazer uma soma ou uma subtração.
		B_input(0) <= B(0) xor Op;
		B_input(1) <= B(1) xor Op;
		B_input(2) <= B(2) xor Op;
		B_input(3) <= B(3) xor Op;
		B_input(4) <= B(4) xor Op;
		B_input(5) <= B(5) xor Op;
		B_input(6) <= B(6) xor Op;
		B_input(7) <= B(7) xor Op;
		B_input(8) <= B(8) xor Op;
		B_input(9) <= B(9) xor Op;
		B_input(10) <= B(10) xor Op;
		B_input(11) <= B(11) xor Op;
		B_input(12) <= B(12) xor Op;
		B_input(13) <= B(13) xor Op;
		B_input(14) <= B(14) xor Op;
		B_input(15) <= B(15) xor Op;
	end process;
		Carry(0)<= (Cin xor Op);
		
		Adder:
		for i in 0 to 15 generate
			FAx: FullAdder PORT MAP(
				Ax		=> A(i),
				Bx		=> B_input(i),
				Cin	=> Carry(i),
				Sx		=> Result(i),
				Cout	=> Carry(i+1)
		);
		end generate Adder;
		
		Flags_out(1) <= Carry(16);

end Behavioral;