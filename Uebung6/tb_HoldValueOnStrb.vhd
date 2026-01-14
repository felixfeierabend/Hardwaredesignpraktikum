library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;

entity tb_HoldValueOnStrb is	
end entity;

architecture bhv_tb_HoldValueOnStrb of tb_HoldValueOnStrb is
	constant RESOLUTION : natural := 7;
	signal valid_strb : std_ulogic := '0';
	signal adc_val : std_ulogic_vector (RESOLUTION - 1 downto 0);
	signal val_out : std_ulogic_vector (RESOLUTION - 1 downto 0);
	signal rst : std_ulogic := '0';
	signal clk : std_ulogic := '1';
begin
	clk <= not clk after 1 ns;

	holdValueOnStrb : entity work.HoldValueOnStrb
	generic map (
		RESOLUTION => RESOLUTION
	)
	port map (
		clk_i => clk,
		rst_i => rst,
		ADC_value_i => adc_val,
		ADC_valid_strb_i => valid_strb,
		HoldValue_o => val_out
	);
	
	stimuli : process begin
		rst <= '1';
		wait for 2 ns;
		rst <= '0';
		wait for 2 ns;
		valid_strb <= '1';
		wait for 2 ns;
		valid_strb <= '0';
		wait for 2 ns;
	
		adc_val <= (OTHERS => '0');
		valid_strb <= '1';
		wait for 2 ns;
		valid_strb <= '0';
		adc_val <= (OTHERS => '1');
		wait for 3 ns;
		valid_strb <= '1';
		wait for 2 ns;
		adc_val <= (OTHERS => '0');
		wait for 2 ns;
		
	end process;
	

end architecture;