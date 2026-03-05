library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity moving_avg is
	generic (
		REG_LENGTH : natural; -- LOG2 von N + 1
		BITWIDTH : natural
	);
	port (
		clk_i : in std_ulogic;
		reset_i : in std_ulogic;
		strb_data_valid_i : in std_ulogic;
		data_i : in unsigned(BITWIDTH - 1 downto 0);
		
		strb_data_valid_o : out std_ulogic;
		data_o : out unsigned(BITWIDTH - 1 downto 0)
	);

end entity moving_avg;

architecture bhv_moving_avg of moving_avg is
	type filter_array_type is array (0 to 2 ** REG_LENGTH) of unsigned (BITWIDTH - 1 downto 0);	
	
	signal shift_reg_mem : filter_array_type := (others => (others => '0'));
	signal next_shift_reg_mem : filter_array_type := (others => (others => '0'));
	
	signal sum : unsigned(REG_LENGTH + BITWIDTH - 1 downto 0) := (others => '0');
	signal next_sum : unsigned(REG_LENGTH + BITWIDTH - 1 downto 0) := (others => '0');
	signal next_valid_strb : std_ulogic := '0';
begin

	strb_data_valid_o <= next_valid_strb;
	data_o <= resize(sum srl REG_LENGTH, BITWIDTH);

	reg_proc : process(clk_i, reset_i)
	begin
		if reset_i = '1' then
			shift_reg_mem <= (others => (others => '0'));
			sum <= (others => '0');
			next_valid_strb <= '0';
		elsif rising_edge(clk_i) then
			shift_reg_mem <= next_shift_reg_mem;
			sum <= next_sum;
			next_valid_strb <= strb_data_valid_i;
		end if;
	end process reg_proc;
	
	comb_proc : process(data_i, next_valid_strb, shift_reg_mem) begin
		next_sum <= sum;
		next_shift_reg_mem <= shift_reg_mem;
		
		if (strb_data_valid_i = '1') then
			next_shift_reg_mem(0) <= data_i;
			next_sum <= (sum + data_i) - shift_reg_mem(2 ** REG_LENGTH);
			for i in 1 to 2**REG_LENGTH loop
				next_shift_reg_mem(i) <= shift_reg_mem(i - 1);
			end loop;
		end if;
	end process comb_proc;

end architecture bhv_moving_avg;