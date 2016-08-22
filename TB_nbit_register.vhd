--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:22:42 07/21/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_nbit_register.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: nbit_register
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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY TB_nbit_register IS
END TB_nbit_register;

-- entity declaration for your testbench.Dont declare any ports here 
ARCHITECTURE behavior OF TB_nbit_register IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_register
    PORT(
         enable : IN  std_logic;
         clk : IN  std_logic;
         clr : IN  std_logic;
         d : IN  std_logic_vector(15 downto 0);
         q : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal enable : std_logic := '0';
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';
   signal d : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal q : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1ns;
	
	-- Variables
	-- valor 10
	signal first  : std_logic_vector(15 downto 0) := ("0000000000001010"); 
	-- valor 200
	signal second : std_logic_vector(15 downto 0) := ("0000000011001000"); 
	-- valor 167
	signal third  : std_logic_vector(15 downto 0) := ("0000000010100111");--(1 downto 0 => '1', others => '0'); 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_register PORT MAP (
          enable => enable,
          clk => clk,
          clr => clr,
          d => d,
          q => q
        );

   -- Clock process definitions( clock with 50% duty cycle is generated here.
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;	--for 0.5 ns signal is '0'.
		clk <= '1';
		wait for clk_period/2;	--for next 0.5 ns signal is '1'.
   end process;
	
   -- Stimulus process
	stim_proc: process
	begin
		enable <= '1';
		d <= first;
		wait for 2 ns;
		d <= (others => '0');
		wait for 2 ns;
		d <= second;
		wait for 2 ns;
		enable <= '0';
		d <= third;
		wait for 2 ns;
		enable <= '1';
		d <= third;
		wait;
  end process;

END;