library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.all;

entity DeltaADC is 
port (
	comparator_i : in std_ulogic;
	clk_i : in std_ulogic;
	rst_i : in std_ulogic;

    dbg_en_i : in std_ulogic;
    dbg_valid_strb_i : in std_ulogic;
    dbg_adc_val_i : in std_ulogic_vector(std_package.ADC_BIT_WIDTH - 1 downto 0);

	adc_val_o : out std_ulogic_vector(std_package.ADC_BIT_WIDTH - 1 downto 0);
	adc_valid_strb : out std_ulogic;
    pwm_o : out std_ulogic
);
end entity DeltaADC;

architecture bhv_DeltaADC of DeltaADC is 
	signal sampling_strb, sampling_strb_o : std_ulogic;
    signal counter_value : std_ulogic_vector (std_package.ADC_BIT_WIDTH - 1 downto 0);
	signal next_counter_value : std_ulogic_vector (std_package.ADC_BIT_WIDTH - 1 downto 0);
    signal next_adc_valid_strb : std_ulogic;
begin
	
    adc_valid_strb <= next_adc_valid_strb;

	strobe_gen : entity work.strobe_generator
	generic map (
		STROBE_FREQ => std_package.ADC_SAMPLE_SCALER
	)
	port map (
		strb_o => sampling_strb_o,
		clk_i => clk_i,
		rst_i => rst_i
	);
	
	pwm : entity work.pwm
	generic map (
		COUNTER_LEN => std_package.ADC_BIT_WIDTH
	)
	port map (
		clk_i => clk_i,
		reset_i => rst_i,
		Period_counter_val_i => to_unsigned(std_package.ADC_MAX_VAL, std_package.ADC_BIT_WIDTH),
		ON_counter_val_i => unsigned(counter_value),
		PWM_pin_o => pwm_o
	);

    adc_comb_proc : process(sampling_strb_o, comparator_i, counter_value, dbg_en_i, dbg_adc_val_i, dbg_valid_strb_i) is
	begin
		next_counter_value <= counter_value;

		if dbg_en_i = '1' then
			sampling_strb <= dbg_valid_strb_i;
		else
			sampling_strb <= sampling_strb_o;
		end if;

        if dbg_en_i = '1' and dbg_valid_strb_i = '1' then
            next_counter_value <= dbg_adc_val_i;
        elsif dbg_en_i = '0' and sampling_strb_o = '1' then 
            if (comparator_i = '1') then
				if to_integer(unsigned(counter_value) + 1) < std_package.ADC_MAX_VAL then
                	next_counter_value <= std_ulogic_vector(unsigned(counter_value) + 1);
				end if;
            else
				if to_integer(unsigned(counter_value) - 1) > std_package.ADC_MIN_VAL then
                	next_counter_value <= std_ulogic_vector(unsigned(counter_value) - 1);
				end if;
            end if;
        end if;
	end process adc_comb_proc;
	
	reg_proc : process(clk_i, rst_i) 
	begin
		if (rst_i = '1') then
			counter_value <= (others => '0');
            adc_val_o <= (others => '0');
            next_adc_valid_strb <= '0';
		elsif rising_edge(clk_i) then
			counter_value <= next_counter_value;			
			adc_val_o <= counter_value;
            next_adc_valid_strb <= sampling_strb;
		end if;
	end process reg_proc;
	
end architecture bhv_DeltaADC;