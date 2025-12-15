library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;
use work.servo_package.all;

entity servo_controller is 
port (
	clk_i : in std_ulogic;
	on_time_i : in natural;
	pwm_o : out std_ulogic;
	reset_i : in std_ulogic
);
end entity servo_controller;
