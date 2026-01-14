library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.all;

entity tb_moving_avg is 
end entity;

architecture bhv_tb_moving_avg of tb_moving_avg is
constant RESOLUTION : natural := 4;
constant N : natural := 2;
signal clk : std_ulogic := '1';
signal rst : std_ulogic := '0';
signal data_valid_strb : std_ulogic := '0';
signal data_in : unsigned (RESOLUTION - 1 downto 0);
signal data_o : unsigned (RESOLUTION - 1 downto 0);

begin
	shift_register : entity work.shift_register
	generic map (
		BITWIDTH => RESOLUTION,
		REG_LENGTH => N
	)
	port map (
		clk_i => clk,
		reset_i => rst,
		strb_data_valid_i => data_valid_strb,
		data_i => data_in,
		data_o => data_o,
		strb_data_valid_o => open
	);
	
	clk <= not(clk) after 10 ns;
	
	stimuli : process begin
		rst <= '1';
		wait for 20 ns;
		rst <= '0';
		data_in <= to_unsigned(12, 4);
		data_valid_strb <= '1';
		wait for 20 ns;
		data_valid_strb <= '0';
		data_in <= to_unsigned (8, 4);
		wait for 20 ns;
		data_valid_strb <= '1';
		wait for 20 ns;
		data_in <= to_unsigned(10, 4);
		wait for 20 ns;
		data_in <= to_unsigned(1, 4);
		wait for 20 ns;
		data_in <= to_unsigned(5, 4);
		wait for 20 ns;
		data_in <= to_unsigned(4, 4);
		wait for 20 ns;
		data_in <= to_unsigned(7, 4);
		wait for 20 ns;
		data_in <= to_unsigned(9, 4);
		wait for 20 ns;
		
	end process stimuli;

end architecture bhv_tb_moving_avg;