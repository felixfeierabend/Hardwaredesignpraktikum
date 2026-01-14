library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

architecture bhv_HoldValueOnStrb of HoldValueOnStrb is 
	signal last_valid_value : std_ulogic_vector(RESOLUTION - 1 downto 0);
	signal next_last_valid_value : std_ulogic_vector(RESOLUTION - 1 downto 0);
begin

	reg_proc : process(clk_i, rst_i) 
	begin
		if (rst_i = '1') then
			last_valid_value <= (others => '0');
		elsif rising_edge(clk_i) then
			last_valid_value <= next_last_valid_value;
		end if;
	end process reg_proc;

	output_proc : process (last_valid_value, ADC_valid_strb_i)
	begin
		if ADC_valid_strb_i = '1' then
		next_last_valid_value <= ADC_value_i;
		end if;
	
		HoldValue_o <= last_valid_value;		
	end process output_proc;

end architecture bhv_HoldValueOnStrb;