library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.all;

architecture bhv_Tilt of Tilt is
begin
	scale_proc : process(HoldValue_i) begin
		On_counter_val_o <= std_package.SERVO_MIN_TICKS + integer(to_integer(unsigned(HoldValue_i)) * std_package.TILT_SCALER);
	end process scale_proc;
	
end architecture bhv_Tilt;
