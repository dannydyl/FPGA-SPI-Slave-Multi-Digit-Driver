-------------------------------------------------------------------------------
--
-- Title       : rx_buff_reg
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\rx_buff_reg.vhd
-- Generated   : Mon Apr 29 16:13:14 2024
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

entity rx_buff_reg is
    port (
        rst_bar : in std_logic; -- asynchronous reset
        clk : in std_logic; -- system clock
        load_en : in std_logic; -- enable shift
        rx_buff_in : in std_logic_vector(7 downto 0); -- received data in
        rx_buff_out : out std_logic_vector(7 downto 0) -- received data out
    );
end rx_buff_reg;

architecture Behavioral of rx_buff_reg is
begin
	double_buffer : process (clk, rst_bar)
	begin
		if rst_bar = '0' then
			rx_buff_out <= (others => '0');
		elsif rising_edge(clk) then
			if load_en = '1' then
				rx_buff_out <= rx_buff_in;
			end if;
			
		end if;
	end process;
end Behavioral;
