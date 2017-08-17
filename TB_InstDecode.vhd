-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.pds16_types.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_InstDecode IS
END TB_InstDecode;
 
ARCHITECTURE behavior OF TB_InstDecode IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstDecode
    Port (  OpCode 	: in  STD_LOGIC_VECTOR(6 downto 0);-- bits de 15 a 9
				Inst		: out INST_TYPE; --Que instrução é a descodificada.
				FlagUpdate: out STD_LOGIC --Se é para atualizar o registo de flags. true/false
			);
    END COMPONENT;
    

   --Inputs
   signal OpCode : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal Inst : INST_TYPE;
   signal FlagUpdate : std_logic;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstDecode PORT MAP (
          OpCode => OpCode,
          Inst => Inst,
          FlagUpdate => FlagUpdate
        );

   -- Stimulus process
   stim_proc: process
   begin		
      
		OpCode <= "0000000";
		wait for 100 ns;
		--OpCode <= "0000100";
		OpCode <= "0000101";
		wait for 100 ns;
		OpCode <= "1000010";
		wait for 100 ns;
		OpCode <= "1100000";
		
      wait;
   end process;

END;
