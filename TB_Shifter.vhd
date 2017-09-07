--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:55:15 09/06/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_Shifter.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Shifter
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
 
ENTITY TB_Shifter IS
END TB_Shifter;
 
ARCHITECTURE behavior OF TB_Shifter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Shifter
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         Cyin : IN  std_logic;
         Shifter_Ctrl : IN  std_logic_vector(2 downto 0);
         Output : OUT  std_logic_vector(15 downto 0);
         Cy : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal Cyin : std_logic := '0';
   signal Shifter_Ctrl : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(15 downto 0);
   signal Cy : std_logic;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Shifter PORT MAP (
          A => A,
          B => B,
          Cyin => Cyin,
          Shifter_Ctrl => Shifter_Ctrl,
          Output => Output,
          Cy => Cy
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
		
--			A : IN  std_logic_vector(15 downto 0);
--			B : IN  std_logic_vector(3 downto 0);
--			Cyin : IN  std_logic;
--			Shifter_Ctrl : IN  std_logic_vector(2 downto 0);
		
		A <= ("1000000000001000");
		wait for 13 ns;
		B <= ("0011");
		Shifter_Ctrl <= ("001"); -- SHL 3x sin=1
		wait for 13 ns;
		A <= ("1111111000001000");
		Shifter_Ctrl <= ("000"); -- SHL 3x sin=0
		
		wait for 13 ns;
		A <= ("1000000000001000");
		B <= ("0100"); 
		Shifter_Ctrl <= ("010"); -- SHR 4x sin=0
		wait for 13 ns;
		Shifter_Ctrl <= ("011"); -- SHR 4x sin=1
		
		wait for 13 ns;
		B <= ("0100");
		Shifter_Ctrl <= ("100"); -- RRL 4x
		wait for 13 ns;
		B <= ("0101");				 -- RRL 5x
		
		wait for 13 ns;
		B <= ("0100");
		Shifter_Ctrl <= ("101"); -- RRM 4x	
		wait for 13 ns;
		B <= ("0101");				 -- RRM 5x	
		
		wait for 13 ns;
		B <= ("0011");
		Cyin <= '1';
		Shifter_Ctrl <= ("110"); -- RCR 3x	
		wait for 13 ns;
		B <= ("0100");				 -- RCR 4x	
		
		wait for 13 ns;
		B <= ("0001");
		Shifter_Ctrl <= ("111"); -- RCL 1x	
		wait for 13 ns;
		B <= ("0011");				 -- RCL 3x	
		
		
      wait;
   end process;

END;
