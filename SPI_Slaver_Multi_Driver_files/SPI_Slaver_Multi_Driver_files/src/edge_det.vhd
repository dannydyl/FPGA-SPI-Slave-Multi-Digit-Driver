-------------------------------------------------------------------------------
--
-- Title       : edge_det
-- Design      : prelab10
-- Author      : Dongyun Lee
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : W:\ESE382-Lab\Lab10\prelab10\prelab10\src\edge_det.vhd
-- Generated   : Sun Apr 21 16:52:52 2024
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : positive and negative edge detector
--
-------------------------------------------------------------------------------

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
