--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:09:53 08/20/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_Alu.vhd
-- Project Name:  vhdl1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Alu
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
use work.pds16_types.ALL;
 
ENTITY TB_Alu IS
END TB_Alu;
 
ARCHITECTURE behavior OF TB_Alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu
    PORT(
         Oper : IN  std_logic_vector(3 downto 0);
         LnA : IN  std_logic;
         B : IN  bit_16;
         A : IN  bit_16;
         CyBw : IN  std_logic;
         R : OUT  bit_16;
         flags : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
	 -- O BIT IR10 (que decide se o PSW é afectado) não está a funcionar!!!!! VER O QUE SE PASSA!!!!!

   --Inputs
   signal Oper1 : std_logic_vector(3 downto 0) := (others => '0');
   signal LnA1 : std_logic := '0';
   signal B1 : std_logic_vector(15 downto 0) := (others => '0');
   signal A1 : std_logic_vector(15 downto 0) := (others => '0');
   signal CyBw1 : std_logic := '0';

 	--Outputs
   signal R1 : std_logic_vector(15 downto 0);
   signal flags1 : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu PORT MAP (
          Oper => Oper1, --IR10 , 11, 12, 13
          LnA => LnA1, --IR14 -- Logic not Aritmetic
          B => B1,
          A => A1,
          CyBw => CyBw1,
          R => R1,
          flags => flags1 --P,Z,CyBw,GE
        );

   -- Stimulus process
   stim_proc: process
   begin
--		A1 	<= "0000000000000001";
--		B1 	<= "0000000000000011";
--		Oper1 <= "0110"; --NOT
--		LnA1 	<= '1'; --Logico
--		CyBw1 <= '1';
--		wait for 1 ns;
--		A1 	<= "0000000000000001";
--		B1 	<= "0000000000000011";
--		Oper1 <= "0000"; --ANL
--		LnA1 	<= '1'; --Logico
--		CyBw1 <= '1';
--		wait for 1 ns;
--		A1 	<= "0000000000000001";
--		B1 	<= "0000000000000011";
--		Oper1 <= "0010"; --ORL
--		LnA1 	<= '1'; --Logico
--		CyBw1 <= '1';
--		wait for 1 ns;
--		A1 	<= "0000000000000001";
--		B1 	<= "0000000000000011";
--		Oper1 <= "0100"; --XRL
--		LnA1 	<= '1'; --Logico
--		CyBw1 <= '1';
--		wait for 1 ns;
--		A1 	<= "0000000000000001";
--		B1 	<= "0000000000000011";
--		Oper1 <= "0110"; --NOT
--		LnA1 	<= '1'; --Logico
--		CyBw1 <= '1';
		
		A1 	<= "0000000000000001";
		B1 	<= "0000000000000000";
		Oper1 <= "1100"; --RRL
		LnA1 	<= '1';
		CyBw1 <= '0';
		wait for 1 ns;		
		Oper1 <= "1101"; --RRM
		
--    A1 	<= "0000000000000001";
--		B1 	<= "0000000000000011";
--		Oper1 <= "0000"; --ADD
--		LnA1 	<= '0'; --aritmetico
--		CyBw1 <= '1'; 
--		wait for 1 ns;
--		A1 	<= "0000000000000001";
--		B1 	<= "0000000000000011";
--		Oper1 <= "0100"; --ADDC
--		LnA1 	<= '0'; --aritmetico
--		CyBw1 <= '1';
--		wait for 1 ns;
--		A1 	<= "0000000000000001";
--		B1 	<= "0000000000000011";
--		Oper1 <= "0001"; --ADD f
--		LnA1 	<= '0'; --aritmetico
--		CyBw1 <= '1'; 
--		wait for 1 ns;
--		A1 	<= "0000000000000001";
--		B1 	<= "0000000000000011";
--		Oper1 <= "0101"; --ADDC f
--		LnA1 	<= '0'; --aritmetico
--		CyBw1 <= '1';
      wait;
   end process;

END;
