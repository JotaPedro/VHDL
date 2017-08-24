----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Block_MUX1x1bit - Descrição Hardware

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;


entity Block_MUX1x1bit is
    Port ( Sel : in  STD_LOGIC_VECTOR(15 downto 0);
			  in_block_0 : in  STD_LOGIC_VECTOR(15 downto 0);
			  in_block_1 : in STD_LOGIC;
           out_block : out  STD_LOGIC_VECTOR(15 downto 0));
			  --Output_Carry: out STD_LOGIC;
           --ir11 : in STD_LOGIC);
end Block_MUX1x1bit;

architecture Structural of Block_MUX1x1bit is

--	component MUX1x1bit is
--		 Port ( Sel : in  STD_LOGIC;
--				  In0 : in  STD_LOGIC;
--				  In1 : in  STD_LOGIC;
--				  outdata : out  STD_LOGIC);
--			 
--			 
----				  Input: in STD_LOGIC_VECTOR(1 downto 0);
----				  Output: out STD_LOGIC;
----				  Sel: in STD_LOGIC
----				 );
--	end component;
	--está aqui o componente pq estava a dar erro de compilação não faço ideia pq.

begin
			
			MUX_generate:
			for i in 0 to 15 generate
				Mplex: MUX1x1bit PORT MAP( 
					Sel => Sel(i),
					In0 => in_block_0(i),
					In1 => in_block_1,
					outdata => out_block(i));
			end generate;
			
			
--			Mplex_Carry: Mux_2in PORT MAP( 
--				Input(0) => Input1(0),
--				Input(1) => Input1(15),
--				Output => Output_Carry,
--				Sel => ir11
--			);

end Structural;

