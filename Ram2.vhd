-------------------------------------------------------
-- Design Name : ram_sp_ar_aw
-- File Name   : ram_sp_ar_aw.vhd
-- Function    : Asynchronous read write RAM 
-- Coder       : Deepak Kumar Tala (Verilog)
-- Translator  : Alexander H Pham (VHDL)
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

entity Ram2 is
    port (

        AD 		:in    std_logic_vector (14 downto 0);  		-- address Input
        DATA   :inout std_logic_vector (15 downto 0);  -- data bi-directional
        nWR    :in    std_logic_vector(1 downto 0);             -- Write Enable (High/Low)
        nRD    :in    std_logic                                 	-- Read Enable
--		nWRL		: in std_logic; -- 
--		nWRH		: in std_logic; -- 
    );
end entity;
architecture rtl of Ram2 is
    ----------------Internal variables----------------
    constant RAM_DEPTH :integer := 2**14;

    signal data_out :std_logic_vector (15 downto 0);

    type RAM is array (integer range <>)of std_logic_vector (15 downto 0);
    signal mem : RAM (0 to RAM_DEPTH-1);
begin

    ----------------Code Starts Here------------------
    -- Tri-State Buffer control
    DATA <= data_out when (nRD = '1' and nWR = "00") else (others=>'Z');
	 
    -- Memory Write Block
    MEM_WRITE:
    process (AD, DATA, nWR) begin
		
		if (nWR(0) = '1' and nWR(1) = '1') then -- if nWRH and nWRL active
           mem(conv_integer(AD)) <= DATA;
		else
			 if (nWR(0) = '1' and nWR(1) = '0') then -- if nWRL active
				  mem(conv_integer(AD)) <= (mem(conv_integer(AD))(15 downto 8) & DATA(7 downto 0));
			 else
				  if (nWR(0) = '0' and nWR(1) = '1') then -- if nWRH active
					  mem(conv_integer(AD)) <= (DATA(15 downto 8) & mem(conv_integer(AD))(7 downto 0));
				  end if;
			 end if;
		end if;
    end process;

    -- Memory Read Block
    MEM_READ:
    process (AD, nWR, nRD, mem) begin
        if (nWR(0) = '0' and nWR(1) = '0' and nRD = '1')  then
             data_out <= mem(conv_integer(AD));
        end if;
    end process;

end architecture;