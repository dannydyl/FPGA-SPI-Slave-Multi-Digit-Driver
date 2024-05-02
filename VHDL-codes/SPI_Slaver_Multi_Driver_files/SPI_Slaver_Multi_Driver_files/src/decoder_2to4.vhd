-------------------------------------------------------------------------------
--
-- Title       : decoder_2to4
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\decoder_2to4.vhd
-- Generated   : Mon Apr 29 22:16:17 2024
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

entity decoder_2to4 is
    port (
        b : in std_logic; -- most significant address bit
        a : in std_logic; -- least significant address bit
        Y : out std_logic_vector(3 downto 0) -- selected output asserted high
    );
end decoder_2to4;

architecture dataflow of decoder_2to4 is
begin
	 Y <= "0001" when (a & b = "00") else
     "0010" when (a & b = "01") else
     "0100" when (a & b = "10") else
     "1000" when (a & b = "11") else
     (others => '0');  -- default case to handle undefined statesend dataflow;
end dataflow;