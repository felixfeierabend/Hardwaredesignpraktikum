library ieee;
use work.all;

package std_definitions is 
	type led_fsm_state_type is (START, WAIT_COUNTER, LED_ON);
end package std_definitions;