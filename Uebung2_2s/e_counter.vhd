library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	generic ( BITWIDTH : natural := 7);
	port (
		clk_i : in std_ulogic;
		restart_strobe_i : in std_ulogic;
		rst_i : in std_ulogic;
		counter_value_o : out std_ulogic_vector(BITWIDTH - 1 downto 0) := (others => '0')
	);
end entity counter;