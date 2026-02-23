library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
use work.std_package.all;

entity btnCtrl is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_logic;
        btnIncrement_i : in std_ulogic;
        btnDecrement_i : in std_ulogic;
        switchTen_i : in std_ulogic;
        
        adc_value_o : out std_ulogic_vector(ADC_BIT_WIDTH - 1 downto 0);
        adc_strb_o : out std_ulogic;
        led_dbg_inc_o : out std_ulogic;
        led_dbg_dec_o : out std_ulogic;
        led_dbg_calc_inc_o : out std_ulogic;
        led_dbg_calc_dec_o : out std_ulogic
    );
end entity btnCtrl;

architecture bhv_btnCtrl of btnCtrl is
	constant MIN_VAL : unsigned(ADC_BIT_WIDTH - 1 downto 0) := to_unsigned(ADC_MIN_VAL, ADC_BIT_WIDTH);
	constant MAX_VAL : unsigned(ADC_BIT_WIDTH - 1 downto 0) := to_unsigned(ADC_MAX_VAL, ADC_BIT_WIDTH);

	type fsm_button_debounce_state is (IDLE, INCREMENT, DECREMENT, CALC_INC, CALC_DEC);
	signal fsm_state, next_fsm_state : fsm_button_debounce_state;
	signal adc_value, next_adc_value : std_ulogic_vector(ADC_BIT_WIDTH - 1 downto 0);
	signal adc_strb, next_adc_strb : std_ulogic;
	signal incValue : integer := 1;
	signal increment_s, decrement_s, switchTen_s : std_ulogic;
begin

    dbnc_increment : entity work.debouncer
    generic map (
        DEBOUNCE_DELAY => DEBOUNCE_DELAY_CLK_CYCLES
    )
    port map (
        clk_i => clk_i,
        rst_i => rst_i,
        btn_i => btnIncrement_i,
        dbnc_o => increment_s
    );

    dbnc_decrement : entity work.debouncer
    generic map (
        DEBOUNCE_DELAY => DEBOUNCE_DELAY_CLK_CYCLES
    )
    port map (
        clk_i => clk_i,
        rst_i => rst_i,
        btn_i => btnDecrement_i,
        dbnc_o => decrement_s
    );

    dbnc_switchTen : entity work.debouncer
    generic map (
        DEBOUNCE_DELAY => DEBOUNCE_DELAY_CLK_CYCLES
    )
    port map (
        clk_i => clk_i,
        rst_i => rst_i,
        btn_i => switchTen_i,
        dbnc_o => switchTen_s
    );

    incValue <= 1 when switchTen_s = '0' else 10;

    fsm_debounce_proc : process(fsm_state, increment_s, decrement_s, switchTen_s, adc_value, adc_strb)
    begin
        next_fsm_state <= fsm_state;
        next_adc_value <= adc_value;
        next_adc_strb <= adc_strb;

        led_dbg_inc_o <= '0';
        led_dbg_dec_o <= '0';
        led_dbg_calc_inc_o <= '0';
        led_dbg_calc_dec_o <= '0';

        case fsm_state is
            when IDLE =>
                next_adc_strb <= '0';
                if increment_s = '1' then
                    next_fsm_state <= CALC_INC;
                elsif decrement_s = '1' then
                    next_fsm_state <= CALC_DEC;                    
                end if;
                led_dbg_inc_o <= '0';
                led_dbg_dec_o <= '0';
                led_dbg_calc_inc_o <= '0';
                led_dbg_calc_dec_o <= '0';

            when CALC_INC =>
                if (to_integer(unsigned(adc_value)) + incValue) > ADC_MAX_VAL then
                    next_adc_value <= std_ulogic_vector(MAX_VAL);
                else
                    next_adc_value <= std_ulogic_vector(unsigned(adc_value) + incValue);
                end if;
                led_dbg_calc_inc_o <= '1';
                next_fsm_state <= INCREMENT;

            when INCREMENT =>
                if increment_s = '0' then
                    next_adc_strb <= '1';
                    next_fsm_state <= IDLE;  
                end if;
                led_dbg_inc_o <= '1';
            
            when CALC_DEC => 
                if (to_integer(unsigned(adc_value)) - incValue) < 0 then
                    next_adc_value <= (others => '0');
                else
                    next_adc_value <= std_ulogic_vector(unsigned(adc_value) - incValue);
                end if;

                next_fsm_state <= DECREMENT;
                led_dbg_calc_dec_o <= '1';

            when DECREMENT =>
                if decrement_s = '0' then
                    next_adc_strb <= '1';
                    next_fsm_state <= IDLE;
                end if;
                led_dbg_dec_o <= '1';

            when others =>
                next_fsm_state <= IDLE;
        end case;
    end process fsm_debounce_proc;

    reg_proc : process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            adc_strb <= '0';
            adc_value <= std_ulogic_vector(to_unsigned(ADC_MEAN_VAL, ADC_BIT_WIDTH));
            fsm_state <= IDLE;
            adc_value_o <= std_ulogic_vector(to_unsigned(ADC_MEAN_VAL, ADC_BIT_WIDTH));
            adc_strb_o <= '0';
        elsif rising_edge(clk_i) then
            adc_strb <= next_adc_strb;
            adc_strb_o <= adc_strb;
            adc_value <= next_adc_value;
            adc_value_o <= adc_value;
            fsm_state <= next_fsm_state;
        end if;
    end process reg_proc;

end architecture bhv_btnCtrl;