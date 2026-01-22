library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HoldValueOnStrb is
	generic (
		RESOLUTION : natural := 7
	);
	port (
		ADC_valid_strb_i : in std_ulogic;
		clk_i : in std_ulogic;
		rst_i : in std_ulogic;
		ADC_value_i : in std_ulogic_vector (RESOLUTION - 1 downto 0);
		HoldValue_o : out std_ulogic_vector (RESOLUTION - 1 downto 0)
	);
end entity HoldValueOnStrb;