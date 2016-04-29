----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:31 04/25/2016 
-- Design Name: 
-- Module Name:    Control - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control is
    Port ( WL : in  STD_LOGIC;
           Flags : in  STD_LOGIC_VECTOR(3 downto 0);
           OpCode : in  STD_LOGIC_VECTOR(x downto 0);-- ver quantos bits são o OPcode
           INTP : in  STD_LOGIC;
           Clock : in  STD_LOGIC;
           CL : in  STD_LOGIC;
           Sync : in  STD_LOGIC_VECTOR(1 downto 0);
           BusCtr : out  STD_LOGIC_VECTOR(3 downto 0);
           RFC : out  STD_LOGIC_VECTOR(4 downto 0);
           ALUC : out  STD_LOGIC_VECTOR(2 downto 0);
           SelAddr : out  STD_LOGIC_VECTOR(1 downto 0);
           SelData : out  STD_LOGIC_VECTOR(1 downto 0);
           Sellmm : out  STD_LOGIC
	);
end Control;

architecture Behavioral of Control is

begin


end Behavioral;

