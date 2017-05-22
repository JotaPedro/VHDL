--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:07:05 05/09/2017
-- Design Name:   
-- Module Name:   D:/ISEL/3o Ano/6o Semestre/PFC/VHDL/PFC16_17/FPGA_PDS/Register16bitsCL_TB.vhd
-- Project Name:  FPGA_PDS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Register16bitsCL
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
 
ENTITY Register16bitsCL_TB IS
END Register16bitsCL_TB;
 
ARCHITECTURE behavior OF Register16bitsCL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Register16bitsCL
    PORT(
         D : IN  std_logic_vector(15 downto 0);
         Q : OUT  std_logic_vector(15 downto 0);
         En : IN  std_logic;
         clkReg : IN  std_logic;
         Cl : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(15 downto 0) := (others => '0');
   signal En : std_logic := '0';
   signal clkReg : std_logic := '0';
   signal Cl : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clkReg_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Register16bitsCL PORT MAP (
          D => D,
          Q => Q,
          En => En,
          clkReg => clkReg,
          Cl => Cl
        );

   -- Clock process definitions
   clkReg_process :process
   begin
		clkReg <= '0';
		wait for clkReg_period/2;
		clkReg <= '1';
		wait for clkReg_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clkReg_period*10;

		D <= "1100110011001100";
		wait for 100 ns;	
		En <= '1';
		wait for 10 ns;
		Cl <= '1';
		wait for 7 ns;
		Cl <= '0';--
      -- insert stimulus here 

      wait;
   end process;

END;
