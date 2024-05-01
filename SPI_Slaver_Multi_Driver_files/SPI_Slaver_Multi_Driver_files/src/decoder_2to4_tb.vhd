-------------------------------------------------------------------------------
--
-- Title       : decoder_2to4_tb
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\decoder_2to4_tb.vhd
-- Generated   : Mon Apr 29 22:33:59 2024
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


entity decoder_2to4_tb is
end decoder_2to4_tb;

architecture decoder_2to4_tb of decoder_2to4_tb is
signal a, b : std_logic;
signal Y : std_logic_vector(3 downto 0);

type test_vector is record
	a : std_logic;
	b : std_logic;
	Y : std_logic_vector(3 downto 0);
end record;

type test_vector_table is array (natural range <>) of test_vector; 

constant LUT : test_vector_table := (
-- 	  a    b     Y
	('0', '0', "0001"),
	('0', '1', "0010"),
	('1', '0', "0100"),
	('1', '1', "1000")
);


begin
	UUT : entity decoder_2to4
		port map (
		a => a,
		b => b,
		Y => Y
		);
		
	tb : process 
	begin
		for i in LUT'range loop
			a <= LUT(i).a;
			b <= LUT(i).b;
			wait for 20ns;
			assert Y = LUT(i).Y
			report "Error at input : " & std_logic'image(a)	& std_logic'image(b)
			severity error;
		end loop;
		std.env.finish;
	end process;
	
end decoder_2to4_tb;
