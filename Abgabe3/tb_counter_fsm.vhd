library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_fsm_counter is 
end entity;

architecture bhv_tb_fsm_counter of tb_fsm_counter is
	constant tb_BITWIDTH : natural := 4;
	constant tb_MAX_VALUE : natural := 9;
	
	signal tb_rst : std_ulogic := '0';
	signal tb_clk : std_ulogic := '1';
	signal tb_counter_value : std_ulogic_vector (tb_BITWIDTH - 1 downto 0) := (others => '0');
	signal tb_start_button : std_ulogic := '0';
	signal tb_restart_strobe : std_ulogic := '0';
	signal tb_led : std_ulogic := '0';
	
begin

	tb_clk <= not(tb_clk) after 1 ns;

	COUNTER : entity work.counter
	generic map (
		BITWIDTH => tb_BITWIDTH
	)
	port map (
		clk_i => tb_clk,
		rst_i => tb_rst,
		restart_strobe_i => tb_restart_strobe,
		counter_value_o => tb_counter_value
	);
	
	FSM : entity work.fsm
	generic map (
		MAX_VALUE => tb_MAX_VALUE,
		BITWIDTH => tb_BITWIDTH
	)
	port map (
		clk_i => tb_clk,
		rst_i => tb_rst,
		counter_i => tb_counter_value,
		start_button_i => tb_start_button,
		counter_restart_strobe_o => tb_restart_strobe,
		led_o => tb_led
	);

	tb_func : process
	begin
		tb_start_button <= '1';
		wait for 3 ns;
		tb_start_button <= '0';
		wait for 4 ns;
		tb_rst <= '1';
		wait for 2 ns;
		tb_rst <= '0';
		wait for 2 ns;
		tb_start_button <= '1';
		wait for 2 ns;
		tb_start_button <= '0';
		wait for 35 ns;
		
		
	end process;
	
end architecture bhv_tb_fsm_counter;