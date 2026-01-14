library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity Tilt_board is 
	port (
		clk_i : in std_ulogic;
		rst_i : in std_ulogic;
		x_comp_async_i : in std_ulogic;
		x_pwm_pin_o : out std_ulogic;
		ServoX_pwm_pin_o : out std_ulogic;
		sevenseg_o : out std_ulogic_vector(0 to 20)
	);
end entity Tilt_board;

architecture bhv_Tilt_board of Tilt_board is
	constant RESOLUTION : natural := std_package.ADC_BIT_WIDTH;
	constant SYNC_CHAIN_LENGTH : natural := 2;
	constant NULL_MASK : std_ulogic_vector (RESOLUTION - 1 downto 0) := (others => '0');
	
	signal HoldValue : std_ulogic_vector(RESOLUTION - 1 downto 0) := (others => '0');
	signal adc_valid_strb : std_ulogic;
	signal adc_val : std_ulogic_vector (std_package.ADC_BIT_WIDTH - 1 downto 0);
	signal comp_sync : std_ulogic;
	signal On_counter_val : natural;
	signal binary : std_ulogic_vector (15 downto 0);
	
	signal ones : std_ulogic_vector (3 downto 0);
	signal tens : std_ulogic_vector (3 downto 0);
	signal hundreds : std_ulogic_vector (3 downto 0);
	
begin

	binary <= NULL_MASK & HoldValue;
	
	sync_in : entity work.synchronizer_chain
	generic map (
		CHAIN_LENGTH => SYNC_CHAIN_LENGTH
	)
	port map (
		clk_i => clk_i,
		rst_i => rst_i,
		input_i => x_comp_async_i,
		output_o => comp_sync
	);
	
	adc : entity work.boardADC
	generic map (
		RESOLUTION => std_package.ADC_BIT_WIDTH,
		SAMPLE_RATE => std_package.ADC_SAMPLE_SCALER
	)
	port map (
		ADC_val_o => adc_val,
		ADC_valid_strb => adc_valid_strb,
		PWM_o => x_pwm_pin_o,
		Comparator_i => comp_sync,
		Clk_i => clk_i,
		Reset_i => rst_i
	);
	
	holdValOnStrb : entity work.HoldValueOnStrb
	generic map (
		RESOLUTION => RESOLUTION
	)
	port map (
		clk_i => clk_i,
		rst_i => rst_i,
		ADC_valid_strb_i => adc_valid_strb,
		ADC_value_i => adc_val,
		HoldValue_o => HoldValue
	);
	
	tilt : entity work.Tilt
	generic map (
		RESOLUTION => RESOLUTION
	)
	port map (
		HoldValue_i => HoldValue,
		On_counter_val_o => On_counter_val
	);
	
	servoPwm : entity work.servo_controller
	port map (
		clk_i => clk_i,
		on_time_i => On_counter_val,
		pwm_o => ServoX_pwm_pin_o,
		reset_i => rst_i
	);
	
	bin2bcd : entity work.bin2bcd
	port map (
		binary_i => binary,
 		ones_o => ones,
		tens_o => tens,
		hundreds_o => hundreds,
		thousands_o => open,
		tenthousands_o => open
	);
	
	bcd2sevenseg_ones : entity work.bcd_to_7seg
	port map (
		bcd_i => ones,
		LED_o => sevenseg_o(0 to 6)
	);
	
	bcd2sevenseg_tens : entity work.bcd_to_7seg
	port map (
		bcd_i => tens,
		LED_o => sevenseg_o(7 to 13)
	);
	
	bcd2sevenseg_hundreds : entity work.bcd_to_7seg
	port map (
		bcd_i => hundreds,
		LED_o => sevenseg_o(14 to 20)
	);
	
end architecture bhv_Tilt_board;