library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- architecture rtl_moving_avg_filter of shift_register is
-- 	constant FILTER_LENGTH : natural := 2**REG_LENGTH;
	
-- 	type reg_chain is array (0 to FILTER_LENGTH) of unsigned(BITWIDTH-1 downto 0);
	
-- 	signal strb_data_valid : std_ulogic;
-- 	signal data_chain : reg_chain;
-- 	signal next_data_chain : reg_chain;
-- 	signal data_memory : unsigned(BITWIDTH+REG_LENGTH-1 downto 0);
-- 	signal next_data_memory : unsigned(BITWIDTH+REG_LENGTH-1 downto 0);
-- begin
-- 	regproc: process(clk_i, reset_i) is
-- 	begin
-- 		if reset_i = '1' then
-- 			strb_data_valid <= '0';
-- 			data_chain <= (others => (others => '0'));
-- 			data_memory <= (others => '0');
-- 		elsif rising_edge(clk_i) then
-- 			strb_data_valid <= strb_data_valid_i;
-- 			if strb_data_valid_i = '1' then
-- 				data_chain <= next_data_chain;
-- 				data_memory <= next_data_memory;
-- 			end if;
-- 		end if;
-- 	end process regproc;
	
-- 	next_data_chain(0) <= unsigned(data_i);
-- 	next_data_chain(1 to FILTER_LENGTH) <= data_chain(0 to FILTER_LENGTH-1);
	
-- 	next_data_memory <= (data_memory + unsigned(data_i)) - data_chain(FILTER_LENGTH);
	
-- 	strb_data_valid_o <= strb_data_valid;
	
-- 	data_o <= data_memory(BITWIDTH+REG_LENGTH-1 downto REG_LENGTH);
-- end architecture rtl_moving_avg_filter;


architecture bhv_shift_register of shift_register is
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

end architecture bhv_shift_register;