library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity adc_valid_strobe_gen is
	port (
		clk_i : in std_ulogic;
		rst_i : in std_ulogic;
		comparator_val : in std_ulogic;
		strobe_o : out std_ulogic;
	);
end entity;