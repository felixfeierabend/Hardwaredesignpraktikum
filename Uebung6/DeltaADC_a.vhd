library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.all;

architecture bhv_DeltaADC of DeltaADC is
	signal counter_value : std_ulogic_vector (RESOLUTION - 1 downto 0);
	signal next_counter_value : std_ulogic_vector (RESOLUTION - 1 downto 0);
	signal prev_compare_val : std_ulogic;

begin
	
	counter_proc : process(strobe_i, comparator_i)
	begin
		if strobe_i = '1' then
			if (comparator_i = '1') then
				next_counter_value <= std_ulogic_vector(unsigned(counter_value) + to_unsigned(1, RESOLUTION));
				prev_compare_val <= '1';
			elsif (to_integer(unsigned(counter_value)) = 0) and (comparator_i = '0') then
				next_counter_value <= (others => '0');
				prev_compare_val <= '0';
			else
				next_counter_value <= std_ulogic_vector(unsigned(counter_value) - to_unsigned(1, RESOLUTION));
				prev_compare_val <= '0';
			end if;
		end if;
	end process counter_proc;
	
	reg_proc : process(clk_i, rst_i) 
	begin
		if (rst_i = '1') then
			counter_value <= (others => '0');
		elsif rising_edge(clk_i) then
			counter_value <= next_counter_value;
			if (strobe_i = '1') then
				adc_val_o <= counter_value;
			end if;
		end if;
	end process reg_proc;
	
	comp_strb : process(prev_compare_val) 
	begin
		if Comparator_i = not prev_compare_val then
			adc_valid_strb <= '1';
		else
			adc_valid_strb <= '0';
		end if;
	end process comp_strb;


end architecture bhv_DeltaADC;