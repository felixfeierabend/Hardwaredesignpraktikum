library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.all;

architecture bhv_DeltaADC of DeltaADC is
	signal counter_value : std_ulogic_vector (RESOLUTION - 1 downto 0);
	signal next_counter_value : std_ulogic_vector (RESOLUTION - 1 downto 0);
	signal adc_clk : std_ulogic;	
	signal prev_compare_val : std_ulogic;

begin

	adc_clk <= clk_i and strobe_i;
	
	counter_proc : process(counter_value)
	begin
		if (comparator_i = '1') then
			next_counter_value <= std_ulogic_vector(unsigned(counter_value) + to_unsigned(1, RESOLUTION - 1));
			prev_compare_val <= '1';
		else
			next_counter_value <= std_ulogic_vector(unsigned(counter_value) - to_unsigned(1, RESOLUTION - 1));
			prev_compare_val <= '0';
		end if;
	end process counter_proc;
	
	reg_proc : process(adc_clk, rst_i) 
	begin
	
		if (rst_i = '1') then
			counter_value <= (others => '0');
		elsif rising_edge(adc_clk) then
			counter_value <= next_counter_value;			
		end if;
		
		adc_val_o <= counter_value;
	end process reg_proc;
	
	comp_strb : process(Comparator_i, prev_compare_val) 
	begin
		if Comparator_i = not prev_compare_val then
			adc_valid_strb <= '1';
		else
			adc_valid_strb <= '0';
		end if;
	end process comp_strb;


end architecture bhv_DeltaADC;