library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Tilt is 
	generic (
		RESOLUTION : natural := 7
	);
	port (
		HoldValue_i : in std_ulogic_vector (RESOLUTION - 1 downto 0);
		On_counter_val_o : out natural
	);
end entity Tilt;