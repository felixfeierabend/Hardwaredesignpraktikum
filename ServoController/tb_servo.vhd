library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_servo is 
end entity;

architecture bhv_tb_servo of tb_servo is 
	signal tb_clk : std_ulogic := '0';
	signal on_time : natural := 1000;
	signal pwm : std_ulogic := '0';
	signal reset : std_ulogic := '0';
begin
	tb_clk <= not(tb_clk) after 10 ns;

	servo : entity work.servo_controller
	port map(
		clk_i => tb_clk,
		on_time_i => on_time,
		pwm_o => pwm,
		reset_i => reset
	);
	
	tb_proc : process begin
		on_time <= 1000;
		wait for 2 ms;
		
		on_time <= 1500;
		wait for 2 ms;
		
		on_time <= 2000;
		wait for 2ms;
		
	end process;

end architecture bhv_tb_servo;