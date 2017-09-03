--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:34:21 08/28/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_Alu.vhd
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
END TB_Alu;
 
ARCHITECTURE behavior OF TB_Alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu
    PORT(
         aluFunc : IN  std_logic_vector(5 downto 0);
         CyBw : IN  std_logic;
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         R : OUT  std_logic_vector(15 downto 0);
         flags : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal aluFunc : std_logic_vector(5 downto 0) := (others => '0');
   signal CyBw : std_logic := '0';
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal R : std_logic_vector(15 downto 0);
   signal flags : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu PORT MAP (
          aluFunc => aluFunc,
          CyBw => CyBw,
          A => A,
          B => B,
          R => R,
          flags => flags
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
--	aluFunc : IN  std_logic_vector(5 downto 0);
--	CyBw : IN  std_logic;
--	A : IN  std_logic_vector(15 downto 0);
--	B : IN  std_logic_vector(15 downto 0);	
		
		
---- ADD RD,RM,RN sem carry - Teste sem dar carry
--	aluFunc <= "100000"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '0';
--	A <= "0000000000000101"; -- 5
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;
--
------ ADD RD,RM,RN sem carry - Teste para dar carry
--	aluFunc <= "100000"; 		
--	CyBw <= '1';
--	A <= "1111111111111111";
--	B <= "0000000000000010";
--	wait for 13 ns;

---- ADDc RD,RM,RN - Teste sem dar carry
--	aluFunc <= "100100"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000000101"; -- 5
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;
	
---- ADDc RD,RM,RN - Teste para dar carry
--	aluFunc <= "100100"; 		
--	CyBw <= '1';
--	A <= "1111111111111111";
--	B <= "0000000000000010";
--	wait for 13 ns;

---- ADD RD,RM,#cons4 sem carry - Teste sem dar carry
--	aluFunc <= "101000"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000000101"; -- 5
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;	

---- ADD RD,RM,#cons4 sem carry - Teste para dar carry
--	aluFunc <= "101000"; 		
--	CyBw <= '1';
--	A <= "1111111111111111";
--	B <= "0000000000000010";
--	wait for 13 ns;

---- ADDc RD,RM,#cons4 com carry - Teste sem dar carry
--	aluFunc <= "101100"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000000101"; -- 5
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;	

---- ADDC RD,RM,#cons4 com carry - Teste para dar carry
--	aluFunc <= "101100"; 		
--	CyBw <= '1';
--	A <= "1111111111111111";
--	B <= "0000000000000010";
--	wait for 13 ns;


--	********** SUB ***************
--	******************************
	
---- SUB RD,RM,RN sem borrow - Teste sem dar borrow
--	aluFunc <= "100010"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '0';
--	A <= "0000000000000101"; -- 5
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;

---- SUB RD,RM,RN sem borrow - Teste para dar borrow
--	aluFunc <= "100010"; 		
--	CyBw <= '1';
--	A <= "0000000000000010";
--	B <= "0000000000000101";
--	wait for 13 ns;

---- SBB RD,RM,RN - Teste sem dar borrow
--	aluFunc <= "100110"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000000101"; -- 5
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;
	
---- SBB RD,RM,RN com borrow - Teste para dar borrow
--	aluFunc <= "100110"; 		
--	CyBw <= '1';
--	A <= "0000000000000010";
--	B <= "0000000000000101";
--	wait for 13 ns;

---- SUB RD,RM,#const4 sem borrow - Teste sem dar borrow
--	aluFunc <= "101010"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000000101"; -- 5
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;	

---- SUB RD,RM,#const4 sem borrow - Teste para dar borrow
--	aluFunc <= "101010"; 		
--	CyBw <= '1';
--	A <= "0000000000000010";
--	B <= "0000000000000101";
--	wait for 13 ns;

---- SBB RD,RM,#const4 com borrow - Teste sem dar borrow
--	aluFunc <= "101110"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000000101"; -- 5
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;	

---- SBB RD,RM,#const4 com borrow - Teste para dar borrow
--	aluFunc <= "101110"; 		
--	CyBw <= '1';
--	A <= "0000000000000010";
--	B <= "0000000000000101";
--	wait for 13 ns;
	

--	********** AND ***************
--	******************************

---- ANL - Teste para dar zero
--	aluFunc <= "110000"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000000101"; -- 5
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;	

---- ANL - Teste sem dar zero
--	aluFunc <= "110000"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000000111"; -- 7
--	B <= "0000000000000010"; -- 2
--	wait for 13 ns;


--	********** OR ****************
--	******************************	

---- ORL - Teste sem dar zero
--	aluFunc <= "110010"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000001101";
--	B <= "0000000000001010";
--	wait for 13 ns;
	
	
--	********** XOR ***************
--	******************************

---- XRL - Teste sem dar zero
--	aluFunc <= "110100"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000001101";
--	B <= "0000000000001010";
--	wait for 13 ns;
	
	
--	********** NOT ***************
--	******************************

---- NOT - Teste sem dar zero
--	aluFunc <= "110110"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000001101";
--	B <= "0000000000001010";
--	wait for 13 ns;


--	********** SH ****************
--	******************************

---- SHL - Teste sem dar Carry e sem introdução de sinal
--	aluFunc <= "111000"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000001101";
--	B <= "0000000000001010";
--	wait for 13 ns;

---- SHL - Teste para dar Carry e com introdução de sinal
--	aluFunc <= "111001"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000001101";
--	B <= "0000000000001101";
--	wait for 13 ns;
	
---- SHR - Teste a dar Carry e com introdução de sinal
--	aluFunc <= "111011"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
--	CyBw <= '1';
--	A <= "0000000000001101";
--	B <= "0000000000000011";
--	wait for 13 ns;
	

--	********** RR ****************
--	******************************
---- RRL - Teste a dar Carry
	aluFunc <= "111100"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
	CyBw <= '1';
	A <= "0000000000001101";
	B <= "0000000000000011";
	wait for 13 ns;
	
---- RRM - Teste sem dar Carry
	aluFunc <= "111101"; 		-- 0-IR10 1-IR11 2-IR12 3-IR13 4-IR14 5-IR15
	CyBw <= '1';
	A <= "1000000000001101";
	B <= "0000000000000010";
	wait for 13 ns;
	
	

------------------------------------------------------------------------	


		
		

      wait;
   end process;

END;
