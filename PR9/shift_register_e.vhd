library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_register is
	generic (
		REG_LENGTH : natural; -- LOG2 von N + 1
		BITWIDTH : natural
	);
	port (
		clk_i : in std_ulogic;
		reset_i : in std_ulogic;
		strb_data_valid_i : in std_ulogic;
		data_i : in unsigned(BITWIDTH - 1 downto 0);
		
		strb_data_valid_o : out std_ulogic;
		data_o : out unsigned(BITWIDTH - 1 downto 0)
	);

end entity shift_register;