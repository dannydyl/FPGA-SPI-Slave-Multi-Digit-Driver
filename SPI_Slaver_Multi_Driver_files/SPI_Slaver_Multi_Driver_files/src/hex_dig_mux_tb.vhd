-------------------------------------------------------------------------------
--
-- Title       : hex_dig_mux_tb
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\hex_dig_mux_tb.vhd
-- Generated   : Tue Apr 30 13:06:07 2024
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
use work.all;

entity hex_dig_mux_tb is
end hex_dig_mux_tb;

architecture hex_dig_mux_tb of hex_dig_mux_tb is
signal hex_dig_0, hex_dig_1, hex_dig_2, hex_dig_3 : std_logic_vector(3 downto 0);
signal sel : std_logic_vector(1 downto 0);
signal hex_dig_out : std_logic_vector(3 downto 0);

type test_vector is record
	hex_dig_0 : std_logic_vector(3 downto 0);
	hex_dig_1 : std_logic_vector(3 downto 0);
	hex_dig_2 : std_logic_vector(3 downto 0);
	hex_dig_3 : std_logic_vector(3 downto 0);
	sel		  : std_logic_vector(1 downto 0);
	hex_dig_out : std_logic_vector(3 downto 0);
end record;

type test_table is array (natural range <>) of test_vector;

constant LUT : test_table := (
	("0001", "0010", "0100", "1000", "00", "0001"),
    ("0001", "0010", "0100", "1000", "01", "0010"),
    ("0001", "0010", "0100", "1000", "10", "0100"),
    ("0001", "0010", "0100", "1000", "11", "1000")
	);
	

begin
	UUT : entity hex_dig_mux
		port map (
            hex_dig_0 => hex_dig_0,
            hex_dig_1 => hex_dig_1,
            hex_dig_2 => hex_dig_2,
            hex_dig_3 => hex_dig_3,
            sel       => sel,
            hex_dig_out => hex_dig_out
        );
		
		
	tb : process
	begin
		for i in LUT'range loop
			hex_dig_0 <= LUT(i).hex_dig_0;
            hex_dig_1 <= LUT(i).hex_dig_1;
            hex_dig_2 <= LUT(i).hex_dig_2;
            hex_dig_3 <= LUT(i).hex_dig_3;
            sel       <= LUT(i).sel;
            wait for 20 ns;
			assert hex_dig_out = LUT(i).hex_dig_out
			report "Error at select input : " & to_string(sel)
			severity error;
		end loop;
		std.env.finish;
	end process;
	


end hex_dig_mux_tb;
