library ieee;
use ieee.std_logic_1164.all;

entity tb_adder_3_bit is 
end entity tb_adder_3_bit;

architecture bhv_tb_adder_3_bit of tb_adder_3_bit is
	
	constant tb_BITWIDTH : natural := 3; -- test-case 1
		
	signal tb_operand_a_i : std_Ulogic_vector(tb_BITWIDTH - 1 downto 0);
	signal tb_operand_b_i : std_ulogic_vector(tb_BITWIDTH - 1 downto 0);
	signal tb_result_o : std_ulogic_vector(tb_BITWIDTH downto 0);

begin
	
	ADDER : entity work.adder
	generic map(
		BITWIDTH => tb_BITWIDTH
	)
	port map(		
		operand_a_i => tb_operand_a_i,
		operand_b_i => tb_operand_b_i,
		result_o => tb_result_o
	);
	
	stimuli : process
	begin
	-- test-case 1
		tb_operand_a_i <= "000";
		tb_operand_b_i <= "000";
		wait for 10 ns;
	
		tb_operand_a_i <= "001";
		tb_operand_b_i <= "000";
		wait for 10 ns;--
		
		tb_operand_a_i <= "001";
		tb_operand_b_i <= "001";
		wait for 10 ns;
		
		tb_operand_a_i <= "010";
		tb_operand_b_i <= "101";
		wait for 10 ns;
		
		tb_operand_a_i <= "010";
		tb_operand_b_i <= "010";
		wait for 10 ns;
		
		tb_operand_a_i <= "111";
		tb_operand_b_i <= "111";
		wait for 10 ns;
		
	end process;

end architecture bhv_tb_adder_3_bit;

