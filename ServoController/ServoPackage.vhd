library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package servo_package is

	constant CLK_FREQ : natural := 50_000_000;
	
	constant T_PERIOD : real := 0.02;
	constant SERVO_MIN_TIME : real := 0.01;
	constant SERVO_MAX_TIME : real := 0.02;
	
	constant SERVO_PERIOD_TICKS : natural := integer(real(CLK_FREQ) * T_PERIOD);
	constant SERVO_MIN_TICKS : natural := integer(real(CLK_FREQ) * SERVO_MIN_TIME);
	constant SERVO_MAX_TICKS : natural := integer(real(CLK_FREQ) * SERVO_MAX_TIME);
	
	constant SERVO_RANGE_TICKS : natural := SERVO_MAX_TICKS - SERVO_MIN_TICKS;
	
	constant SCALE_FACTOR_INPUT : natural := integer(real(SERVO_RANGE_TICKS) / 1000.0);	-- to calculate the scale-factor the input has to be multiplied in order to achieve the following scale-factors:
	
	-- 1000 -> 0°
	-- 2000 -> 180°

end package servo_package;