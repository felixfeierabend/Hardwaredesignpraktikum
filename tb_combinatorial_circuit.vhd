library ieee;
use ieee.std_logic_1164.all;

entity tb_combinatorial_circuit is
end entity;

architecture bhv_tb_combinatorial_circuit of tb_combinatorial_circuit is
	signal s_operand_a : std_ulogic;
	signal s_operand_b : std_ulogic;
	signal s_and_o : std_ulogic;
	signal s_or_o : std_ulogic;
begin
	COMBINATORIAL_CIRCUIT : entity work.combinatorial_circuit
	port map(
		operand_a_i => s_operand_a,
		operand_b_i => s_operand_b,
		and_o => s_and_o,
		or_o => s_or_o
	);
	
	stimuli : process
	begin
		s_operand_a <= '0';
		s_operand_b <= '0';
		wait for 10 ns;
		
		s_operand_a <= '0';
		s_operand_b <= '1';
		wait for 10 ns;
		
		s_operand_a <= '1';
		s_operand_b <= '0';
		wait for 10 ns;
		
		s_operand_a <= '1';
		s_operand_b <= '1';
		wait for 10 ns;
		
	end process;
	
end architecture bhv_tb_combinatorial_circuit;