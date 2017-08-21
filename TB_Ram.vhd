--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:43:12 08/21/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Ram.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Ram
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
 
ENTITY TB_Ram IS
END TB_Ram;
 
ARCHITECTURE behavior OF TB_Ram IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Ram
    PORT(
         clk : IN  std_logic;
         AD : IN  std_logic_vector(14 downto 0);
         nRD : IN  std_logic;
         nWRL : IN  std_logic;
         nWRH : IN  std_logic;
         DATA : INOUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal AD : std_logic_vector(14 downto 0) := (others => '0');
   signal nRD : std_logic := '1';
   signal nWRL : std_logic := '1';
   signal nWRH : std_logic := '1';

	--BiDirs
   signal DATA : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Ram PORT MAP (
          clk => clk,
          AD => AD,
          nRD => nRD,
          nWRL => nWRL,
          nWRH => nWRH,
          DATA => DATA
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

--------------------------------------------------      
-- Testar Leitura da Ram
-- Testar Escrita de word
-- Testar Escrita de byte high
-- Testar Escrita de byte low
--------------------------------------------------
		AD 	<= "000" & x"000"; -- address
		DATA 	<= (others => 'Z'); -- Data
		wait for 50 ns;
		--Fazer uma leitura
		nRD 	<= '0';
		nWRL	<= '1';
		nWRH	<= '1';
		wait for 50 ns;
		AD 	<= "000" & x"001"; -- address
		DATA 	<= x"F00F"; -- Data
		wait for 50 ns;
		--Fazer uma Escrita word
		nRD	<= '1';
		nWRH	<= '0';
		nWRL	<= '1';
		wait for 50 ns;
		AD 	<= "000" & x"002"; -- address
		--Fazer uma Escrita parte alta
		nRD	<= '1';
		nWRH	<= '0';
		nWRL	<= '1';
		wait for 50 ns;
		--Fazer uma Escrita parte low
		nRD	<= '1';
		nWRH	<= '1';
		nWRL	<= '0';
      wait;
   end process;

END;
