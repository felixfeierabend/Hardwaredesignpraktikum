library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity debouncer is
    generic (
        DEBOUNCE_DELAY : natural
    );
    port (
        clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        btn_i : in std_ulogic;

        dbnc_o : out std_ulogic
    );

end entity debouncer;

architecture bhv_debouncer of debouncer is
    signal sync_rst, en, dbnc : std_ulogic;
begin
    strb_gen : entity work.periodical_strb_gen
    generic map (
        PRESCALER => DEBOUNCE_DELAY
    )
    port map (
        clk_i => clk_i,
        rst_i => rst_i,
        sync_rst_i => sync_rst,
        strb_o => en
    );

    reg_proc : process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            dbnc <= '0';
        elsif rising_edge(clk_i) then
            if en = '1' then
                dbnc <= btn_i;
            end if;
        end if;
    end process reg_proc;

    sync_rst <= dbnc xnor btn_i;
    
    dbnc_o <= dbnc;
end architecture bhv_debouncer;