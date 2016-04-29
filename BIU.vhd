----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:17:10 04/25/2016 
-- Design Name: 
-- Module Name:    BIU - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BIU is
    Port ( Clock : in  STD_LOGIC;
           CL : in  STD_LOGIC;
           Addr : in  STD_LOGIC_VECTOR(14 downto 0);
           DataOut : in  STD_LOGIC_VECTOR(15 downto 0);
           BusCtr : in  STD_LOGIC_VECTOR(3 downto 0);
           Sync : out  STD_LOGIC_VECTOR(1 downto 0);
           AD : inout  STD_LOGIC_VECTOR(15 downto 0);
           ALE : out  STD_LOGIC;
           S0 : inout  STD_LOGIC;
           S1 : inout  STD_LOGIC;
           RD : inout  STD_LOGIC;
           WRL : inout  STD_LOGIC;
           WRH : inout  STD_LOGIC;
           RDY : in  STD_LOGIC;
           BRQ : in  STD_LOGIC;
           BGT : inout  STD_LOGIC;
           RESOUT : out  STD_LOGIC;
           DataIn : out  STD_LOGIC);
end BIU;

architecture Behavioral of BIU is

begin


end Behavioral;

