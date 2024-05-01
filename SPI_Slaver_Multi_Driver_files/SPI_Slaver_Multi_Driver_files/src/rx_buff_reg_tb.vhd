-------------------------------------------------------------------------------
--
-- Title       : rx_buff_reg_tb
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\rx_buff_reg_tb.vhd
-- Generated   : Mon Apr 29 16:33:59 2024
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

entity rx_buff_reg_tb is
end rx_buff_reg_tb;

architecture rx_buff_reg_tb of rx_buff_reg_tb is   
signal rst_bar, clk, load_en : std_logic; --input
signal rx_buff_in : std_logic_vector(7 downto 0); -- input load
signal rx_buff_out : std_logic_vector(7 downto 0); -- output load 

constant clk_period : time := 10ns;
begin	
	
UUT: entity rx_buff_reg 
	port map (
	rst_bar => rst_bar, 
	clk => clk, 
	load_en => load_en, 
	rx_buff_in => rx_buff_in, 
	rx_buff_out => rx_buff_out
);

	clock_tb : process 
	begin			 				 
		while true loop
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;		
		end loop;
	end process;
	
	tb : process
	begin
		-- reset
        rst_bar <= '0';
        wait for clk_period * 2;
        rst_bar <= '1';
        wait for clk_period * 2;
	    
		-- load buffer
        rx_buff_in <= "10101010";
        load_en <= '1';
        wait for clk_period;
        load_en <= '0';

        wait for clk_period * 5;

        for i in 0 to 255 loop
            rx_buff_in <= std_logic_vector(to_unsigned(i, 8));
            load_en <= '1';
            wait for clk_period;
            load_en <= '0';
            wait for clk_period;		  
			assert rx_buff_out = std_logic_vector(to_unsigned(i,8))
			report "Error at " & integer'image(i)
			severity error;
        end loop;		 
		std.env.finish;
    end process;	

end rx_buff_reg_tb;
