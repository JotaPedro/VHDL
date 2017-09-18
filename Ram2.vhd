----------------------------------------------------------------------------------
-- Project Name: PDS16fpga

-- Autors:	  João Botelho nº31169
--				  Tiago Ramos  nº32125

-- Module Name:  Control - Descrição Comportamental

-- Description: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
	 use work.pds16_types.ALL;

entity Ram2 is
    port (
        AD   :inout std_logic_vector (15 downto 0);  -- bi-directional data/address
        nWR    :in    std_logic_vector(1 downto 0);  -- Write Enable (High/Low)
        nRD    :in    std_logic;                     -- Read Enable
		  ALE		:in	 std_logic
    );
end entity;
architecture rtl of Ram2 is


	Signal Addr_out: std_logic_vector(14 downto 0); 

    ----------------Internal variables----------------
    constant RAM_DEPTH :integer := 2**14;

    signal data_out :std_logic_vector (15 downto 0);

--    type RAM is array (integer range <>)of std_logic_vector (15 downto 0);
	 type RAM is array (0 to RAM_DEPTH-1) of std_logic_vector (15 downto 0);
    
	 -- código teste1.asm
	 signal mem : RAM := (x"601F",		-- jmp		main
								 x"0014",
								 x"0005",
								 x"0000",
								 x"0086",		-- ldi r6, #0x10
								 x"0018",		-- ldi r0,#3
								 x"07F9",		-- ldi r1,#0xFF
								 x"0FF9",		-- ldih r1,#0xFF
								 
--								 x"8242",		-- addf r2,r0,r1
--								 x"8642",		-- add r2,r0,r1
--								 x"9683",		-- adc r3,r0,r2
--								 x"A5CA",		-- add r2, r1, #0x7
--								 x"B4C3",		-- adc r3, r0, #0x04
								
								 x"8A42",		-- subf r2, r0, r1	
								 x"8E43",		-- sub r3, r0, r1
								 x"BFCA",		-- sbb r2, r1, #0xF
								 x"ACC5",		-- sub r5, r0, #3
								 
								 x"C752",		-- anl r2, r2, r5	
								 x"CEDC",		-- orl r4, r3, r3
								 x"D653",		-- xrl r3, r2, r1
								 x"DE24",		-- not r4, r4
								 
								 x"0018",			
								 x"E781",		--
								 x"E049",		-- 
								 x"EC42",		-- 
								 x"E852",		--
								 x"F081",		-- 
								 x"F0C2",		-- 
								 x"F4C1",		--
								 x"F701",		--	
								 x"F803",		-- 
								 x"FC1B",		-- 
			
				

								others => (others => '0'));
	 
begin
	
	-----------------------
	-- LATCH ADDRESS
	-----------------------
	-- Latch for the address storing when acessing ram
	Latch: Latch16bits
	Port map( D 		=> AD,
				 Q 		=> Addr_out,
				 En 		=> ALE
				);
	
	

    -- Tri-State Buffer control
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