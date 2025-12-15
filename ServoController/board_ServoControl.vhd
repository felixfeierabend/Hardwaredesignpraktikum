library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity board_servo_control is
port (
	clk_i : in std_ulogic;
	reset_i : in std_ulogic;
	pwm_o : out std_ulogic;
	on_counter_val_i : in std_ulogic_vector (16 downto 0)
);
end entity;


architecture bhv_board_servo_control of board_servo_control is
constant BIT_LENGTH : natural := 17;
signal on_counter : std_ulogic_vector (BIT_LENGTH - 1 downto 0) := (OTHERS => '1');

begin
	
	sync_on_counter_in : entity work.vector_synchronizer 
	generic map (
		BIT_LENGTH => BIT_LENGTH
	)
	port map (
		clk_i => clk_i,
		vector_i => on_counter_val_i,
		vector_o => on_counter
	);

	servo_controller : entity work.servo_controller
	port map (
		clk_i => clk_i,
		reset_i => reset_i,
		pwm_o => pwm_o,
		on_time_i => to_integer(unsigned(on_counter))
	);	

end architecture;
