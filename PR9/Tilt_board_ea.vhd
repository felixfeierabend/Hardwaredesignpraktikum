library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;
use work.std_package.all;

entity Tilt_board is 
	port (
		clk_i : in std_ulogic;
		rst_i : in std_ulogic;
		x_comp_async_i : in std_ulogic;

		dbg_en_i : in std_ulogic;
		dbg_adc_val_i : in std_ulogic_vector(std_package.ADC_BIT_WIDTH - 1 downto 0);
		dbg_adc_valid_strb_i : in std_ulogic;
		switchMovingAvg_i : in std_ulogic;

		x_pwm_pin_o : out std_ulogic;
		On_counter_val_tilt_o : out natural;
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
	signal binary : std_ulogic_vector (15 downto 0);

	signal moving_avg_data : unsigned(ADC_BIT_WIDTH - 1 downto 0);
	signal moving_avg_strb : std_ulogic;

	signal adc_val_hold_i : std_ulogic_vector(ADC_BIT_WIDTH - 1 downto 0);
	signal adc_strb_hold_i : std_ulogic;
	
	signal ones : std_ulogic_vector (3 downto 0);
	signal tens : std_ulogic_vector (3 downto 0);
	signal hundreds : std_ulogic_vector (3 downto 0);

	signal rst_n, increment_n, decrement_n : std_ulogic;
	
begin
	rst_n <= not(rst_i);

	binary <= NULL_MASK & HoldValue;

	adc_val_hold_i <= std_ulogic_vector(moving_avg_data) when switchMovingAvg_i = '1' else adc_val;
	adc_strb_hold_i <= moving_avg_strb when switchMovingAvg_i = '1' else adc_valid_strb;

	moving_avg : entity work.moving_avg
	generic map (
		BITWIDTH => ADC_BIT_WIDTH,
		REG_LENGTH => REG_LENGTH
	)
	port map (
		clk_i => clk_i,
		reset_i => rst_n,
		strb_data_valid_i => adc_valid_strb,
		data_i => unsigned(adc_val),
		strb_data_valid_o => moving_avg_strb,
		data_o => moving_avg_data
	);
	
	x_comp_sync : entity work.synchronizer_chain
	generic map (
		CHAIN_LENGTH => SYNC_CHAIN_LENGTH
	)
	port map (
		clk_i => clk_i,
		rst_i => rst_n,
		input_i => x_comp_async_i,
		output_o => comp_sync
	);

	adc : entity work.DeltaADC
	port map (
		adc_val_o => adc_val,
		adc_valid_strb => adc_valid_strb,
		pwm_o => x_pwm_pin_o,
		comparator_i => comp_sync,
		clk_i => clk_i,
		rst_i => rst_n,
		dbg_en_i => dbg_en_i,
		dbg_valid_strb_i => dbg_adc_valid_strb_i,
		dbg_adc_val_i => dbg_adc_val_i
	);
	
	holdValOnStrb : entity work.HoldValueOnStrb
	generic map (
		RESOLUTION => RESOLUTION
	)
	port map (
		clk_i => clk_i,
		rst_i => rst_n,
		ADC_valid_strb_i => adc_strb_hold_i,
		ADC_value_i => adc_val_hold_i,
		HoldValue_o => HoldValue
	);
	
	tilt : entity work.Tilt
	generic map (
		RESOLUTION => RESOLUTION
	)
	port map (
		HoldValue_i => HoldValue,
		On_counter_val_o => On_counter_val_tilt_o
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