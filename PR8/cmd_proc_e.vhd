library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cmd_proc is 
	generic (
		SERVO_CNT_LEN : natural
	)
	port (
		clk_i : in std_ulogic;
		rst_i : in std_ulogic;
		x_out : out std_ulogic_vector (SERVO_CNT_LEN - 1 downto 0);
		y_out : out std_ulogic_vector (SERVO_CNT_LEN - 1 downto 0);
		z_out : out std_ulogic_vector (SERVO_CNT_LEN - 1 downto 0);
	);
end entity;