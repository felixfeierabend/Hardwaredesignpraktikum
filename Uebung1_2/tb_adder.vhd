library ieee;
use ieee.std_logic_1164.all;

entity tb_adder is 
end entity tb_adder;

architecture bhv_tb_adder of tb_adder is
	constant tb_BITWIDTH : natural := 2; -- test-case 2
	
	signal tb_operand_a_i : std_ulogic_vector(tb_BITWIDTH - 1 downto 0);
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
	
	-- test-case 2
		tb_operand_a_i <= "00";
		tb_operand_b_i <= "00";
		wait for 10 ns;
		
		tb_operand_a_i <= "01";
		tb_operand_b_i <= "00";
		wait for 10 ns;
		
		tb_operand_a_i <= "10";
		tb_operand_b_i <= "00";
		wait for 10 ns;
		
		tb_operand_a_i <= "01";
		tb_operand_b_i <= "01";
		wait for 10 ns;
		
		tb_operand_a_i <= "10";
		tb_operand_b_i <= "10";
		wait for 10 ns;
		
		tb_operand_a_i <= "11";
		tb_operand_b_i <= "11";
		wait for 10 ns;
		
	end process;

end architecture bhv_tb_adder;

