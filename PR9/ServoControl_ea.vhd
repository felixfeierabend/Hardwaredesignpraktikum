library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;
use work.std_package.all;

entity servo_controller is 
port (
	clk_i : in std_ulogic;
	on_time_i : in natural;
	pwm_o : out std_ulogic;
	reset_i : in std_ulogic
);
end entity servo_controller;


architecture bhv_servo_controller of servo_controller is
	constant PWM_MIN_VAL : unsigned(SERVO_CNT_LEN - 1 downto 0) := to_unsigned(SERVO_MIN_TICKS, SERVO_CNT_LEN);
	constant PWM_PERIOD_VAL : unsigned(SERVO_CNT_LEN - 1 downto 0) := to_unsigned(SERVO_PERIOD_TICKS, SERVO_CNT_LEN);
	signal on_counter_val : unsigned (SERVO_CNT_LEN - 1 downto 0);
begin

	on_counter_val <= to_unsigned(SERVO_MIN_TICKS + on_time_i * SCALE_FACTOR_INPUT, SERVO_CNT_LEN);

	pwm : entity work.PWM
	generic map(
		COUNTER_LEN => SERVO_CNT_LEN
	)
	port map (
		clk_i => clk_i,
		reset_i => reset_i,
		Period_counter_val_i => PWM_PERIOD_VAL,
		On_counter_val_i => on_counter_val,
		PWM_pin_o => pwm_o
	);

end architecture bhv_servo_controller;