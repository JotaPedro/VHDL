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
Signal B_xor: STD_LOGIC_VECTOR(15 downto 0);
Signal NotOp: STD_LOGIC;
begin
	process(A,B)
		begin
			if(A >= B) then
				Flags_out(0) <='1';
			else
				Flags_out(0) <='0';
			end if;
	end process;
		Carry(0)<= Cin;
--		Sub:
--		for i in 0 to 15 generate
--			B_xor(i) <= B(i) xor Op;
--		end generate Sub;

		NotOp <= (not Op); --Porque o Operador está invertido na implementação do somador. 0-Sub 1-Add;
		
		Adder:
		for i in 0 to 15 generate
			FAx: FullAdder PORT MAP(
				Ax		=> A(i),
				Bx		=> B(i),
				Cin	=> Carry(i),
				Sx		=> Result(i),
				Cout	=> Carry(i+1),
				Op		=> NotOp --Porque o Operador está invertido na implementação do somador. 0-Sub 1-Add
		);
		end generate Adder;
		--Falta implementar o IR12 para escolher a afectação do Carry in na operação escolhida.
		Flags_out(1) <= Carry(16);

end Behavioral;