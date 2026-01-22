library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_debug_design is
end entity tb_debug_design;

architecture bhv_tb_debug_design of tb_debug_design is
    signal clk, rst, cmp, dbg_en, btnIncrement, btnDecrement, switchTen : std_ulogic := '0';
begin

    tilt_board : entity work.Tilt_board
    port map (
        clk_i => clk,
        rst_i => rst,
        x_comp_async_i => cmp,
        dbg_en_i => dbg_en,
        btnIncrement_i => btnIncrement,
        btnDecrement_i => btnDecrement,
        switchTen_i => switchTen,
        x_pwm_pin_o => open,
        ServoX_pwm_pin_o => open,
        sevenseg_o => open
    );

    clk <= not(clk) after 10 ns;

    stimuli : process 
    begin
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        dbg_en <= '1';
        switchTen <= '0';
        wait for 20 ns;
        btnIncrement <= '1';
        wait for 2 ns;
        btnIncrement <= '0';
        wait for 1 ns;
        btnIncrement <= '1';
        wait for 1 ns;
        btnIncrement <= '0';
        wait for 1 ns;
        btnIncrement <= '1';
        wait for 1 ns;
        btnIncrement <= '0';
        wait for 1 ns;
        btnIncrement <= '1';
        wait for 63 ns;
        btnIncrement <= '0';
        btnDecrement <= '1';
        wait for 60 ns;
    end process stimuli;

end architecture bhv_tb_debug_design;