library ieee;
use ieee.std_logic_1164.all;

entity mux is
    port (
        bit_select_i : in std_ulogic;
        in1 : in std_ulogic;
        in2 : in std_ulogic;
        bit_o : out std_ulogic
    );
end entity mux;

architecture bhv_mux of mux is

begin
    bit_o <= in1 when bit_select_i = '1' else in2;
end architecture bhv_mux;