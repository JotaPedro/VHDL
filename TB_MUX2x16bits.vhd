--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:57:16 08/24/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_MUX2x16bits.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX2x16bits
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
 
ENTITY TB_MUX2x16bits IS
END TB_MUX2x16bits;
 
ARCHITECTURE behavior OF TB_MUX2x16bits IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX2x16bits
    PORT(
         Sel : IN  std_logic_vector(1 downto 0);
         In0 : IN  std_logic_vector(15 downto 0);
         In1 : IN  std_logic_vector(15 downto 0);
         In2 : IN  std_logic_vector(15 downto 0);
         In3 : IN  std_logic_vector(15 downto 0);
         outdata : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Sel : std_logic_vector(1 downto 0) := (others => '0');
   signal In0 : std_logic_vector(15 downto 0) := (others => '0');
   signal In1 : std_logic_vector(15 downto 0) := (others => '0');
   signal In2 : std_logic_vector(15 downto 0) := (others => '0');
   signal In3 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal outdata : std_logic_vector(15 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX2x16bits PORT MAP (
          Sel => Sel,
          In0 => In0,
          In1 => In1,
          In2 => In2,
          In3 => In3,
          outdata => outdata
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 

		In0 <="0000111100001111";
		In1 <="1111000011110000";
		In2 <="1111111111111111";
		In3 <="1010101010101010";
      
		wait for 10 ns;
		Sel <="00";
		wait for 10 ns;
		Sel <="01";
		wait for 10 ns;
		Sel <="10";
		wait for 10 ns;
		Sel <="11";


      wait;
   end process;

END;
