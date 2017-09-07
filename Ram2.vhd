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
	 use work.pds16_types.ALL;

entity Ram2 is
    port (
        AD   :inout std_logic_vector (15 downto 0);  -- bi-directional data/address
        nWR    :in    std_logic_vector(1 downto 0);             -- Write Enable (High/Low)
        nRD    :in    std_logic;                                 	-- Read Enable
		  ALE		:in	 std_logic
    );
end entity;
architecture rtl of Ram2 is


	Signal A0		: STD_LOGIC;
	Signal Addr_out: std_logic_vector(14 downto 0); 

    ----------------Internal variables----------------
    constant RAM_DEPTH :integer := 2**14;

    signal data_out :std_logic_vector (15 downto 0);

--    type RAM is array (integer range <>)of std_logic_vector (15 downto 0);
	 type RAM is array (0 to RAM_DEPTH-1) of std_logic_vector (15 downto 0);
    signal mem : RAM := ("0000000001111000", others => (others => '0'));
	 
begin
	
	-----------------------
	-- LATCH ADDRESS
	-----------------------
	-- Latch for the address storing when acessing ram
	-- não deve ter clock.
	Latch: Latch16bits
	Port map( D 		=> AD,
				 Q 		=> Addr_out,
				 En 		=> ALE,
				 A0		=> A0
				);
	
	
    ----------------Code Starts Here------------------
    -- Tri-State Buffer control
--    DATA <= data_out when (nRD = '1' and nWR = "00") else (others=>'Z');
		AD <= data_out when (nRD = '1' and nWR = "00") else (others=>'Z');
	 
    -- Memory Write Block
    MEM_WRITE:
    process (AD, Addr_out, nWR) begin
		
		if (nWR(0) = '1' and nWR(1) = '1') then -- if nWRH and nWRL active
           mem(conv_integer(Addr_out)) <= AD;
		else
			 if (nWR(0) = '1' and nWR(1) = '0') then -- if nWRL active
				  mem(conv_integer(Addr_out)) <= (mem(conv_integer(Addr_out))(15 downto 8) & AD(7 downto 0));
			 else
				  if (nWR(0) = '0' and nWR(1) = '1') then -- if nWRH active
					  mem(conv_integer(Addr_out)) <= (AD(15 downto 8) & mem(conv_integer(Addr_out))(7 downto 0));
				  end if;
			 end if;
		end if;
    end process;

    -- Memory Read Block
    MEM_READ:
    process (AD, nWR, nRD, Addr_out) begin
        if (nWR(0) = '0' and nWR(1) = '0' and nRD = '1')  then
             data_out <= mem(conv_integer(Addr_out));
        end if;
    end process;

end architecture;