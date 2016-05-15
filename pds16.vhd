----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:41:13 04/12/2016 
-- Design Name: 
-- Module Name:    pds16 - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pds16 is
end pds16;


--onde vou declarar as funções da alu.
architecture Behavioral of pds16 is

begin
	process
		--Adição
		--A adição pode ser realizada entre dois registos, ou entre um registo e uma constante, sendo que a constante
		--é de quatro bits estendida com zeros à esquerda. Em qualquer um dos casos (registo ou constante) pode
		--ser ainda adicionado o bit CY. O resultado da adição é armazenado em qualquer registo do register file, e as
		--flags daí resultantes P, CY, Z e GE=(don´t care) são armazenadas no PSW.
		procedure add(op1,op2: in bit_16; cy: in bit; result: out bit_16; P,CyBw,Z,Ge: out bit_16 ) is 
			begin
				--ideia: fazer a operação normalmente e guardar o resultado numa variavel de 17 bits, sendo que o bit mais significativo
				--é o bit de Carry. Depois faz se uma distribuição do 1 bit para CyBw e dos restante 16 bits para o Resultado da soma.
				--Finalmente afecta-se as flags consuante o resultado e o bit que indica se deve ou não ser afectado o PSW.
				
		end add


--para fazer, isto é cópia do COOKBOOK.
--		procedure add (result : inout bit_16; op1, op2 : in integer; Cy : in bit; Parity, CyBw, Zero : out bit) is
--			begin
--				if op2 > 0 and op1 > integer'high-op2 then -- positive overflow
--					int_to_bits(((integer'low+op1)+op2)-integer'high-1, result);
--					V := '1';
--				elsif op2 < 0 and op1 < integer'low-op2 then -- negative overflow
--					int_to_bits(((integer'high+op1)+op2)-integer'low+1, result);
--					V := '1';
--				else
--					int_to_bits(op1 + op2, result);
--					V := '0';
--				end if;
--				N := result(31);
--				Z := bool_to_bit(result = X"0000_0000");
--		end add;
	end process;
end Behavioral;

