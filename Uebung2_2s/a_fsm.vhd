library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;
use work.std_definitions.all;

architecture bhv_fsm of fsm is 
	signal led_fsm_state : led_fsm_state_type := START;
	signal next_led_fsm_state : led_fsm_state_type := START;
	signal restart : std_ulogic := '0';
begin
	
	fsm_proc : process(start_button_i, counter_i, led_fsm_state)
	begin
		next_led_fsm_state <= led_fsm_state;
		
		case led_fsm_state is 
			when START =>
				if start_button_i = '1' then
					next_led_fsm_state <= WAIT_COUNTER;
				end if;
				if rst_i = '1' then
					next_led_fsm_state <= START;
				end if;
			when WAIT_COUNTER =>
				if to_integer(unsigned(counter_i)) = MAX_VALUE then
					next_led_fsm_state <= LED_ON;
				end if;
			when LED_ON =>
				led_o <= '1';				
				if to_integer(unsigned(counter_i)) = MAX_VALUE then
					led_o <= '0';
					next_led_fsm_state <= START;
				end if;
				if rst_i = '1' then
					next_led_fsm_state <= START;
				end if;
			when others =>
				next_led_fsm_state <= START;
		end case;
	end process;
	
	strobe_proc : process(led_fsm_state, next_led_fsm_state, start_button_i)
	begin	
		if led_fsm_state = WAIT_COUNTER and next_led_fsm_state = LED_ON then
			restart <= '1';
		elsif led_fsm_state = START and start_button_i = '1' then
			restart <= '1';
		else
			restart <= '0';
		end if;
	end process;

	reg_proc : process(clk_i)
	begin
		if rising_edge(clk_i) then			
			if restart = '1' and not(led_fsm_state = WAIT_COUNTER) then
				counter_restart_strobe_o <= '1';
			else				
				counter_restart_strobe_o <= '0';
			end if;
			
			led_fsm_state <= next_led_fsm_state;
		end if;
	end process;
	
end architecture bhv_fsm;