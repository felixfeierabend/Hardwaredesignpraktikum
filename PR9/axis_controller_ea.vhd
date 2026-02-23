library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;
use work.std_package.all;
use work.commands.all;

entity axis_controller is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;

        x_comp_async : in std_ulogic;
        y_comp_async : in std_ulogic;

        sw_en_filter_async : in std_ulogic;
        sw_en_dbg_async : in std_ulogic;
        
        btn_dbg_inc_async : in std_ulogic;
        btn_dbg_dec_async : in std_ulogic;
        sw_dbg_10_async : in std_ulogic;
        sw_dbg_y_axis_async : in std_ulogic;

        btn_drawK_async : in std_ulogic;
        sw_z_axis_async : in std_ulogic;

        x_pwm_pin_o : out std_ulogic;
        x_sevenseg_o : out std_ulogic_vector(0 to 20);
        y_pwm_pin_o : out std_ulogic;
        y_sevenseg_o : out std_ulogic_vector(0 to 20);

        ServoX_pwm_pin_o : out std_ulogic;
        ServoY_pwm_pin_o : out std_ulogic;
        ServoZ_pwm_pin_o : out std_ulogic
    );
end entity axis_controller;

architecture bhv_axis_controller of axis_controller is
    signal sw_en_filter_sync : std_ulogic;
    signal sw_en_dbg_sync : std_ulogic;
    signal increment_n : std_ulogic;
    signal decrement_n : std_ulogic;
    signal dbg_adc_strb : std_ulogic;
    signal dbg_adc_val : std_ulogic_vector(ADC_BIT_WIDTH - 1 downto 0);
    signal btn_drawK_sync : std_ulogic;
    signal drawK_n : std_ulogic;
    signal sw_z_axis_sync : std_ulogic;
    signal On_counter_val_tilt_x, On_coutner_val_tilt_y, On_counter_val_tilt_z : natural;
    signal On_counter_val_sel_x, On_counter_val_sel_y, On_counter_val_sel_z : natural;
    signal rst_n : std_ulogic;
    signal en_dbg_x_axis : std_ulogic;
    signal en_dbg_y_axis : std_ulogic;
    signal sw_dbg_y_axis_sync : std_ulogic;
    signal On_counter_val_proc_x, On_counter_val_proc_y, On_counter_val_proc_z : std_ulogic_vector(SERVO_CNT_LEN - 1 downto 0);
    signal processing : std_ulogic;
    signal K_start_strb : std_ulogic;
begin
    rst_n <= not(rst_i);

    increment_n <= not(btn_dbg_inc_async);
    decrement_n <= not(btn_dbg_dec_async);
    drawK_n <= not(btn_drawK_sync);

    en_dbg_x_axis <= not(sw_dbg_y_axis_sync) and sw_en_dbg_sync;
    en_dbg_y_axis <= sw_dbg_y_axis_sync and sw_en_dbg_sync;

    On_counter_val_tilt_z <= PEN_DOWN_VAL when sw_z_axis_sync = '0' else PEN_UP_VAL; 

    On_counter_val_sel_x <= to_integer(unsigned(On_counter_val_proc_x)) when processing = '1' else On_counter_val_tilt_x;
    On_counter_val_sel_y <= to_integer(unsigned(On_counter_val_proc_y)) when processing = '1' else On_coutner_val_tilt_y;
    On_counter_val_sel_z <= to_integer(unsigned(On_counter_val_proc_z)) when processing = '1' else On_counter_val_tilt_z;

    sync1 : entity work.synchronizer_chain
    port map (
        clk_i => clk_i,
        rst_i => rst_n,
        input_i => sw_en_filter_async,
        output_o => sw_en_filter_sync
    );

    sync2 : entity work.synchronizer_chain
    port map (
        clk_i => clk_i,
        rst_i => rst_n,
        input_i => sw_en_dbg_async,
        output_o => sw_en_dbg_sync
    );

    sync3 : entity work.synchronizer_chain
    port map (
        clk_i => clk_i,
        rst_i => rst_n,
        input_i => btn_drawK_async,
        output_o => btn_drawK_sync
    );

    sync4 : entity work.synchronizer_chain
    port map (
        clk_i => clk_i,
        rst_i => rst_n,
        input_i => sw_z_axis_async,
        output_o => sw_z_axis_sync
    );

    sync5 : entity work.synchronizer_chain
    port map (
        clk_i => clk_i, 
        rst_i => rst_n,
        input_i => sw_dbg_y_axis_async,
        output_o => sw_dbg_y_axis_sync
    );

    btnCtrl : entity work.btnCtrl
	port map (
		clk_i => clk_i,
		rst_i => rst_n,
		btnIncrement_i => increment_n,
		btnDecrement_i => decrement_n,
		switchTen_i => sw_dbg_10_async,
		adc_value_o => dbg_adc_val,
		adc_strb_o => dbg_adc_strb,
		led_dbg_inc_o => open,
		led_dbg_dec_o => open,
		led_dbg_calc_inc_o => open,
		led_dbg_calc_dec_o => open
	);

    
    tilt_x : entity work.tilt_board
    port map (
        clk_i => clk_i,
        rst_i => rst_i,
        x_comp_async_i => x_comp_async,
        dbg_en_i => en_dbg_x_axis,
        dbg_adc_val_i => dbg_adc_val,
        dbg_adc_valid_strb_i => dbg_adc_strb,
        
        x_pwm_pin_o => x_pwm_pin_o,
        On_counter_val_tilt_o => On_counter_val_tilt_x,
        sevenseg_o => x_sevenseg_o,
        switchMovingAvg_i => sw_en_filter_sync
    );

    tilt_y : entity work.tilt_board
    port map (
        clk_i => clk_i, 
        rst_i => rst_i,
        x_comp_async_i => y_comp_async,
        dbg_en_i => en_dbg_y_axis,
        dbg_adc_val_i => dbg_adc_val,
        dbg_adc_valid_strb_i => dbg_adc_strb,

        x_pwm_pin_o => y_pwm_pin_o,
        On_counter_val_tilt_o => On_coutner_val_tilt_y,
        sevenseg_o => y_sevenseg_o,
        switchMovingAvg_i => sw_en_filter_sync
    );

    servoPwmX : entity work.servo_controller
	port map (
		clk_i => clk_i,
		on_time_i => On_counter_val_sel_x,
		pwm_o => ServoX_pwm_pin_o,
		reset_i => rst_n
	);

    servoPwmY : entity work.servo_controller
	port map (
		clk_i => clk_i,
		on_time_i => On_counter_val_sel_y,
		pwm_o => ServoY_pwm_pin_o,
		reset_i => rst_n
	);

    servoPwmZ : entity work.servo_controller
    port map (
        clk_i => clk_i,
        on_time_i => On_counter_val_sel_z,
        pwm_o => ServoZ_pwm_pin_o,
        reset_i => rst_n
    );

    cmd_proc : entity work.cmd_proc
    generic map (
        SERVO_CNT_LEN => SERVO_CNT_LEN,
        WAIT_PRESCALER => CMD_SCALER,
        D => DIVFACTORBW
    )
    port map (
        clk_i => clk_i,
        rst_i => rst_n,
        drawing_o => processing,
        StartStrb_i => K_start_strb,
        x_out => On_counter_val_proc_x,
        y_out => On_counter_val_proc_y,
        z_out => On_counter_val_proc_z
    );

    drawK_strbgen : entity work.strbgen_K
    port map (
        clk_i => clk_i,
        rst_i => rst_n,
        strb_o => K_start_strb,
        request_strb => drawK_n
    );

end architecture bhv_axis_controller;