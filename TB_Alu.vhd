--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:14:40 05/08/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Alu.vhd
-- Project Name:  work
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_Alu IS

------------------------------------------------------------------------------
--FALTA CORRIGIR E TESTAR OS ROTATES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--FALTA CORRIGIR E TESTAR OS ROTATES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--FALTA CORRIGIR E TESTAR OS ROTATES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--FALTA CORRIGIR E TESTAR OS ROTATES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
------------------------------------------------------------------------------

END TB_Alu;
 
ARCHITECTURE behavior OF TB_Alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu
    PORT(
         Oper : IN  std_logic_vector(3 downto 0);
         LnA : IN  std_logic;
         B : IN  std_logic_vector(15 downto 0);
         A : IN  std_logic_vector(15 downto 0);
         CyBw : IN  std_logic;
         R : OUT  std_logic_vector(15 downto 0);
         flags : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Oper : std_logic_vector(3 downto 0) := (others => '0');
   signal LnA : std_logic := '0';
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal CyBw : std_logic := '0';

 	--Outputs
   signal R : std_logic_vector(15 downto 0);
   signal flags : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu PORT MAP (
          Oper => Oper,
          LnA => LnA,
          B => B,
          A => A,
          CyBw => CyBw,
          R => R,
          flags => flags
        );

   -- Stimulus process
	stim_proc: process
   begin		
      -- hold reset state for 100 ns.
--		wait for 100 ns;
---- ADD RD,RM,RN sem carry - Teste sem dar carry
--		Oper 	<= "0000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000101"; -- 5
--		CyBw 	<= '0';
--		wait for 100 ns;
---- ADD RD,RM,RN sem carry - Teste para dar carry
--		Oper 	<= "0000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "1111111111111111"; -- 7
--		CyBw 	<= '0';
--		wait for 100 ns;
---- ADD RD,RM,RN com carry - Teste sem dar carry
--		Oper 	<= "0000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000101"; -- 5
--		CyBw 	<= '1';
--		wait for 100 ns;
---- ADD RD,RM,RN com carry - Teste para dar carry
--		Oper 	<= "0000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "1111111111111111"; -- 7
--		CyBw 	<= '1';
--		
--		
--		wait for 100 ns;
---- ADDC RD,RM,RN com carry - Teste sem dar carry
--		Oper 	<= "0100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000100"; -- 4
--		CyBw 	<= '1';
--		wait for 100 ns;
---- ADDC RD,RM,RN com carry - Teste para dar carry
--		Oper 	<= "0100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "1111111111111111"; -- 7
--		CyBw 	<= '1';
--		wait for 100 ns;
---- ADDC RD,RM,RN sem carry - Teste sem dar carry
--		Oper 	<= "0100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000100"; -- 4
--		CyBw 	<= '0';
--		wait for 100 ns;
---- ADDC RD,RM,RN sem carry - Teste para dar carry
--		Oper 	<= "0100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "1111111111111111"; -- 7
--		CyBw 	<= '0';
		
		
--		wait for 100 ns;
---- ADD RD,RM,#cons4 sem carry - Teste sem dar carry
--		Oper 	<= "1000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000101"; -- 5
--		CyBw 	<= '0';
--		wait for 100 ns;
---- ADD RD,RM,#cons4 sem carry - Teste para dar carry
--		Oper 	<= "1000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "1111111111111111"; -- 7
--		CyBw 	<= '0';
--		wait for 100 ns;
---- ADD RD,RM,#cons4 com carry - Teste sem dar carry
--		Oper 	<= "1000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000101"; -- 5
--		CyBw 	<= '1';
--		wait for 100 ns;
---- ADD RD,RM,#cons4 com carry - Teste para dar carry
--		Oper 	<= "1000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "1111111111111111"; -- 7
--		CyBw 	<= '1';
--		
--		
--		wait for 100 ns;
---- ADDC RD,RM,#cons4 com carry - Teste sem dar carry
--		Oper 	<= "1100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000100"; -- 4
--		CyBw 	<= '1';
--		wait for 100 ns;
---- ADDC RD,RM,#cons4 com carry - Teste para dar carry
--		Oper 	<= "1100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "1111111111111111"; -- 7
--		CyBw 	<= '1';
--		wait for 100 ns;
---- ADDC RD,RM,#cons4 sem carry - Teste sem dar carry
--		Oper 	<= "1100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000100"; -- 4
--		CyBw 	<= '0';
--		wait for 100 ns;
---- ADDC RD,RM,#cons4 sem carry - Teste para dar carry
--		Oper 	<= "1100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "1111111111111111"; -- 7
--		CyBw 	<= '0';



--		wait for 100 ns;
---- SUB RD,RM,RN sem borrow - Teste sem dar borrow
--		Oper 	<= "0010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000101"; -- 5
--		CyBw 	<= '0';
--		wait for 100 ns;
---- SUB RD,RM,RN sem borrow - Teste para dar borrow
--		Oper 	<= "0010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		A 		<= "0000000000000010"; -- 2
--		B 		<= "0000000000000111"; -- 7
--		CyBw 	<= '0';
--		wait for 100 ns;
---- SUB RD,RM,RN com borrow - Teste sem dar borrow
--		Oper 	<= "0010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000101"; -- 5
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SUB RD,RM,RN com borrow - Teste para dar borrow
--		Oper 	<= "0010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		A 		<= "0000000000000010"; -- 2
--		B 		<= "0000000000000111"; -- 7
--		CyBw 	<= '1';
--		
--		
--		wait for 100 ns;
---- SBB RD,RM,RN com borrow - Teste sem dar borrow
--		Oper 	<= "0110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000100"; -- 4
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SBB RD,RM,RN com borrow - Teste para dar borrow
--		Oper 	<= "0110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		A 		<= "0000000000000010"; -- 2
--		B 		<= "0000000000000111"; -- 7
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SBB RD,RM,RN sem borrow - Teste sem dar borrow
--		Oper 	<= "0110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000100"; -- 4
--		CyBw 	<= '0';
--		wait for 100 ns;
---- SBB RD,RM,RN sem borrow - Teste para dar borrow
--		Oper 	<= "0110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		A 		<= "0000000000000010"; -- 2
--		B 		<= "0000000000000111"; -- 7
--		CyBw 	<= '0';


--wait for 100 ns;
---- SUB RD,RM,#const4 sem borrow - Teste sem dar borrow
--		Oper 	<= "1010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000101"; -- 5
--		CyBw 	<= '0';
--		wait for 100 ns;
---- SUB RD,RM,#const4 sem borrow - Teste para dar borrow
--		Oper 	<= "1010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		A 		<= "0000000000000010"; -- 2
--		B 		<= "0000000000000111"; -- 7
--		CyBw 	<= '0';
--		wait for 100 ns;
---- SUB RD,RM,#const4 com borrow - Teste sem dar borrow
--		Oper 	<= "1010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000101"; -- 5
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SUB RD,RM,#const4 com borrow - Teste para dar borrow
--		Oper 	<= "1010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		A 		<= "0000000000000010"; -- 2
--		B 		<= "0000000000000111"; -- 7
--		CyBw 	<= '1';
--		
--		
--		wait for 100 ns;
---- SBB RD,RM,#const4 com borrow - Teste sem dar borrow
--		Oper 	<= "1110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000100"; -- 4
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SBB RD,RM,#const4 com borrow - Teste para dar borrow
--		Oper 	<= "1110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		A 		<= "0000000000000010"; -- 2
--		B 		<= "0000000000000111"; -- 7
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SBB RD,RM,#const4 sem borrow - Teste sem dar borrow
--		Oper 	<= "1110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		B 		<= "0000000000000010"; -- 2
--		A 		<= "0000000000000100"; -- 4
--		CyBw 	<= '0';
--		wait for 100 ns;
---- SBB RD,RM,#const4 sem borrow - Teste para dar borrow
--		Oper 	<= "1110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '0';		--IR14
--		A 		<= "0000000000000010"; -- 2
--		B 		<= "0000000000000111"; -- 7
--		CyBw 	<= '0';


--wait for 100 ns;
---- ANL - Teste sem dar zero
--		Oper 	<= "0000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000001010"; -- 
--		A 		<= "0000000000001101"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- ANL - Teste para dar zero
--		Oper 	<= "0000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000001010"; -- 
--		A 		<= "0000000000000101"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- ORL - Teste sem dar zero
--		Oper 	<= "0010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000001010"; -- 
--		A 		<= "0000000000001101"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- ORL - Teste para dar zero
--		Oper 	<= "0010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000000"; -- 
--		A 		<= "0000000000000000"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- XRL - Teste sem dar zero
--		Oper 	<= "0100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000001010"; -- 
--		A 		<= "0000000000001101"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- XRL - Teste para dar zero
--		Oper 	<= "0100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000001111"; -- 
--		A 		<= "0000000000001111"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- NOT - Teste sem dar zero
--		Oper 	<= "0110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000001010"; -- 
--		A 		<= "1111111111111110"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- NOT - Teste para dar zero
--		Oper 	<= "0110"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000000"; -- 
--		A 		<= "1111111111111111"; -- 
--		CyBw 	<= '1';


--wait for 100 ns;
---- SHL - Teste sem dar Carry e sem introdução de sinal
--		Oper 	<= "1000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000010"; -- 
--		A 		<= "0000000000001101"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SHL - Teste sem dar Carry e com introdução de sinal
--		Oper 	<= "1001"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000010"; -- 
--		A 		<= "0000000000001101"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SHL - Teste a dar Carry e com introdução de sinal
--		Oper 	<= "1001"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000010"; -- 
--		A 		<= "1100000000001101"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SHL - Teste a dar Carry e sem introdução de sinal
--		Oper 	<= "1000"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000010"; -- 
--		A 		<= "1100000000001101"; -- 
--		CyBw 	<= '1';
--wait for 100 ns;
---- SHR - Teste sem dar Carry e sem introdução de sinal
--		Oper 	<= "1010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000010"; -- 
--		A 		<= "0000000000001101"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SHR - Teste sem dar Carry e com introdução de sinal
--		Oper 	<= "1011"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000010"; -- 
--		A 		<= "0000000000001101"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SHR - Teste a dar Carry e com introdução de sinal
--		Oper 	<= "1011"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000010"; -- 
--		A 		<= "1000000000001111"; -- 
--		CyBw 	<= '1';
--		wait for 100 ns;
---- SHR - Teste a dar Carry e sem introdução de sinal
--		Oper 	<= "1010"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
--		LnA 	<= '1';		--IR14
--		B 		<= "0000000000000010"; -- 
--		A 		<= "1000000000001111"; -- 
--		CyBw 	<= '1';
		
wait for 100 ns;
-- RRL - Teste sem dar Carry
		Oper 	<= "1100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
		LnA 	<= '1';		--IR14
		B 		<= "0000000000000010"; -- 
		A 		<= "0000000000001101"; -- 
		CyBw 	<= '1';
wait for 100 ns;
-- RRL - Teste a dar Carry
		Oper 	<= "1100"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
		LnA 	<= '1';		--IR14
		B 		<= "0000000000000010"; -- 
		A 		<= "0000000000001111"; -- 
		CyBw 	<= '1';		
wait for 100 ns;
-- RRM - Teste sem dar Carry
		Oper 	<= "1101"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
		LnA 	<= '1';		--IR14
		B 		<= "0000000000000010"; -- 
		A 		<= "1000000000001101"; -- 
		CyBw 	<= '1';
wait for 100 ns;
-- RRM - Teste a dar Carry
		Oper 	<= "1101"; 	-- 0-IR10 1-IR11 2-IR12 3-IR13
		LnA 	<= '1';		--IR14
		B 		<= "0000000000000010"; -- 
		A 		<= "0000000000001111"; -- 
		CyBw 	<= '1';	


		
		
		
      wait;
   end process;

END;
