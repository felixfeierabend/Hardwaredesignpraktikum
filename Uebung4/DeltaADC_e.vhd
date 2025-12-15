library ieee;
use ieee.std_logic_1164.all;

entity DeltaADC is 
generic (
	RESOLUTION : natural := 7
);
port (
	strobe_i : in std_ulogic;
	comparator_i : in std_ulogic;
	clk_i : in std_ulogic;
	rst_i : in std_ulogic;
	adc_val_o : out std_ulogic_vector(RESOLUTION - 1 downto 0);
	adc_valid_strb : out std_ulogic
);
end entity DeltaADC;