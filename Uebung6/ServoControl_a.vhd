library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

architecture bhv_servo_controller of servo_controller is
	signal on_counter_val : unsigned (BIT_WIDTH - 1 downto 0);
begin
	on_counter_val <= to_unsigned(on_time_i * SCALE_FACTOR_INPUT, BIT_WIDTH);

	pwm : entity work.PWM
	generic map(
		COUNTER_LEN => BIT_WIDTH
	)
	port map (
		clk_i => clk_i,
		reset_i => reset_i,
		Period_counter_val_i => to_unsigned(SERVO_MAX_TICKS, BIT_WIDTH),
		On_counter_val_i => on_counter_val,
		PWM_pin_o => pwm_o
	);

end architecture bhv_servo_controller;