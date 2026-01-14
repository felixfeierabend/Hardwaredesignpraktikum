library ieee;
use ieee.std_logic_1164.all;

entity combinatorial_circuit is 
	port (
		operand_a_i : in std_ulogic;
		operand_b_i : in std_ulogic;
		
		and_o : out std_ulogic;
		or_o : out std_ulogic		
	);
end entity combinatorial_circuit;
