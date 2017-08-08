library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
<<<<<<< HEAD


entity Ram is
	Port ( 
		Clk 		: in std_logic; -- processing clock
		AD			: in std_logic_vector(15 downto 0); -- Endereço
		nRD		: in std_logic; -- 
		nWRL		: in std_logic; -- 
		nWRH		: in std_logic; -- 
		DATA		: inout std_logic_vector(15 downto 0) -- Dados
	);
end Ram;

=======


entity Ram is
	Port ( 
		Clk 		: in std_logic; -- processing clock
		AD			: in std_logic_vector(15 downto 0); -- Endereço
		nRD		: in std_logic; -- 
		nWRL		: in std_logic; -- 
		nWRH		: in std_logic; -- 
		DATA		: inout std_logic_vector(15 downto 0) -- Dados
	);
end Ram;

>>>>>>> 7d8b9c264f5cc7938c9a5734879ecf27c7cf802d
architecture Behavioral of Ram is
------------------------------------- RAM declaration
type ram is array(127 downto 0) of std_logic_vector(15 downto 0);
signal ram1 	: ram;
-------------------------------------- Signal declaration
signal r_add : std_logic_vector(15 downto 0);

	begin
<<<<<<< HEAD
		
		ram1(0) <= "1110000000000000";
		ram1(1) <= "1111111000000000";
		ram1(1) <= "1111111000000000";
=======
		
		ram1(0) <= "1110000000000000";
		ram1(1) <= "1111111000000000";
		ram1(1) <= "1111111000000000";
>>>>>>> 7d8b9c264f5cc7938c9a5734879ecf27c7cf802d
		
		process(Clk)
			begin
				if Clk'event and Clk = '1' then
					if nRD = '1' then -- Se é para ler da ram
						DATA <= ram1(conv_integer(AD));
<<<<<<< HEAD
					else
						DATA <= (others => '0');
					end if;
=======
					else
						DATA <= (others => '0');
					end if;
>>>>>>> 7d8b9c264f5cc7938c9a5734879ecf27c7cf802d
					--if nWRL = '1' and nWRH = '0' then -- Escrever parte baixa da ram
					--r_add <= radd;
				end if;
		end process;

		--data_out <= ram1_1(conv_integer(r_add)); -- Reading the data from RAM

<<<<<<< HEAD
end Behavioral; 

=======
end Behavioral; 

>>>>>>> 7d8b9c264f5cc7938c9a5734879ecf27c7cf802d
