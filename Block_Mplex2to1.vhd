----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:08:35 08/11/2016 
-- Design Name: 
-- Module Name:    Block_Mplex2to1 - Behavioral 
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

entity Block_Mplex2to1 is
    Port ( Input1 : in  STD_LOGIC_VECTOR(15 downto 0);
			  Input2 : in STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR(15 downto 0);
			  Output_Carry: out STD_LOGIC;
           Sel : in  STD_LOGIC_VECTOR(15 downto 0);
			  ir11 : in STD_LOGIC);
end Block_Mplex2to1;

architecture Behavioral of Block_Mplex2to1 is

	component Mux_2in is
		 Port ( Input: in STD_LOGIC_VECTOR(1 downto 0);
				  Output: out STD_LOGIC;
				  Sel: in STD_LOGIC
				 );
	end component;
	--está aqui o componente pq estava a dar erro de compilação não faço ideia pq.

begin
			
			Mplex_generate:
			for i in 0 to 15 generate
				Mplex: Mux_2in PORT MAP( 
					Input(0) => Input1(i),
					Input(1) => Input2,
					Output => Output(i),
					Sel => Sel(i)
				);
			end generate;
			
			Mplex_Carry: Mux_2in PORT MAP( 
				Input(0) => Input1(0),
				Input(1) => Input1(15),
				Output => Output_Carry,
				Sel => ir11
			);

end Behavioral;

