library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

architecture bhv_counter of counter is 
signal next_counter : std_ulogic_vector(BITWIDTH - 1 downto 0);
signal counter_val : std_ulogic_vector (BITWIDTH - 1 downto 0);
begin
	reg_proc : process(clk_i)
	begin
		if rising_edge(clk_i) then
			if restart_strobe_i = '1' then
				next_counter <= (BITWIDTH - 2 downto 0 => '0') & '1';
				counter_value_o <= (others => '0');
			else 
				next_counter <= std_ulogic_vector(unsigned(next_counter) + to_unsigned(1, BITWIDTH));
				counter_value_o <= next_counter;
			end if;		
		
			if rst_i = '1' then
				next_counter <= (others => '0');
				counter_value_o <= next_counter;
			end if;		
		end if;		
	end process;
end architecture bhv_counter;