library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
use work.std_package.all;

entity tb_axis_controller is
end entity tb_axis_controller;

architecture bhv_tb_axis_controller of tb_axis_controller is
    signal rst, clk, x_comp_async, y_comp_async, sw_en_filter, sw_en_dbg, sw_dbg_10, sw_dbg_y_axis, sw_z_axis : std_ulogic := '0';
    signal btn_dbg_inc, btn_dbg_dec, btn_drawK : std_ulogic := '1';
begin
    dut : entity work.axis_controller
    port map (
        clk_i => clk,
        rst_i => rst,
        x_comp_async => x_comp_async,
        y_comp_async => y_comp_async,
        sw_en_filter_async => sw_en_filter,
        sw_en_dbg_async => sw_en_dbg,
        btn_dbg_inc_async => btn_dbg_inc,
        btn_dbg_dec_async => btn_dbg_dec,
        sw_dbg_10_async => sw_dbg_10,
        sw_dbg_y_axis_async => sw_dbg_y_axis,
        btn_drawK_async => btn_drawK,
        sw_z_axis_async => sw_z_axis,
        x_pwm_pin_o => open,
        y_pwm_pin_o => open,
        x_sevenseg_o => open,
        y_sevenseg_o => open,
        ServoX_pwm_pin_o => open,
        ServoY_pwm_pin_o => open,
        ServoZ_pwm_pin_o => open,
        dbg_strb_o => open
    );

    clk <= not(clk) after 10 ns;

    stimuli : process 
    begin
        rst <= '0';
        wait for 20 ns;
        rst <= '1';
        wait for 20 ns;
        btn_drawK <= '0';
        wait for 20 ns;
        btn_drawK <= '1';
        wait for 100 ms;
    end process stimuli;

end architecture bhv_tb_axis_controller;    