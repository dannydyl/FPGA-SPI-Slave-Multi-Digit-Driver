-------------------------------------------------------------------------------
--
-- Title       : slv_spi_rx_shifter
-- Design      : prelab10
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : W:\ESE382-Lab\Lab10\prelab10\prelab10\src\slv_spi_rx_shifter.vhd
-- Generated   : Sun Apr 21 18:24:49 2024
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


entity slv_spi_rx_shifter is
    port(
        rxd        : in  std_logic;           -- Data received from master
        rst_bar    : in  std_logic;           -- Asynchronous reset
        sel_bar    : in  std_logic;           -- Selects shifter for operation
        clk        : in  std_logic;           -- System clock
        shift_en   : in  std_logic;           -- Enable shift
        rx_data_out: out std_logic_vector(7 downto 0) -- Received data
    );
end entity slv_spi_rx_shifter;


architecture slv_spi_rx_shifter of slv_spi_rx_shifter is
begin
	shift: process (clk, rst_bar)			 
	-- variable memory : unsigned(7 downto 0);
	begin
		if rst_bar = '0' then
			rx_data_out <= (others => '0');
		elsif rising_edge(clk) then
			if sel_bar = '0' then
				if (shift_en = '1') and (rxd = '1' or rxd = '0') then
					rx_data_out <= rx_data_out(6 downto 0) & rxd;
				end if;		   
			end if;
			
		end if;	

	end process;
end slv_spi_rx_shifter;
