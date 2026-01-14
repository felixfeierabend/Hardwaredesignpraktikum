library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pwm is 
end entity tb_pwm;

architecture bhv_tb_pwm of tb_pwm is 
	constant tb_COUNTER_LEN : natural := 4; 
	
	signal tb_clk : std_ulogic := '1';
	signal tb_rst : std_ulogic := '0';
	signal tb_pwm : std_ulogic := '1';
	signal tb_Period_counter_val_i : unsigned (tb_COUNTER_LEN - 1 downto 0) := "1000";
	signal tb_ON_counter_val_i : unsigned (tb_COUNTER_LEN - 1 downto 0) := "0100";
	
begin
	tb_clk <= not (tb_clk) after 1 ns;
	
	PWM : entity work.PWM 
	generic map (
		COUNTER_LEN => tb_COUNTER_LEN
	)
	port map (
		clk_i => tb_clk,
		reset_i => tb_rst,
		PWM_pin_o => tb_pwm,
		Period_counter_val_i => tb_Period_counter_val_i,
		ON_counter_val_i => tb_ON_counter_val_i
	);
	
	tb_proc : process
	begin
		tb_rst <= '1';
		wait for 2 ns;
		tb_rst <= '0';
		wait for 16 ns;
		tb_ON_counter_val_i <= "0000"; -- test duty cycle of 0%
		tb_rst <= '1';
		wait for 2 ns;
		tb_rst <= '0';
		wait for 16 ns;
		tb_ON_counter_val_i <= "1000"; -- test duty cycle of 100%
		wait for 16 ns;
		
	end process;

end architecture bhv_tb_pwm;