library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

architecture bhv_cmd_proc of work.cmd_proc is 
	signal address : std_ulogic_vector (COMCNTBW - 1 downto 0);
	signal command_data : std_ulogic_vector (2 * SERVO_CNT_LEN - 1 downto 0);
begin
	cmd_rom : entity work.command_rom 
	port map (
		clock_i => clk_i,
		addr_i => address,
		data_o => command_data
	);
	
	
	
end architecture bhv_cmd_proc;