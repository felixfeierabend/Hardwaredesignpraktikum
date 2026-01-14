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
		strb_o : out std_ulogic
	);
end entity periodical_strb_gen;

architecture bhv_strb_gen of periodical_strb_gen is
	constant PRESCALER_LENGTH : natural := natural(ceil(log2(real(PRESCALER))));
	signal cnt : unsigned(PRESCALER_LENGTH - 1 downto 0);
	signal next_cnt : unsigned(PRESCALER_LENGTH - 1 downto 0);
	signal strb_value : std_ulogic;
	signal next_strb_value : std_ulogic;
begin

	reg_proc : process(clk_i) 
	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				strb_value <= '0';
				cnt <= to_unsigned(0, PRESCALER_LENGTH);
			else
				strb_value <= next_strb_value;
				cnt <= next_cnt;
			end if;
			strb_o <= strb_value;
		end if;
	end process reg_proc;
	
	comb_proc : process(strb_value, cnt) 
	begin
		next_strb_value <= strb_value;
		next_cnt <= cnt + 1;
		
		if to_integer(next_cnt) >= (PRESCALER - 1) then
			next_cnt <= to_unsigned(0, PRESCALER_LENGTH);
			next_strb_value <= not strb_value;
		end if;
	end process comb_proc;

end architecture bhv_strb_gen;