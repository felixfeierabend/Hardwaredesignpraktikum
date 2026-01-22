library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_btnCtrl is
end entity;

architecture bhv_tb_btnCtrl of tb_btnCtrl is
    signal clk : std_ulogic := '0';
    signal rst : std_ulogic := '0';
    signal switchTen : std_ulogic := '1';
    signal increment : std_ulogic := '0';
    signal decrement : std_ulogic := '0';
begin

    clk <= not clk after 10 ns;

    btnCtrl : entity work.btnCtrl
    port map (
        clk_i => clk,
        rst_i => rst,
        btnIncrement_i => increment,
        btnDecrement_i => decrement,
        switchTen_i => switchTen,

        adc_value_o => open,
        adc_strb_o => open
    );

    stimuli : process 
    begin
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        switchTen <= '0';
        wait for 10 ns;
        increment <= '1';
        wait for 1 ns;
        increment <= '0';
        wait for 2 ns;
        increment <= '1';
        wait for 1 ns;
        increment <= '0'; 
        wait for 1 ns;
        increment <= '1';
        wait for 16 ns;
        increment <= '0';
        wait for 60 ns;

        
    end process stimuli;

end architecture bhv_tb_btnCtrl;