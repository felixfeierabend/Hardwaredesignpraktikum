-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;
-- use ieee.math_real.all;

-- entity periodical_strb_gen is
-- 	generic (
-- 		PRESCALER : natural
-- 	);
-- 	port (
-- 		clk_i : in std_ulogic;
-- 		rst_i : in std_ulogic;
-- 		sync_rst_i : in std_ulogic;
-- 		strb_o : out std_ulogic
-- 	);
-- end entity periodical_strb_gen;

-- architecture bhv_strb_gen of periodical_strb_gen is
-- 	constant PRESCALER_LENGTH : natural := natural(ceil(log2(real(PRESCALER))));
-- 	signal cnt : unsigned(PRESCALER_LENGTH - 1 downto 0);
-- 	signal next_cnt : unsigned(PRESCALER_LENGTH - 1 downto 0);
-- 	signal strb_value : std_ulogic;
-- 	signal next_strb_value : std_ulogic;
-- begin

-- 	reg_proc : process(clk_i, rst_i) 
-- 	begin
-- 		if rst_i = '1' then 
-- 			strb_value <= '0';
-- 			cnt <= to_unsigned(0, PRESCALER_LENGTH);
-- 			strb_o <= strb_value;
-- 		elsif rising_edge(clk_i) then
-- 			strb_value <= next_strb_value;
-- 			cnt <= next_cnt;
-- 			strb_o <= strb_value;
-- 		end if;
-- 	end process reg_proc;
	
-- 	comb_proc : process(strb_value, cnt, sync_rst_i) 
-- 	begin
-- 		next_strb_value <= strb_value;
-- 		next_cnt <= cnt + 1;

-- 		if (strb_value = '1') then
-- 			next_strb_value <= '0';
-- 		end if;

-- 		if sync_rst_i = '1' then
-- 			next_strb_value <= '0';
-- 			next_cnt <= to_unsigned(0, PRESCALER_LENGTH);
-- 		end if;
		
-- 		if to_integer(next_cnt) >= (PRESCALER - 1) then
-- 			next_cnt <= to_unsigned(0, PRESCALER_LENGTH);
-- 			next_strb_value <= '1';
-- 		end if;
-- 	end process comb_proc;

-- end architecture bhv_strb_gen;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity periodical_strb_gen is
	generic (
		PRESCALER : natural
	);
	port (
		clk_i : in std_ulogic;
		rst_i : in std_ulogic;
		sync_rst_i : in std_ulogic;
		strb_o : out std_ulogic
	);
end entity periodical_strb_gen;

architecture bhv_strb_gen of periodical_strb_gen is
	signal sync_rst : std_ulogic;
begin
	strb_gen : entity work.strobe_generator
	generic map (
		STROBE_FREQ => PRESCALER
	)
	port map (
		clk_i => clk_i,
		rst_i => sync_rst,
		strb_o => strb_o
	);

	reg_proc : process(clk_i, rst_i)
	begin
		if rst_i = '1' then
			sync_rst <= '1';
		elsif rising_edge(clk_i) then
			sync_rst <= sync_rst_i;
		end if;
	end process reg_proc;

end architecture bhv_strb_gen;