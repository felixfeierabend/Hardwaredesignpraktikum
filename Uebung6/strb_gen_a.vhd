library ieee;
use ieee.std_logic_1164.all;
use work.all;

architecture bhv_strobe_generator of strobe_generator is 
signal cycles_until_strobe : natural := 0;
begin

	strobe_proc : process(clk_i) 
	begin
		if rising_edge(clk_i) then
			if cycles_until_strobe = 0 then
				cycles_until_strobe <= STROBE_FREQ - 1;
				strb_o <= '1';
			elsif cycles_until_strobe = (STROBE_FREQ - 1) then
				strb_o <= '0';
				cycles_until_strobe <= cycles_until_strobe - 1;
			else
				cycles_until_strobe <= cycles_until_strobe - 1;				
			end if;
		end if;
	end process strobe_proc;

end architecture bhv_strobe_generator;