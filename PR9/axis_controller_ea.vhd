library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;
use work.std_package.all;

entity axis_controller is
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;

        comp_async : in std_ulogic;
        sw_en_filter_async : in std_ulogic;
        sw_en_dbg_async : in std_ulogic;
        
        btn_dbg_inc_async : in std_ulogic;
        btn_dbg_dec_async : in std_ulogic;
        sw_dbg_10_async : in std_ulogic;

        pwm_pin_o : out std_ulogic;
        sevenseg_o : out std_ulogic_vector(0 to 20);
        on_counter_value_tilt : out natural;
    );
end entity axis_controller;

architecture bhv_axis_controller of axis_controller is
    signal sw_en_filter_sync : std_ulogic;
    signal sw_en_dbg_sync : std_ulogic;
begin
    sync1 : entity work.synchronizer_chain
    port map (
        clk_i => clk_i,
        rst_i => rst_i,
        input_i => sw_en_filter_async,
        output_o => sw_en_filter_sync
    );

    sync2 : entity work.synchronizer_chain
    port map(
        clk_i => clk_i,
        rst_i => rst_i,
        input_i => sw_en_dbg_async,
        output_o => sw_en_dbg_sync
    );

    
    tilt_board : entity work.tilt_board


end architecture bhv_axis_controller;