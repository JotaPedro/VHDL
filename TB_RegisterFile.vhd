--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:52:50 08/28/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/Github/VHDL/TB_RegisterFile.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterFile8x16
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
 
ENTITY TB_RegisterFile IS
END TB_RegisterFile;
 
ARCHITECTURE behavior OF TB_RegisterFile IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile8x16
    PORT(
         clock : IN  std_logic;
         CL : IN  std_logic;
         RFC : IN  std_logic_vector(5 downto 0);
         AddrA : IN  std_logic_vector(2 downto 0);
         AddrB : IN  std_logic_vector(2 downto 0);
         AddrSD : IN  std_logic_vector(2 downto 0);
         DestData : IN  std_logic_vector(15 downto 0);
         flagsIN : IN  std_logic_vector(3 downto 0);
         OpA : OUT  std_logic_vector(15 downto 0);
         OpB : OUT  std_logic_vector(15 downto 0);
         SC : OUT  std_logic_vector(15 downto 0);
         flagsOUT : OUT  std_logic_vector(4 downto 0);
         PCout : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal CL : std_logic := '0';
   signal RFC : std_logic_vector(5 downto 0) := (others => '0');
   signal AddrA : std_logic_vector(2 downto 0) := (others => '0');
   signal AddrB : std_logic_vector(2 downto 0) := (others => '0');
   signal AddrSD : std_logic_vector(2 downto 0) := (others => '0');
   signal DestData : std_logic_vector(15 downto 0) := (others => '0');
   signal flagsIN : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal OpA : std_logic_vector(15 downto 0);
   signal OpB : std_logic_vector(15 downto 0);
   signal SC : std_logic_vector(15 downto 0);
   signal flagsOUT : std_logic_vector(4 downto 0);
   signal PCout : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile8x16 PORT MAP (
          clock => clock,
          CL => CL,
          RFC => RFC,
          AddrA => AddrA,
          AddrB => AddrB,
          AddrSD => AddrSD,
          DestData => DestData,
          flagsIN => flagsIN,
          OpA => OpA,
          OpB => OpB,
          SC => SC,
          flagsOUT => flagsOUT,
          PCout => PCout
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      --wait for clock_period*10;

      -- insert stimulus here 
--         CL : IN  std_logic;											--RFC(0)-Enable Decoder
--         RFC : IN  std_logic_vector(5 downto 0);					--RFC(1)-OR Reg R5 / SelMuxR5
--         AddrA : IN  std_logic_vector(2 downto 0);				--RFC(2)-OR Reg R6
--         AddrB : IN  std_logic_vector(2 downto 0);				--RFC(3)-OR Reg R7
--         AddrSD : IN  std_logic_vector(2 downto 0);				--RFC(4)-MUX do MUXaddrA
--         DestData : IN  std_logic_vector(15 downto 0);			--RFC(5)-enable Reg R7(para os jumps)
--         flagsIN : IN  std_logic_vector(3 downto 0);			

--Teste aos registos
		-- R0 --> OpA
		CL			<= '0';
		RFC		<= "000001";	--escreve apenas num registo
		AddrA		<= "000";
		AddrB		<= "000";
		AddrSD	<= "000";
		DestData	<= "0001000100010001";
		flagsIN	<= "0000";
		
		wait for 13ns;				--escrever R7 e sair em OpB
		AddrB		<= "111";
		AddrSD	<= "111";
		DestData	<= "0000000011111111";

		
		wait for 13ns;
		RFC		<= "000010";	-- R5(Link) grava o PC	
		AddrA		<= "101";
		
		wait for 13ns;
		RFC		<= "000100";	-- R6(PSW) grava flags_in
		AddrA		<= "110";
		flagsIN	<= "0110";

		wait for 13ns;
		RFC		<= "001000";	-- inc PC
--		
		--flagsIN	<= "0000";
--		addressSD1	<= "001";
--		DestData1	<= "0001000010000000";
--		addrA1		<= "001";
--		wait for 2ns; 
--		addressSD1	<= "010";
--		DestData1	<= "0001100010000000";		
--		addrA1		<= "010";
--      wait for 2ns;
--		addressSD1	<= "011";
--		DestData1	<= "0001000010000010";
--		addrA1		<= "011";
--		wait for 2ns;
--		addressSD1	<= "100";
--		DestData1	<= "0101000010000000";
--		addrA1		<= "100";
--		wait for 2ns;
--		addressSD1	<= "101";
--		DestData1	<= "0001000010011000";
--		addrA1		<= "101";
--		wait for 2ns;
--		addressSD1	<= "110";
--		DestData1	<= "0001100010000000";
--		addrA1		<= "110";
--		wait for 2ns;
--		addressSD1	<= "111";
--		DestData1	<= "0101000010000000";
--		addrA1		<= "111";
--      wait;

		--Teste ao registo R7 PC
--		addressSD1	<= "111";
--		flags1		<= "0000";
--		RFC1			<= "00001";
--		CL1			<= '0';
--		addrA1		<= "111";
--		addrB1		<= "000";
--		DestData1	<= "0000000000000000";
--		wait for 2ns;
--		RFC1			<= "01001";




      wait;
   end process;

END;
