architecture bhv_combinatorial_circuit of work.combinatorial_circuit is
begin
	AND_p : process(operand_a_i, operand_b_i)
	begin
		and_o <= operand_a_i and operand_b_i;
	end process;
	
	OR_p : process(operand_a_i, operand_b_i)
	begin
		or_o <= operand_a_i or operand_b_i;
	end process;

end architecture bhv_combinatorial_circuit;