library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package std_package is

	-- general constants

	constant CLK_FREQ : natural := 50_000_000;

	-- ADC-constants/configuration-values

	constant ADC_PWM_FREQ : natural := 200_000;
	constant ADC_SAMPLE_FREQ : natural := 50;

	constant ADC_MAX_VAL : natural := integer(floor(real(CLK_FREQ) / real(ADC_PWM_FREQ)));
	constant ADC_MIN_VAL : natural := integer(floor(real(ADC_MAX_VAL) / 2.0));
	constant ADC_MEAN_VAL : natural := integer(floor(real(ADC_MAX_VAL - ADC_MIN_VAL) / 2.0));
	constant ADC_SAMPLE_SCALER : natural := integer(floor(real(CLK_FREQ) / real(ADC_SAMPLE_FREQ)));

	-- Servo-constants

	constant T_PERIOD : real := 0.02;
	constant SERVO_FREQ : natural := 50;
	constant SERVO_MIN_TIME : real := 0.001;
	constant SERVO_MAX_TIME : real := 0.002;
	
	constant SERVO_PERIOD_TICKS : natural := integer(real(CLK_FREQ) * T_PERIOD);
	constant SERVO_MAX_TICKS : natural := integer(real(CLK_FREQ) * real(SERVO_MAX_TIME));
	constant SERVO_MIN_TICKS : natural := integer(real(SERVO_MIN_TIME) * real(CLK_FREQ));
	constant SERVO_MEAN_TICKS : natural := integer((real(SERVO_MAX_TICKS) + real(SERVO_MIN_TICKS)) / 2.0);
	constant SERVO_CNT_LEN : natural := integer(ceil(log2(real(SERVO_PERIOD_TICKS))));
	constant SERVO_RANGE_TICKS : natural := SERVO_MAX_TICKS - SERVO_MIN_TICKS + 1;
	constant SERVO_RANGE_LEN : natural := integer(ceil(log2(real(SERVO_RANGE_TICKS))));
	constant SCALE_FACTOR_INPUT : natural := integer(real(SERVO_RANGE_TICKS) / real(ADC_MAX_VAL));

	constant PEN_DOWN_VAL : natural := 0;
	constant PEN_UP_VAL : natural := 2**SERVO_CNT_LEN - 1;

	-- tilt-constants

	constant MIN_VOLTAGE : real := 2.0;
	constant MAX_VOLTAGE : real := 3.0;
	constant SUPPLY_VOLTAGE : real := 3.0;

	constant TILT_MIN_VAL : natural := natural(floor(real(ADC_SAMPLE_SCALER) * MIN_VOLTAGE / SUPPLY_VOLTAGE));
	constant TILT_MAX_VAL : natural := natural(floor(real(ADC_SAMPLE_SCALER) * MAX_VOLTAGE / SUPPLY_VOLTAGE));
	
	constant TILT_RANGE : natural := TILT_MAX_VAL - TILT_MIN_VAL;
	constant TILT_OUT_BITWIDTH : natural := natural(ceil(log2(real(TILT_RANGE))));

	constant BIT_WIDTH : natural := natural(ceil(log2(real(SERVO_MAX_TICKS))));
	constant ADC_BIT_WIDTH : natural := natural(ceil(log2(real(ADC_MAX_VAL))));

	-- filter constants
	constant REG_LENGTH : natural := 4;

	--cmd proc constants
	constant CMD_SCALER : natural := integer(floor(real(CLK_FREQ) / real(SERVO_FREQ)));

	-- debounce
	
	constant DEBOUNCE_DELAY_TIME : real := 0.02;
	constant DEBOUNCE_DELAY_CLK_CYCLES : natural := natural(ceil(real(CLK_FREQ) * DEBOUNCE_DELAY_TIME));

end package std_package;