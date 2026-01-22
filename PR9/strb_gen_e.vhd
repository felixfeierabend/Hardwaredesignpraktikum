library ieee;
use ieee.std_logic_1164.all;

entity strobe_generator is
generic(
	STROBE_FREQ : natural
);
port(
	clk_i : in std_ulogic;
	rst_i : in std_ulogic;
	strb_o : out std_ulogic := '0'
);

end entity strobe_generator;