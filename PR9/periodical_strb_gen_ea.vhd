library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity periodical_strb_gen is
	generic (
		PRESCALER : natural
	);
	port (
		clk_i : in std_ulogic;
		rst_i : in std_ulogic;
		sync_rst_i : in std_ulogic;
		strb_o : out std_ulogic
	);
end entity periodical_strb_gen;

architecture bhv_strb_gen of periodical_strb_gen is
	signal sync_rst : std_ulogic;
begin
	strb_gen : entity work.strobe_generator
	generic map (
		STROBE_FREQ => PRESCALER
	)
	port map (
		clk_i => clk_i,
		rst_i => sync_rst,
		strb_o => strb_o
	);

	reg_proc : process(clk_i, rst_i)
	begin
		if rst_i = '1' then
			sync_rst <= '1';
		elsif rising_edge(clk_i) then
			sync_rst <= sync_rst_i;
		end if;
	end process reg_proc;

end architecture bhv_strb_gen;