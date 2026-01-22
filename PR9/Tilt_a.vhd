library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.std_package.all;

architecture bhv_Tilt of Tilt is
	constant MIN_VALUE : signed(RESOLUTION downto 0) := to_signed(TILT_MIN_VAL, RESOLUTION + 1);
begin
	scale_proc : process(HoldValue_i) is
		variable servo_value : signed(RESOLUTION downto 0);
	begin
		servo_value := signed('0' & HoldValue_i) - MIN_VALUE;
		On_counter_val_o <= to_integer(unsigned(servo_value(RESOLUTION - 1 downto 0)));
	end process scale_proc;
	
end architecture bhv_Tilt;
