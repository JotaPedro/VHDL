----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:51:24 04/16/2016 
-- Design Name: 
-- Module Name:    Adder16bit - Behavioral 
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

entity Adder16bit is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           Cin : in  STD_LOGIC;
           Result : out  STD_LOGIC_VECTOR(15 downto 0);
           Cout : out  STD_LOGIC);
end Adder16bit;

architecture Behavioral of Adder16bit is
Signal Carry: STD_LOGIC_VECTOR(16 downto 0);
begin
	Carry(0)<= Cin;
	Adder:
	for i in 0 to 15 generate
		FAx: FullAdder PORT MAP(
			Ax		=> A(i),
			Bx		=> B(i),
			Cin	=> Carry(i),
			Sx		=> Result(i),
			Cout	=> Carry(i+1)
	);
	end generate;
	Cout <= Carry(16);
end Behavioral;

