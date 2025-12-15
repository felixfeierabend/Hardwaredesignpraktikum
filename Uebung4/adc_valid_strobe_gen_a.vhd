library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

architecture bhv_adc_valid_strobe_gen is 
	signal prev_comp_val : std_ulogic;
begin
	
	strobe_proc : process(clk_i, rst_i)
	begin
		if (rst_i) then
			prev_comp_val <= comparator_val_i;
		elsif (rising_edge(clk_i)) then
			prev_comp_val <= comparator_val_i;
		end if;
	end process strobe_proc;
	
	comp_proc : process(comparator_val_i)
	begin
		strobe_o <= prev_comp_val xor comparator_val_i;
	end process comp_proc;
	
end architecture;