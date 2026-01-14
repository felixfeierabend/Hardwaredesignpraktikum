library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is 
	generic ( 
		MAX_VALUE : natural := 7;
		BITWIDTH : natural := 3
	);
	port(
		clk_i : in std_ulogic;
		rst_i : in std_ulogic;
		counter_i : in std_ulogic_vector (BITWIDTH - 1 downto 0);
		start_button_i : in std_ulogic;
		counter_restart_strobe_o : out std_ulogic := '0';
		led_o : out std_ulogic := '0'
	);
end entity;