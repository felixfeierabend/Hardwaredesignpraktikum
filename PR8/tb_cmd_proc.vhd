library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_cmd_proc is 
end entity tb_cmd_proc;

architecture bhv_tb_cmd_proc of tb_cmd_proc is
	constant PRESCALER : natural := 2;
	signal clk : std_ulogic := '0';
	signal rst : std_ulogic := '0';
	signal start_strb : std_ulogic := '0';
begin
	clk <= not clk after 10 ns;
	
	dut : entity work.cmd_proc
	generic map (
		SERVO_CNT_LEN => std_package.BIT_WIDTH,
		WAIT_PRESCALER => PRESCALER,
		D => std_package.BIT_WIDTH
	)
	port map (
		clk_i => clk,
		rst_i => rst,
		StartStrb_i => start_strb,
		x_out => open,
		y_out => open,
		z_out => open
	);
	
	stimuli : process 
	begin
		rst <= '1';
		wait for 20 ns;
		rst <= '0';
		wait for 40 ns;
		start_strb <= '1';
		wait for 20 ns;
		start_strb <= '0';
		wait for 3 ms;
	end process stimuli;
		

end architecture bhv_tb_cmd_proc;