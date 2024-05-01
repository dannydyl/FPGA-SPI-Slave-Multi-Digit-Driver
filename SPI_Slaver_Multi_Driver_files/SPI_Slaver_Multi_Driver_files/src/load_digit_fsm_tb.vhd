-------------------------------------------------------------------------------
--
-- Title       : load_digit_fsm_tb
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\load_digit_fsm_tb.vhd
-- Generated   : Tue Apr 30 01:08:38 2024
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

entity load_digit_fsm_tb is
end load_digit_fsm_tb;

architecture load_digit_fsm_tb of load_digit_fsm_tb is
-- Signals for the FSM inputs and outputs
signal rst_bar   : std_logic;
signal clk       : std_logic;
signal ss_bar_pe : std_logic;
signal ld_cmd    : std_logic;
signal load_dig  : std_logic;	

begin
UUT: entity load_digit_fsm
        port map (
            rst_bar   => rst_bar,
            clk       => clk,
            ss_bar_pe => ss_bar_pe,
            ld_cmd    => ld_cmd,
            load_dig  => load_dig
        );

	-- Clock process
	clocking : process
	begin
	    while true loop
	        clk <= '0';
	        wait for 10 ns;  -- Clock low for 10 ns
	        clk <= '1';
	        wait for 10 ns;  -- Clock high for 10 ns
	    end loop;
	end process;
-- Test stimulus process
stim_proc : process
begin
    -- Initial Reset
    rst_bar <= '0';
	ss_bar_pe <= '0';
	ld_cmd <= '0';
    wait for 100 ns;  -- Hold reset for a few clock cycles
    rst_bar <= '1';
    wait for 100 ns;  -- Wait after reset is de-asserted

    -- First event: simulating ss_bar_pe positive edge
    ss_bar_pe <= '1';
    wait for 40 ns;  -- Wait long enough for FSM to detect ss_bar_pe

    -- Second event: simulating ld_cmd being '1'
    ld_cmd <= '1';
    wait for 80 ns;  -- Wait long enough for FSM to detect ld_cmd

    -- Both ss_bar_pe and ld_cmd are '1', now the FSM should transition to output_state
    -- FSM should now output '1' on load_dig signal
    -- Wait and observe the load_dig signal in the waveform viewer
    wait for 40 ns;

    -- De-assert ld_cmd and ss_bar_pe to observe FSM returning to wait state
    ld_cmd <= '0';
    ss_bar_pe <= '0';
    wait for 40 ns;

    -- Asserting only ss_bar_pe to '1' to ensure FSM does not transition to output_state incorrectly
    ss_bar_pe <= '1';
    wait for 40 ns;

    -- End the simulation
    wait;
end process;

end load_digit_fsm_tb;
