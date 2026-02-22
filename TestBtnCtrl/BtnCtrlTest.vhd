library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity BtnCtrlTest is

	port (
		------------ CLOCK ------------
		CLOCK2_50       	:in    	std_ulogic;
		CLOCK3_50       	:in    	std_ulogic;
		CLOCK_50        	:in    	std_ulogic;

		------------ KEY ------------
		KEY             	:in    	std_ulogic_vector(3 downto 0);

		------------ SW ------------
		SW              	:in    	std_ulogic_vector(17 downto 0);
		
		------------ LED -----------
		LEDG					:out 		std_ulogic_vector(8 downto 0);
		LEDR					:out		std_ulogic_vector(17 downto 0);
		
		------------ Seg7 ------------
		HEX0            	:out   	std_ulogic_vector(6 downto 0);
		HEX1            	:out   	std_ulogic_vector(6 downto 0);
		HEX2            	:out   	std_ulogic_vector(6 downto 0);
		HEX3            	:out   	std_ulogic_vector(6 downto 0);
		HEX4            	:out   	std_ulogic_vector(6 downto 0);
		HEX5            	:out   	std_ulogic_vector(6 downto 0);
		HEX7					:out 		std_ulogic_vector(6 downto 0);
		
		------------ GPIO ------------
		GPIO					:inout	std_ulogic_vector(35 downto 0)
	);

end entity BtnCtrlTest;

architecture rtl of BtnCtrlTest is
begin
	btnCtrl : entity work.btnCtrl
	port map (
		clk_i => CLOCK_50,
		rst_i => KEY(0),
		btnIncrement_i => KEY(1),
		btnDecrement_i => KEY(2),
		switchTen_i => SW(0),
		inc_o => LEDG(0),
		dec_o => LEDG(1)
	);
end architecture rtl;