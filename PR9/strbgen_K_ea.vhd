library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity strbgen_K is
    port (
        clk_i : in std_ulogic; 
        rst_i : in std_ulogic; 
        strb_o : out std_ulogic;
        request_strb : in std_ulogic
    );
end entity strbgen_K;

architecture bhv_strbgen_K of strbgen_K is 
    signal strb_val, next_strb_val : std_ulogic;
begin

    reg_proc : process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            strb_val <= '0';
            strb_o <= '0';
        elsif rising_edge(clk_i) then
            strb_val <= next_strb_val;
				strb_o <= strb_val;
        end if;
    end process reg_proc;

    comb_proc : process(strb_val, request_strb)
    begin
        next_strb_val <= '0';
        if request_strb = '1' then
            next_strb_val <= '1';
        end if;
    end process comb_proc;

end architecture bhv_strbgen_K;