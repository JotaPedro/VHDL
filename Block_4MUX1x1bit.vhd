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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;


entity Block_4MUX1x1bit is
    Port ( Sel : in  STD_LOGIC;
			  in0 : in  STD_LOGIC_VECTOR(3 downto 0);
			  in1 : in  STD_LOGIC_VECTOR(3 downto 0);
           out_block : out  STD_LOGIC_VECTOR(3 downto 0));
end Block_4MUX1x1bit;

architecture Structural of Block_4MUX1x1bit is

begin

			MUX_generate:
			for i in 0 to 3 generate
				Mplex: MUX1x1bit PORT MAP( 
					Sel => Sel,
					In0 => in0(i),
					In1 => in1(i),
					outdata => out_block(i));
			end generate;

end Structural;

