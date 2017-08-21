library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Ram is
	Port ( 
		clk		: in std_logic;
		AD			: in std_logic_vector(14 downto 0); -- Endereço
		nRD		: in std_logic; -- 
		nWRL		: in std_logic; -- 
		nWRH		: in std_logic; -- 
		DATA		: inout std_logic_vector(15 downto 0) -- Dados
	);
end Ram;

architecture Behavioral of Ram is
------------------------------------- RAM declaration
type ram is array(10 downto 0) of std_logic_vector(7 downto 0);
signal ramHigh	: ram;
signal ramLow	: ram;
signal data_out : std_logic_vector(15 downto 0);

	begin
		data_out 	<= (others => 'Z');
		
		ramHigh(0)	<= "11100000";
		ramLow(0)	<= "00000000";
		
		ramHigh(1)	<= "11111110";
		ramLow(1)	<= "00000000";
		
		ramHigh(2)	<= "11111000";
		ramLow(2)	<= "00000000";

-- Tri-State Buffer control
  DATA <= data_out when (nRD = '0' and nWRL = '1' and nWRH = '1') else (others=>'Z');
	
-- Memory Write Block
-- Write Operation : When we = 1, cs = 1
  MEM_WRITE: process (clk) 
	begin
	if (rising_edge(clk)) then
    --se for para escrever uma word
		if (nWRL = '0' and nWRH = '0') then
			ramHigh(conv_integer(AD))  <= DATA(15 downto 8);
			ramLow(conv_integer(AD))	<= DATA(7 downto 0);
		else
		--se for para escrever um byte na parte baixa ( endereço impar )
			if (nWRL = '0' and nWRH = '1') then
				ramLow(conv_integer(AD))	<= DATA(7 downto 0);
			else
				--se for para escrever um byte na parte alta ( endereço par )
				if (nWRL = '1' and nWRH = '0') then
					ramHigh(conv_integer(AD))  <= DATA(15 downto 8);
				end if;
			end if;
		end if;
	end if;
  end process;

-- Memory Read Block
  MEM_READ: process (clk) 
	begin
	if (rising_edge(clk)) then
		 if (nRD = '0') then
			data_out <= ramHigh(conv_integer(AD)) & ramLow(conv_integer(AD));
		 end if;
	end if;
  end process;
	
end Behavioral; 