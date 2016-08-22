--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:38:13 07/25/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Administrator/My Documents/Dropbox/Documentos Universidade/SV1516/projecto/Trabalho/vhdl1/TB_RegisterFile.vhd
-- Project Name:  vhdl1
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pds16_types.ALL;
 
ENTITY TB_RegisterFile IS
END TB_RegisterFile;
 
ARCHITECTURE behavior OF TB_RegisterFile IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile8x16
    PORT(
         clock : in  STD_LOGIC;
			addressSD : in  STD_LOGIC_VECTOR(2 downto 0);
			flags : in  STD_LOGIC_VECTOR(3 downto 0); -- 0-Zero 1-Carry 2-GE 3-Parity
			RFC : in  STD_LOGIC_VECTOR (4 downto 0); -- como é que os bits estão distribuidos? 1-enablers 2-mplexr5 3-mplexr6 4-mplexr7 5-mplexAddrA
			CL : in  STD_LOGIC;
			addrA : in  STD_LOGIC_VECTOR(2 downto 0);
			addrB : in  STD_LOGIC_VECTOR(2 downto 0);
			DestData : in  bit_16;
			flags_output : out  STD_LOGIC_VECTOR(2 downto 0); -- 0-Zero 1-Carry 2-GE
			PC : out  bit_16;
			Output_A : out  bit_16;
			Output_B : out  bit_16;
			Output_Sc : out  bit_16
        );
    END COMPONENT;
    

   --Inputs
   signal clock1 : std_logic := '0';
   signal addressSD1 : std_logic_vector(2 downto 0) := (others => '0');
   signal flags1 : std_logic_vector(3 downto 0) := (others => '0');
   signal RFC1 : std_logic_vector(4 downto 0) := (others => '0');
   signal CL1 : std_logic := '0';
   signal addrA1 : std_logic_vector(2 downto 0) := (others => '0');
   signal addrB1 : std_logic_vector(2 downto 0) := (others => '0');
   signal DestData1 : bit_16 := (others => '0');

 	--Outputs
   signal flags_output1 : std_logic_vector(2 downto 0);
	signal PC1 : bit_16;
   signal Output_A1 : bit_16;
   signal Output_B1 : bit_16;
   signal Output_Sc1 : bit_16;

   -- Clock period definitions
   constant clock_period : time := 1ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile8x16 PORT MAP (
          clock => clock1,
          addressSD => addressSD1,
          flags => flags1,
          RFC => RFC1,
          CL => CL1,
          addrA => addrA1,
          addrB => addrB1,
          DestData => DestData1,
          flags_output => flags_output1,
          PC => PC1,
          Output_A => Output_A1,
          Output_B => Output_B1,
          Output_Sc => Output_Sc1
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock1 <= '0';
		wait for clock_period/2;
		clock1 <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
--		clock1 : in  STD_LOGIC;
--		addressSD1 : in  STD_LOGIC_VECTOR(2 downto 0);
--		flags1 : in  STD_LOGIC_VECTOR(3 downto 0); -- 0-Zero 1-Carry 2-GE 3-Parity
--		RFC1 : in  STD_LOGIC_VECTOR (4 downto 0); 
-- 	1-enablers 2-mplexr5 3-mplexr6 4-mplexr7 5-mplexAddrA
--		CL1 : in  STD_LOGIC;
--		addrA1 : in  STD_LOGIC_VECTOR(2 downto 0);
--		addrB1 : in  STD_LOGIC_VECTOR(2 downto 0);
--		DestData1 : in  bit_16;
--		PC1 : inout  bit_16;
		--PC1			<= "0000000000000000";
		
		--Teste aos registos
--		addressSD1	<= "000";
--		flags1		<= "0000";
--		RFC1			<= "00001";
--		CL1			<= '0';
--		addrA1		<= "000";
--		addrB1		<= "000";
--		DestData1	<= "0001000000000000";
--		wait for 2ns;
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
		addressSD1	<= "111";
		flags1		<= "0000";
		RFC1			<= "00001";
		CL1			<= '0';
		addrA1		<= "111";
		addrB1		<= "000";
		DestData1	<= "0000000000000000";
		wait for 2ns;
		RFC1			<= "01001";
		wait;		

   end process;

END;
