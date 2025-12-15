library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_delta_adc is
end entity tb_delta_adc;


architecture bhv_tb_delta_adc of tb_delta_adc is	
	signal pwm : std_ulogic := '0';
	signal cmp : std_ulogic := '0';
	signal clk : std_ulogic := '0';
	signal rst : std_ulogic := '0';
begin
	adc : entity work.boardADC
	generic map (
		RESOLUTION => std_package.ADC_BIT_WIDTH,
		SAMPLE_RATE => std_package.ADC_SAMPLE_SCALER
	)
	port map (		
		PWM_o => pwm,
		Comparator_i => cmp,
		Clk_i => clk,
		Reset_i => rst
	);
	
	clk <= not(clk) after 10 ns;
	
	
	stimuli : process begin
		rst <= '1';
		wait for 20 ns;
		rst <= '0';
		wait for 20 ns;
		cmp <= '1';
		wait for 60 ns;
		cmp <= '0';
		wait for 20 ns;
		cmp <= '1';
		
	end process;

end architecture;