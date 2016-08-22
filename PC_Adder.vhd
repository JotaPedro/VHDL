----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:34:04 07/28/2016 
-- Design Name: 
-- Module Name:    PC_Adder - Behavioral 
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

entity PC_Adder is
    Port ( A : in  STD_LOGIC_VECTOR(15 downto 0);
           B : in  STD_LOGIC_VECTOR(15 downto 0);
           Result : out  STD_LOGIC_VECTOR(15 downto 0));
end PC_Adder;

architecture Behavioral of PC_Adder is
Signal Carry: STD_LOGIC_VECTOR(16 downto 0);
begin
		Carry(0)<= '0';
		Adder:
		for i in 0 to 15 generate
			FAx: FullAdder PORT MAP(
				Ax		=> A(i),
				Bx		=> B(i),
				Cin	=> Carry(i),
				Sx		=> Result(i),
				Cout	=> Carry(i+1),
				Op		=> '1'
		);
		end generate Adder;
end Behavioral;