--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:30:36 05/24/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Mplex16bit_5to1.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mplex16bit_5to1
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
 
ENTITY TB_Mplex16bit_5to1 IS
END TB_Mplex16bit_5to1;
 
ARCHITECTURE behavior OF TB_Mplex16bit_5to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mplex16bit_5to1
    PORT(
         Input_port : IN  bit_16_array(4 downto 0);
         Selector_MP : IN  std_logic_vector(2 downto 0);
         Output_port : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input_port : bit_16_array(4 downto 0);
   signal Selector_MP : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal Output_port : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mplex16bit_5to1 PORT MAP (
          Input_port => Input_port,
          Selector_MP => Selector_MP,
          Output_port => Output_port
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		Input_port(0) <="0000111100001111";
		Input_port(1) <="1111000011110000";
		Input_port(2) <="1111111111111111";
		Input_port(3) <="0000000000000000";
		Input_port(4) <="1010101010101010";
      Selector_MP <="000";
		wait for 100 ns;
		Selector_MP <="001";
		wait for 100 ns;
		Selector_MP <="010";
		wait for 100 ns;
		Selector_MP <="011";
		wait for 100 ns;
		Selector_MP <="100";


      -- insert stimulus here 

      wait;
   end process;

END;
