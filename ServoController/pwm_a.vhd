library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

architecture Bhv_Pwm of Pwm is 
signal counter_value : std_ulogic_vector (COUNTER_LEN - 1 downto 0);
signal next_counter_value : std_ulogic_vector (COUNTER_LEN - 1 downto 0);

begin
	counter_proc : process (clk_i, reset_i)
	begin
		if (reset_i = '1')  then
			counter_value <= (others => '0');
		elsif rising_edge(clk_i) then
			counter_value <= next_counter_value;
		end if;
	end process;
	
	output_proc : process (counter_value)
	begin
		next_counter_value <= std_ulogic_vector(unsigned(counter_value) + to_unsigned(1, COUNTER_LEN - 1));
	
		if unsigned (counter_value) < ON_counter_val_i then			
			PWM_pin_o <= '1';
		elsif unsigned(counter_value) < Period_counter_val_i then
			PWM_pin_o <= '0';
		else
			next_counter_value <= (others => '0');
		end if;		
	end process;

end architecture Bhv_Pwm;

