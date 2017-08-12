----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:51:49 04/28/2016 
-- Design Name: 
-- Module Name:    PDS16fpga - Behavioral 
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
use work.pds16_types.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PDS16fpga is
    Port ( EXINT : in  STD_LOGIC;
           MCLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           AD_0_15 : inout  bit_16;
           ALE : out  STD_LOGIC;
           SO : out  STD_LOGIC;
           S1 : out  STD_LOGIC;
           RD : out  STD_LOGIC;
           WRL : out  STD_LOGIC;
           WRH : out  STD_LOGIC;
           RDY : in  STD_LOGIC;
           BRQ : in  STD_LOGIC;
           BGT : out  STD_LOGIC;
           RESOUT : out  STD_LOGIC);
end PDS16fpga;

architecture Behavioral of PDS16fpga is


begin


end Behavioral;

