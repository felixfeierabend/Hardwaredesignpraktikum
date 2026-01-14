library ieee;
use ieee.std_logic_1164.all;

entity boardADC is
generic (
	RESOLUTION : natural := 7;
	SAMPLE_RATE : natural := 7
);
port(
	ADC_val_o : out std_ulogic_vector(RESOLUTION - 1 downto 0);
	ADC_valid_strb : out std_ulogic;
	PWM_o : out std_ulogic;
	Comparator_i : in std_ulogic;
	Clk_i : in std_ulogic;
	Reset_i : in std_ulogic
);
end entity boardADC;