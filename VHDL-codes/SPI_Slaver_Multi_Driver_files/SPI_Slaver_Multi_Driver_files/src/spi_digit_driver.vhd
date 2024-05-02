-------------------------------------------------------------------------------
--
-- Title       : spi_digit_driver
-- Design      : prelab10
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\Aldec_Codes\prelab10\prelab10\src\spi_digit_driver.vhd
-- Generated   : Mon Apr 22 14:36:53 2024
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--------------------------------------edge detector-----------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity edge_det is
    port(
        rst_bar   : in  std_logic; -- Asynchronous system reset
        clk       : in  std_logic; -- System clock
        sig       : in  std_logic; -- Input signal
        pos       : in  std_logic; -- '1' for positive edge, '0' for negative
        sig_edge  : out std_logic  -- High for one system clk after edge detected
    );
end entity edge_det;


architecture moore_fsm of edge_det is	   
type state is (state_a, state_b, state_c);
signal present_state, next_state : state;
begin								  		
	-- first state : detects rst_bar
	state_reg: process (clk, rst_bar)			 
	begin 
		if rst_bar = '0' then
			present_state <= state_a;
		elsif rising_edge(clk) then
			present_state <= next_state;
		end if;
	end process;
	
	-- process where it outputs
	outputs: process (present_state)
	begin 
		case present_state is
			when state_c => sig_edge <= '1';
			when others => sig_edge <= '0';
		end case;
	end process;
	
	nxt_state: process (present_state, sig)
	begin
		case present_state is
			when state_a =>
			if (pos = '1' and sig = '0') or (pos = '0' and sig = '1') then
				next_state <= state_b;
			else
				next_state <= state_a;
			end if;
			
			when state_b =>
			if (pos = '1' and sig = '1') or (pos = '0' and sig = '0') then
				next_state <= state_c;
			else
				next_state <= state_b;
			end if;
			
			when others =>
			if (pos = '1' and sig = '0') or (pos = '0' and sig = '1') then
				next_state <= state_b;
			else
				next_state <= state_a;
			end if;
		end case;
	end process;

end moore_fsm;

-----------------------------------shifter -----------------------------
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

-------------------------------hex to seven segment ----------------------
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


--------------------top level-------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity spi_digit_driver is
    port(
        rst_bar   : in  std_logic; -- asynchronous system reset
        clk       : in  std_logic; -- system clock
        data_out  : out std_logic_vector(7 downto 0); -- parallel output data
        mosi      : in  std_logic; -- master out slave in SPI serial data
        sck       : in  std_logic; -- SPI shift clock to slave
        ss_bar    : in  std_logic; -- slave select signal
        seg_drive : out std_logic_vector(7 downto 0)  -- seven segment output
    );
end spi_digit_driver;


architecture spi_digit_driver of spi_digit_driver is
signal sig2shift_en : std_logic;
begin
	uut0 : entity edge_det port map (clk => clk, rst_bar => rst_bar, sig => sck, pos => '1', sig_edge => sig2shift_en);
		
	uut1 : entity slv_spi_rx_shifter 
		port map (
		shift_en => sig2shift_en, 
		rxd => mosi, 
		clk => clk,
		rst_bar => rst_bar,
		sel_bar => ss_bar, 
		rx_data_out => data_out
		);
	uut2 : entity hex_seven port map (hex => data_out(3 downto 0), seg_drive => seg_drive);
end spi_digit_driver;
