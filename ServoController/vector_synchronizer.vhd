library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vector_synchronizer is
	generic (
		BIT_LENGTH : natural
	);
	port (
		clk_i : in std_ulogic;
		vector_i : in std_ulogic_vector(BIT_LENGTH - 1 downto 0);
		vector_o : out std_ulogic_vector(BIT_LENGTH - 1 downto 0)
	);
end entity vector_synchronizer;

architecture bhv_vector_synchronizer of vector_synchronizer is
signal sync_stage1 : std_ulogic_vector(BIT_LENGTH - 1 downto 0);
signal sync_stage2 : std_ulogic_vector(BIT_LENGTH - 1 downto 0);
begin
	
	sync_proc : process(clk_i) 
	begin
		if rising_edge(clk_i) then
			sync_stage2 <= sync_stage1;
			sync_stage1 <= vector_i;
			vector_o <= sync_stage2;
		end if;
	end process;

end architecture bhv_vector_synchronizer;