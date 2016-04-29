----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:55 04/18/2016 
-- Design Name: 
-- Module Name:    Mplex2to1 - Behavioral 
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

entity Mplex2to1 is
    Port ( Input : in  STD_LOGIC_VECTOR(1 downto 0);
           Output : out  STD_LOGIC;
           Sel : in  STD_LOGIC);
end Mplex2to1;

architecture Behavioral of Mplex2to1 is
begin

Output <= Input(0) WHEN Sel ='1' ELSE 
            Input(1);
				
end Behavioral;

