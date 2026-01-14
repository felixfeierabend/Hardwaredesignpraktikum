library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package std_package is

	constant CLK_FREQ : natural := 50_000_000;
	constant ADC_PWM_FREQ : natural := 200_000;
	constant ADC_SAMPLE_FREQ : natural := 50;
	
	constant ADC_MAX_VAL : natural := integer(real(CLK_FREQ) / real(ADC_PWM_FREQ));
	
	constant ADC_SAMPLE_SCALER : natural := integer(real(CLK_FREQ) / real(ADC_SAMPLE_FREQ));
	
	
	constant T_PERIOD : real := 0.02;
	constant SERVO_MIN_TIME : real := 0.01;
	constant SERVO_MAX_TIME : real := 0.02;
	
	constant SERVO_PERIOD_TICKS : natural := integer(real(CLK_FREQ) * T_PERIOD);
	constant SERVO_MAX_TICKS : natural := integer(real(CLK_FREQ) * SERVO_MAX_TIME);
	constant SERVO_MIN_TICKS : natural := integer(real(SERVO_MAX_TICKS) / 2.0);
	
	
	constant SERVO_RANGE_TICKS : natural := SERVO_MAX_TICKS - SERVO_MIN_TICKS;
	
	constant SCALE_FACTOR_INPUT : natural := integer(real(SERVO_RANGE_TICKS) / 1000.0);	-- to calculate the scale-factor the input has to be multiplied in order to achieve the following scale-factors:
		
	-- 1000 -> 0°
	-- 2000 -> 180°
	
	constant BIT_WIDTH : natural := natural(ceil(log2(real(SERVO_MAX_TICKS))));
	constant ADC_BIT_WIDTH : natural := natural(ceil(log2(real(ADC_MAX_VAL))));
	
	constant TILT_SCALER : integer := integer(1.0 / real(SERVO_RANGE_TICKS));	
	constant COMCNTBW : natural := natural(ceil(log2(real(61))));
	constant SERVO_CNT_LEN : natural := BIT_WIDTH;


end package std_package;