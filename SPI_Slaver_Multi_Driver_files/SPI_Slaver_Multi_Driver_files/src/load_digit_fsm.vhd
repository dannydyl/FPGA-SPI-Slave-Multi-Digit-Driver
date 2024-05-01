-------------------------------------------------------------------------------
--
-- Title       : load_digit_fsm
-- Design      : prelab11
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : \\Mac\Home\Documents\SBU 2024 Spring\ESE 382\Prelab11\Prelab11\prelab11\src\load_digit_fsm.vhd
-- Generated   : Tue Apr 30 00:02:22 2024
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


entity load_digit_fsm is
    port (
        rst_bar : in std_logic; -- asynchronous system reset
        clk : in std_logic; -- system clock
        ss_bar_pe : in std_logic; -- positive edge of ss_bar detected
        ld_cmd : in std_logic; -- bit 7 is '1' for load command
        load_dig : out std_logic -- enable a hex_digit to be loaded
    );
end load_digit_fsm;

architecture moore_fsm of load_digit_fsm is
type state is (wait_for_sb_0, wait_for_sb_1, wait_ldc_1, output_state);
signal present_state, next_state : state;
begin
	-- first state : detects rst_bar
	state_reg : process (clk, rst_bar)
	begin
		if rst_bar = '0' then
			present_state <= wait_for_sb_0;
		elsif rising_edge(clk) then
			present_state <= next_state;
		end if;
	end process;
		
	-- process where it outputs
	outputs: process (present_state)
	begin
		case present_state is
			when output_state => load_dig <= '1';
			when others => load_dig <= '0';
		end case;
	end process;
	
	nxt_state: process (present_state, ss_bar_pe, ld_cmd)
	begin
		case present_state is
			when wait_for_sb_0 =>
			if ss_bar_pe = '0' then
				next_state <= wait_for_sb_1;
			else
				next_state <= wait_for_sb_0;
			end if;
			
			when wait_for_sb_1 =>
			if ss_bar_pe = '1' then
				next_state <= wait_ldc_1;
			else
				next_state <= wait_for_sb_1;
			end if;
			
			when wait_ldc_1 =>
			if ld_cmd = '1' then
				next_state <= output_state;
			else
				next_state <= wait_ldc_1;
			end if;
			
			when output_state =>
			next_state <= wait_for_sb_0;
			
			when others =>
			next_state <= wait_for_sb_0;
			
		end case;
	end process;

end moore_fsm;
