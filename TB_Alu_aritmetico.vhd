--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:24:12 08/28/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_Alu_aritmetico.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Alu_aritmetico
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
 
ENTITY TB_Alu_aritmetico IS
END TB_Alu_aritmetico;
 
ARCHITECTURE behavior OF TB_Alu_aritmetico IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu_aritmetico
    PORT(
         Op : IN  std_logic_vector(1 downto 0);
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         Cin : IN  std_logic;
         Result : OUT  std_logic_vector(15 downto 0);
         Flags_out : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal Cin : std_logic := '0';

 	--Outputs
   signal Result : std_logic_vector(15 downto 0);
   signal Flags_out : std_logic_vector(1 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu_aritmetico PORT MAP (
          Op => Op,
          A => A,
          B => B,
          Cin => Cin,
          Result => Result,
          Flags_out => Flags_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		 		-- Soma sem carry in, sem carry out		-> ADD
		A 		<= "0000000000000001";
		B 		<= "0000000000000010";
		Cin 	<= '1';
		Op 	<= "00";
		wait for 100 ns;
		-- Soma com carry in, sem carry out		-> ADDc
		A 		<= "0000000000000001";
		B 		<= "0000000000000010";
		Cin 	<= '1';
		Op 	<= "10";
		wait for 100 ns;
		-- Soma sem carry in, com carry out		-> ADD
		A 		<= "1111111111111111";
		B 		<= "0000000000000010";
		Cin 	<= '1';
		Op 	<= "00";
		wait for 100 ns;
		-- Soma com carry in, com carry out		-> ADDc
		A 		<= "1111111111111101";
		B 		<= "0000000000000011";
		Cin 	<= '1';
		Op 	<= "10";
		wait for 100 ns;		--500ns
		-- subtração sem carry in, sem carry out	-> SUB
		A 		<= "0000000000000010";
		B 		<= "0000000000000001";
		Cin 	<= '1';
		Op 	<= "01";
		wait for 100 ns;		--600ns
		-- subtração com carry in, sem carry out	-> SUBb
		A 		<= "0000000000000011";
		B 		<= "0000000000000001";
		Cin 	<= '1';
		Op 	<= "11";
		wait for 100 ns;		--700ns
		-- subtração sem carry in, com carry out	-> SUB
		A 		<= "0000000000000000";
		B 		<= "0000000000000001";
		Cin 	<= '1';
		Op 	<= "01";
		wait for 100 ns;		--800ns
		-- subtração com carry in, com carry out	-> SUBb
		A 		<= "0000000000000001";
		B 		<= "0000000000000001";
		Cin 	<= '1';
		Op 	<= "11";

      wait;
   end process;

END;
