--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:26:31 07/27/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_InstDecode.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: InstDecode
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
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
    PORT(
         OpCode : IN  std_logic_vector(6 downto 0);
         Inst : OUT  INST_TYPE;
         FlagUpdate : OUT  std_logic
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
		OpCode <= "1000000";
		wait for 100 ns;
		OpCode <= "1100000";
		
      wait;
   end process;

END;
