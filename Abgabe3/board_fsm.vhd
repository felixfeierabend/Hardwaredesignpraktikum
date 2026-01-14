library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity fsm_board is 
port (
	board_clk_i : in std_ulogic;
	board_rst_i : in std_ulogic;
	board_start_button_i : in std_ulogic;
	board_led_o : out std_ulogic := '0'
	);
end entity;

architecture bhv_fsm_board of fsm_board is 
	constant board_BITWIDTH : natural := 4;
	constant board_MAX_VALUE : natural := 9;
	
	signal clk_sync : std_ulogic_vector (1 downto 0);
	signal start_sync : std_ulogic_vector (1 downto 0);
	signal board_restart_strobe : std_ulogic := '0';
	signal counter_Value : std_ulogic_vector (board_BITWIDTH - 1 downto 0);
	signal board_led : std_ulogic := '0';
begin

	COUNTER : entity work.counter
	generic map (
		BITWIDTH => board_BITWIDTH
	)
	port map (
		clk_i => board_clk_i,
		rst_i => not(board_rst_i),
		restart_strobe_i => board_restart_strobe,
		counter_value_o => counter_value
	);
	
	FSM : entity work.fsm
	generic map (
		MAX_VALUE => board_MAX_VALUE,
		BITWIDTH => board_BITWIDTH
	)
	port map (
		clk_i => board_clk_i,
		rst_i => not(board_rst_i),
		counter_i => counter_value,
		start_button_i => not(start_sync(1)),
		counter_restart_strobe_o => board_restart_strobe,
		led_o => board_led
	);

	sync : process(board_clk_i, board_rst_i) 
	begin
		if board_rst_i = '1' then
			clk_sync <= "00";
			start_sync <= "00";		
		elsif rising_edge(board_clk_i) then
			clk_sync(1) <= clk_sync(0);
			clk_sync(0) <= board_clk_i;
			
			start_sync(1) <= start_sync(0);
			start_sync(0) <= board_start_button_i;
		end if;
			
	end process;

end architecture bhv_fsm_board;