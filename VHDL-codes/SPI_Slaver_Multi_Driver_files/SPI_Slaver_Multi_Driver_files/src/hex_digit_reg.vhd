-------------------------------------------------------------------------------
--
-- Title       : hex_digit_reg
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\hex_digit_reg.vhd
-- Generated   : Mon Apr 29 20:18:24 2024
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

entity hex_digit_reg is
    port (
        rst_bar : in std_logic; -- asynchronous reset
        clk : in std_logic; -- system clock
        load_en1 : in std_logic; -- enable load
        load_en2 : in std_logic; -- enable load
        hex_dig_in : in std_logic_vector(3 downto 0); -- received data in
        hex_dig_out : out std_logic_vector(3 downto 0) -- received data out
    );
end hex_digit_reg;

architecture behavioral of hex_digit_reg is
begin
	reg : process (clk, rst_bar)
	begin
		if rst_bar = '0' then
			hex_dig_out <= (others => '0');
		elsif rising_edge(clk) then
			if (load_en1 = '1') and (load_en2 = '1') then
				hex_dig_out <= hex_dig_in;			 
			end if;
		end if;
	end process;
end behavioral;
