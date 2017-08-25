--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:13:39 08/24/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_ImmZeroFill.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ImmZeroFill
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_ImmZeroFill IS
END TB_ImmZeroFill;
 
ARCHITECTURE behavior OF TB_ImmZeroFill IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ImmZeroFill
    PORT(
         SelImm : IN  std_logic;
         LSB : IN  std_logic_vector(7 downto 0);
         Input : IN  std_logic_vector(7 downto 0);
         Output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SelImm : std_logic := '0';
   signal LSB : std_logic_vector(7 downto 0) := (others => '0');
   signal Input : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ImmZeroFill PORT MAP (
          SelImm => SelImm,
          LSB => LSB,
          Input => Input,
          Output => Output
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 

		SelImm	<= '0';		--LDI
		LSB		<= "11111111";
		Input	<= "00000110";
		wait for 100 ns;
		SelImm	<= '1';		--LDIH

      wait;
   end process;

END;
