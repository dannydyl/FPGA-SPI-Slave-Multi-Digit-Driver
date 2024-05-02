--
-- Synopsys
-- Vhdl wrapper for top level design, written on Wed May  1 09:35:44 2024
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wrapper_for_spi_mux_digit_driver is
   port (
      rst_bar : in std_logic;
      clk : in std_logic;
      mosi : in std_logic;
      sck : in std_logic;
      ss_bar : in std_logic;
      sel : in std_logic_vector(1 downto 0);
      seg_drive : out std_logic_vector(7 downto 0)
   );
end wrapper_for_spi_mux_digit_driver;

architecture spi_mux_digit_driver of wrapper_for_spi_mux_digit_driver is

component spi_mux_digit_driver
 port (
   rst_bar : in std_logic;
   clk : in std_logic;
   mosi : in std_logic;
   sck : in std_logic;
   ss_bar : in std_logic;
   sel : in std_logic_vector (1 downto 0);
   seg_drive : out std_logic_vector (7 downto 0)
 );
end component;

signal tmp_rst_bar : std_logic;
signal tmp_clk : std_logic;
signal tmp_mosi : std_logic;
signal tmp_sck : std_logic;
signal tmp_ss_bar : std_logic;
signal tmp_sel : std_logic_vector (1 downto 0);
signal tmp_seg_drive : std_logic_vector (7 downto 0);

begin

tmp_rst_bar <= rst_bar;

tmp_clk <= clk;

tmp_mosi <= mosi;

tmp_sck <= sck;

tmp_ss_bar <= ss_bar;

tmp_sel <= sel;

seg_drive <= tmp_seg_drive;



u1:   spi_mux_digit_driver port map (
		rst_bar => tmp_rst_bar,
		clk => tmp_clk,
		mosi => tmp_mosi,
		sck => tmp_sck,
		ss_bar => tmp_ss_bar,
		sel => tmp_sel,
		seg_drive => tmp_seg_drive
       );
end spi_mux_digit_driver;
