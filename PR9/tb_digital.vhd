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
signal dbg_en : std_ulogic := '0';
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
		sevenseg_o => sevenseg,
		dbg_en_i => dbg_en,
		dbg_valid_strb_i => '0',
		dbg_adc_val_i => (others => '0')
	);
	
	stimuli : process begin
		rst <= '1';
		wait for 20 ns;
		rst <= '0';		
		wait for 10 ms;
		cmp <= '1';
		wait for 80 ms;		
		wait for 20 ns;
		for i in 1 to 10000000 loop 
			cmp <= not cmp;
			wait for 20 ns;
		end loop;
		
	end process stimuli;
	

end architecture bhv_tb_digital;