library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

architecture bhv_boardADC of boardADC is 
	signal sampling_strb : std_ulogic;
	signal adc_value : std_ulogic_vector (std_package.ADC_BIT_WIDTH - 1 downto 0);
begin
	
	adc_val_o <= adc_value;

	strobe_gen : entity work.strobe_generator
	generic map (
		STROBE_FREQ => SAMPLE_RATE
	)
	port map (
		strb_o => sampling_strb,
		clk_i => Clk_i
	);
	
	pwm : entity work.pwm
	generic map (
		COUNTER_LEN => std_package.ADC_BIT_WIDTH
	)
	port map (
		clk_i => Clk_i,
		reset_i => Reset_i,
		Period_counter_val_i => to_unsigned(std_package.ADC_MAX_VAL, std_package.ADC_BIT_WIDTH),
		ON_counter_val_i => unsigned(adc_value),
		PWM_pin_o => PWM_o
	);
	
	delta_adc : entity work.DeltaADC
	generic map (
		RESOLUTION => std_package.ADC_BIT_WIDTH
	)
	port map (
		strobe_i => sampling_strb,
		comparator_i => comparator_i,
		clk_i => Clk_i,
		rst_i => Reset_i,
		adc_val_o => adc_value,
		adc_valid_strb => ADC_valid_strb
	);
	
end architecture bhv_boardADC;