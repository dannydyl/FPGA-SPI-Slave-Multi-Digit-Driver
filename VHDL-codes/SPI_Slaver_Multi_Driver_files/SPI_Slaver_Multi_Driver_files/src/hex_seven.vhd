-------------------------------------------------------------------------------
--
-- Title       : hex_seven
-- Design      : prelab10
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\Aldec_Codes\prelab10\prelab10\src\hex_seven.vhd
-- Generated   : Sun Apr 21 23:51:29 2024
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity hex_seven is
    port(
        hex : in std_logic_vector(3 downto 0); -- hexadecimal input
        -- segs. a..g right justified
        seg_drive : out std_logic_vector(7 downto 0)
    );
end hex_seven;


architecture behavioral of hex_seven is
begin
    with hex select
    seg_drive <=
            "01111110" when "0000", -- 0
		    "00110000" when "0001", -- 1
		    "01101101" when "0010", -- 2
		    "01111001" when "0011", -- 3
		    "00110011" when "0100", -- 4
		    "01011011" when "0101", -- 5
		    "01011111" when "0110", -- 6
		    "01110000" when "0111", -- 7
		    "01111111" when "1000", -- 8
		    "01111011" when "1001", -- 9
		    "01110111" when "1010", -- A
		    "00011111" when "1011", -- b
		    "01001110" when "1100", -- C
		    "00111101" when "1101", -- d
		    "01001111" when "1110", -- E
		    "01000111" when others; -- F		
end architecture behavioral;
