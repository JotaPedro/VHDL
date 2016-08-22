----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:37:50 03/19/2016 
-- Design Name: 
-- Module Name:    nbit_register - Behavioral 
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

entity nbit_register is
	generic(N:integer := 16);
    Port ( 
			enable : in  STD_LOGIC;
         clk : in  STD_LOGIC;
         clr : in  STD_LOGIC; --só deve ser activado para o PSW e PC
         d : in  STD_LOGIC_VECTOR (N-1 downto 0);
         q : out  STD_LOGIC_VECTOR (N-1 downto 0)
			 );
end nbit_register;

architecture Behavioral of nbit_register is
begin
		process(clk,clr)
		begin
				if clr = '1' then				--esta parte do código só vai servir para
					q <= (others => '0');	--os registos PSW e PC
--				else if clk'event and clk ='1' then
				else if rising_edge(clk) then
						if enable = '1' then
							q <= d;
						end if;
				end if;
				end if;
		end process;
end Behavioral;

