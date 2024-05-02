-------------------------------------------------------------------------------
--
-- Title       : hex_dig_mux
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\hex_dig_mux.vhd
-- Generated   : Tue Apr 30 12:04:27 2024
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

entity hex_dig_mux is
    port (
        hex_dig_0 : in std_logic_vector(3 downto 0); -- mux input vectors
        hex_dig_1 : in std_logic_vector(3 downto 0); -- mux input vectors
        hex_dig_2 : in std_logic_vector(3 downto 0); -- mux input vectors
        hex_dig_3 : in std_logic_vector(3 downto 0); -- mux input vectors
        sel : in std_logic_vector(1 downto 0); -- multiplexer select inputs
        hex_dig_out : out std_logic_vector(3 downto 0) -- multiplexer output
    );
end hex_dig_mux;

architecture behavioral of hex_dig_mux is
begin
	with sel select
	hex_dig_out <= hex_dig_0 when "00",
	hex_dig_1 when "01",
	hex_dig_2 when "10",
	hex_dig_3 when "11",
	"----" when others;
	
end behavioral;
