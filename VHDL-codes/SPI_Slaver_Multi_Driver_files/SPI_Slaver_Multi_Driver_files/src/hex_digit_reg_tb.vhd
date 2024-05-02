-------------------------------------------------------------------------------
--
-- Title       : hex_digit_reg_tb
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\hex_digit_reg_tb.vhd
-- Generated   : Mon Apr 29 20:28:44 2024
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

entity hex_digit_reg_tb is
end hex_digit_reg_tb;


architecture hex_digit_reg_tb of hex_digit_reg_tb is		   
signal rst_bar, clk, load_en1, load_en2 : std_logic;
signal hex_dig_in : std_logic_vector (3 downto 0);
signal hex_dig_out : std_logic_vector (3 downto 0);

constant clk_period : time := 20ns;
begin				   
	UUT: entity hex_digit_reg
		port map(
		rst_bar => rst_bar,
		clk => clk,
		load_en1 => load_en1,
		load_en2 => load_en2,
		hex_dig_in => hex_dig_in,
		hex_dig_out => hex_dig_out
		);
	
	
	clk_tb : process
	begin 
		while true loop
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
		end loop;
	end process;
	
-- Stimulus process
tb : process
begin
    -- reset
    rst_bar <= '0';
    wait for clk_period * 2;
    rst_bar <= '1';
    wait for clk_period * 2;

    -- Testing different inputs
    for i in 0 to 15 loop -- only 16 possible values for 4 bits
        hex_dig_in <= std_logic_vector(to_unsigned(i, 4));
        load_en1 <= '1';
        load_en2 <= '1';
        wait for clk_period;
        load_en1 <= '0';
        load_en2 <= '0';

        -- Conditional assertion check
        if load_en1 = '1' and load_en2 = '1' then
            assert hex_dig_out = std_logic_vector(to_unsigned(i, 4))
                report "Error at : " & integer'image(i)
                severity error;
        end if;
        
        -- Wait a bit before the next test to see changes clearly in simulation
        wait for clk_period * 2;
    end loop;

    -- Finish test
    std.env.finish;
end process;
	
		
	
end hex_digit_reg_tb;
