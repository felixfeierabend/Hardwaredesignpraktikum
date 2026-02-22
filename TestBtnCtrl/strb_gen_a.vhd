library ieee;
use ieee.std_logic_1164.all;
use work.all;

architecture bhv_strobe_generator of strobe_generator is 
	signal cycles_until_strobe : natural := 0;
	signal next_cycles_until_strobe : natural := 0;
	signal strb_val, next_strb_val : std_ulogic;
begin

	reg_proc : process(clk_i, rst_i)
	begin
		if rst_i = '1' then
			strb_o <= '0';
			strb_val <= '0';
			cycles_until_strobe <= STROBE_FREQ - 1;
		elsif rising_edge(clk_i) then
			strb_val <= next_strb_val;
			strb_o <= strb_val;
			cycles_until_strobe <= next_cycles_until_strobe;
		end if;
	end process reg_proc;

	strobe_proc : process(strb_val, cycles_until_strobe) 
	begin
		next_strb_val <= strb_val;
		next_cycles_until_strobe <= cycles_until_strobe;
		if cycles_until_strobe = 0 then
			next_cycles_until_strobe <= STROBE_FREQ - 1;
			next_strb_val <= '1';
		elsif cycles_until_strobe = (STROBE_FREQ - 1) then
			next_strb_val <= '0';
			next_cycles_until_strobe <= cycles_until_strobe - 1;
		else
			next_cycles_until_strobe <= cycles_until_strobe - 1;				
		end if;
	end process strobe_proc;

end architecture bhv_strobe_generator;