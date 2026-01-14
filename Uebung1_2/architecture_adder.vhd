library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


architecture bhv_adder of work.adder is
begin
	ADDER : process(operand_a_i, operand_b_i)
	begin
		result_o <= std_ulogic_vector(unsigned('0' & operand_a_i) + unsigned('0' & operand_b_i));
	end process;
end architecture bhv_adder;