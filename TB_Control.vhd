--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:37:16 08/16/2017
-- Design Name:   
-- Module Name:   F:/Projecto/github repo/VHDL/TB_Control.vhd
-- Project Name:  work
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control
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
 
ENTITY TB_Control IS
END TB_Control;
 
ARCHITECTURE behavior OF TB_Control IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         A0 : IN  std_logic;
         Flags : IN  std_logic_vector(2 downto 0);
         OpCode : IN  std_logic_vector(6 downto 0);
         INTP : IN  std_logic;
         Clock : IN  std_logic;
         CL : IN  std_logic;
         Sync : IN  std_logic_vector(1 downto 0);
         BusCtr : OUT  std_logic_vector(3 downto 0);
         RFC : OUT  std_logic_vector(5 downto 0);
         ALUC : OUT  std_logic_vector(2 downto 0);
         SelAddr : OUT  std_logic_vector(1 downto 0);
         SelData : OUT  std_logic_vector(1 downto 0);
         Sellmm : OUT  std_logic;
         RD : OUT  std_logic;
         WR : OUT  std_logic_vector(1 downto 0);
         BGT : OUT  std_logic;
         S1S0 : OUT  std_logic_vector(1 downto 0);
         EIR : OUT  std_logic;
         CState : OUT  STATE_TYPE;
         inst : OUT  INST_TYPE
        );
    END COMPONENT;
    

   --Inputs
   signal A0 : std_logic := '0';
   signal Flags : std_logic_vector(2 downto 0) := (others => '0');
   signal OpCode : std_logic_vector(6 downto 0) := (others => '0');
   signal INTP : std_logic := '0';
   signal Clock : std_logic := '0';
   signal CL : std_logic := '0';
   signal Sync : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal BusCtr : std_logic_vector(3 downto 0);
   signal RFC : std_logic_vector(5 downto 0);
   signal ALUC : std_logic_vector(2 downto 0);
   signal SelAddr : std_logic_vector(1 downto 0);
   signal SelData : std_logic_vector(1 downto 0);
   signal Sellmm : std_logic;
   signal RD : std_logic;
   signal WR : std_logic_vector(1 downto 0);
   signal BGT : std_logic;
   signal S1S0 : std_logic_vector(1 downto 0);
   signal EIR : std_logic;
   signal CState : STATE_TYPE;
   signal inst : INST_TYPE;

   -- Clock period definitions
   constant Clock_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          A0 => A0,
          Flags => Flags,
          OpCode => OpCode,
          INTP => INTP,
          Clock => Clock,
          CL => CL,
          Sync => Sync,
          BusCtr => BusCtr,
          RFC => RFC,
          ALUC => ALUC,
          SelAddr => SelAddr,
          SelData => SelData,
          Sellmm => Sellmm,
          RD => RD,
          WR => WR,
          BGT => BGT,
          S1S0 => S1S0,
          EIR => EIR,
          CState => CState,
          inst => inst
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '1';
		wait for Clock_period/2;
		Clock <= '0';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
-- Sinais necessários para as instruções serem executadas.
		Sync(1) <= '1';
		
-- Instruções já testadas. ------------------------------------------
--		OpCode <= "0000000"; --LDI
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "0000101"; --LDIH
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "0001000"; --LD_Direct
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "0001100"; --LD_IndConst
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "0001101"; --LD_Indexed
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "0011000"; --ST_Direct
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "0011100"; --ST_IndConst
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "0011101"; --ST_Indexed
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "1000000"; --ADD
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "1001000"; --ADDC
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "1000100"; --SUB
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "1001100"; --SBB
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "1010000"; --ADD_const
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "1011000"; --ADDC_const
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "1010100"; --SUB_const
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "1011100"; --SBB_const
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "1100000"; --ANL
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "1100100"; --ORL
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "1101000"; --XRL
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "1101100"; --NT
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "1110000"; --SHL
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "1110100"; --SHR
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--
--		OpCode <= "1111000"; --RRL
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "1111010"; --RRM
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

--		OpCode <= "1111100"; --RCR
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "1111110"; --RCL
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--
--		OpCode <= "0100000"; --JZ
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "0100100"; --JNZ
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--
--		OpCode <= "0101000"; --JC
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "0101100"; --JNC
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--
--		OpCode <= "0110000"; --JMP
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "0110100"; --JMPL
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);


-- Instruções para testar. ------------------------------------------

--		OpCode <= "0111000"; --IRET
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);
--		OpCode <= "0111100"; --NOP
--		wait for 10 ns;
--		wait until (CState = SFetch_Addr);

      wait;
   end process;

END;
