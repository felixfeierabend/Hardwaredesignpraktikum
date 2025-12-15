library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity synchronizer_chain is 
generic (
	CHAIN_LENGTH : natural := 2
);
port (
	clk_i : in std_ulogic;
	rst_i : in std_ulogic;
	input_i : in std_ulogic;
	output_o : out std_ulogic
);

end entity;


architecture bhv_synchronizer_chain of synchronizer_chain is
	signal sync_buffer : std_ulogic_vector(CHAIN_LENGTH - 1 downto 0) := (OTHERS => '0');
begin

	sync_proc : process(clk_i, rst_i) 
	begin
		if rst_i = '1' then
			sync_buffer <= (others => '0');
			output_o <= '0';
		elsif rising_edge(clk_i) then
			sync_buffer <= sync_buffer(CHAIN_LENGTH - 2 downto 0) & input_i;
			output_o <= sync_buffer(CHAIN_LENGTH - 1);
		end if;	
	end process sync_proc;

end architecture bhv_synchronizer_chain;