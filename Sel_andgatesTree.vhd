----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:30:22 04/08/2016 
-- Design Name: 
-- Module Name:    Sel_andgatesTree - Behavioral 
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

--bit 15= Func(0)
--bit 14= Func(1)
--bit 13= Func(2)
--bit 12= Func(3)
--bit 11= Func(4)
--bit 10= Func(5)

entity Sel_andgatesTree is
    Port ( Func : in  STD_LOGIC_VECTOR(5 downto 0);--IR10 , 11, 12, 13, 14, 15
           Oper : out  STD_LOGIC_VECTOR(3 downto 0);
           LnA : out  STD_LOGIC);
end Sel_andgatesTree;

architecture Behavioral of Sel_andgatesTree is

begin
	process(Func)
		begin
			if Func(5) = '0' then --if IR15 = 0
					Oper <= Func(3)& "000";--passa o bit13 e os restantes relativos ao Oper ficam a 0.
					LnA <= '0';
				else if Func(5) = '1' then--if IR15 = 1
					Oper <= Func(3 downto 0);--IR10 , 11, 12, 13
					LnA <= Func(4);--IR14
				end if;
			end if;
	end process;
end Behavioral;

