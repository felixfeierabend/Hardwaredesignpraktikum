library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity board_cmd_proc is 
	port (
		clk_i : in std_ulogic;
		rst_i : in std_ulogic;
		drawing_o : out std_ulogic;
		StartStrb_i : in std_ulogic;
		
		x_out : out std_ulogic_vector (std_package.BIT_WIDTH - 1 downto 0);
		y_out : out std_ulogic_vector (std_package.BIT_WIDTH - 1 downto 0);
		z_out : out std_ulogic_vector (std_package.BIT_WIDTH - 1 downto 0)
	);
end entity;

architecture bhv_board_cmd_proc of board_cmd_proc is
	constant PRESCALER : natural := 1000000;
begin
	cmd_proc : entity work.cmd_proc
	generic map (
		WAIT_PRESCALER => PRESCALER,
		D => std_package.BIT_WIDTH,
		SERVO_CNT_LEN => std_package.BIT_WIDTH
	)
	port map (
		clk_i => clk_i,
		rst_i => rst_i,
		drawing_o => drawing_o,
		StartStrb_i => StartStrb_i,
		x_out => x_out,
		z_out => z_out
	);

end architecture bhv_board_cmd_proc;