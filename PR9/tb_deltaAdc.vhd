library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_delta_adc is
end entity tb_delta_adc;

architecture bhv_tb_delta_adc of tb_delta_adc is	
	
	signal cmp : std_ulogic := '0';
	signal clk : std_ulogic := '0';
	signal rst : std_ulogic := '0';
begin
	adc : entity work.DeltaADC
	port map (		
		comparator_i => cmp,
		clk_i => clk,
		rst_i => rst,
		dbg_en_i => '0',
		dbg_valid_strb_i => '0',
		dbg_adc_val_i => (others => '0'),
		adc_val_o => open,
		adc_valid_strb => open,
		pwm_o => open
	);
	
	clk <= not(clk) after 10 ns;
	
	
	stimuli : process begin
		rst <= '1';
		wait for 20 ns;
		rst <= '0';
		cmp <= '1';
		wait for 80 ns;
		cmp <= '0';
		wait for 20 ns;
		cmp <= '1';
		
	end process;

end architecture;