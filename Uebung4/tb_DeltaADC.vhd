library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_delta_adc is 
end entity;

architecture bhv_tb_delta_adc of tb_delta_adc is
	constant RESOLUTION : natural := 3;
	constant SAMPLE_RATE : natural := 2;

	signal clk : std_ulogic := '0';
	signal adc_valid_strb : std_ulogic;
	signal pwm : std_ulogic;
	signal comparator : std_ulogic := '1';
	signal rst : std_ulogic := '0';
begin

	clk <= not(clk) after 500 ps;

	adc : entity work.boardADC 
	generic map (
		RESOLUTION => RESOLUTION,
		SAMPLE_RATE => SAMPLE_RATE
	)
	port map(
		ADC_valid_strb => adc_valid_strb,
		PWM_o => pwm,
		Comparator_i => comparator,
		Clk_i => clk,
		Reset_i => rst
	);

	stimuli : process
	begin
		rst <= '1';
		wait for 2 ns;
		rst <= '0';
		comparator <= '1';
		wait for 6 ns;
		comparator <= '0';
		wait for 2 ns;
		comparator <= '1';
		wait for 2 ns;
		
	end process stimuli;

end architecture;