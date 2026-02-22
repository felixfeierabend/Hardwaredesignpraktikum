library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity tb_periodical_strb_gen is
end entity;

architecture bhv_tb_periodical_strb_gen of tb_periodical_strb_gen is
	constant PRESCALER : natural := 10;
	signal clk : std_ulogic := '0';
	signal rst : std_ulogic := '1';
	signal sync_rst : std_ulogic := '0';
	
begin

	dut : entity work.periodical_strb_gen
	generic map (
		PRESCALER => PRESCALER
	)
	port map (
		clk_i => clk,
		rst_i => rst,
		sync_rst_i => sync_rst,
		strb_o => open
	);
	
	clk <= not clk after 10 ns;
	
	stimuli : process 
	begin
		rst <= '1';
		wait for 20 ns;
		rst <= '0';
		wait for 230 ns;
		rst <= '1';
		wait for 20 ns;
		rst <= '0';
		wait for 730 ns;
	end process stimuli;

end architecture bhv_tb_periodical_strb_gen;