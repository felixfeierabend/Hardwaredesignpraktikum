library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity tb_digital is
end entity tb_digital;

architecture bhv_tb_digital of tb_digital is 
signal clk : std_ulogic := '0';
signal rst : std_ulogic := '0';
signal cmp : std_ulogic := '1';
signal pwm_adc : std_ulogic := '0';
signal pwm_servo : std_ulogic := '0';
signal sevenseg : std_ulogic_vector(0 to 20) := (others => '0');

begin
	
	clk <= not(clk) after 10 ns;
	
	axis : entity work.Tilt_board
	port map (
		clk_i => clk,
		rst_i => rst,
		x_comp_async_i => cmp,
		x_pwm_pin_o => pwm_adc,
		ServoX_pwm_pin_o => pwm_servo,
		sevenseg_o => sevenseg
	);

	rstproc : process begin
		rst <= '1';
		wait for 20 ns;
		rst <= '0';
	end process rstproc;

	stimuli : process begin
		cmp <= '0';
		wait for 20 ns;
		cmp <= '1';
		wait for 30 * 
		
	end process stimuli;
	

end architecture bhv_tb_digital;