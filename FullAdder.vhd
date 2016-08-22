----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:39:15 04/16/2016 
-- Design Name: 
-- Module Name:    FullAdder - Behavioral 
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

entity FullAdder is
    Port ( Ax : in  STD_LOGIC;
           Bx : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sx : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
			  Op : in STD_LOGIC);
end FullAdder;

architecture Behavioral of FullAdder is
begin
--O bit op serve para escolher sub ou add.
	Sx		 <= (Ax xor Bx) xor Cin;
	Cout	 <= (((not Op) and (not Ax)) and (Cin or Bx)) or (Op and Ax and (Cin or Bx)) or (Bx and Cin);--Op=0 Sub
	--Cout	 <=((Ax xor op) and Bx) or ((Ax xor op) and Cin) or (Bx and Cin);
end Behavioral;

