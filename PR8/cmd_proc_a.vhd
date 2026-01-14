library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.all;
use work.std_package.all;

architecture bhv_cmd_proc of work.cmd_proc is 
	type fsm_state_type is (IDLE, WAIT_FOR_STROBE, DRAWING, WAIT_COMPLETE);
	signal fsm_state, next_fsm_state : fsm_state_type;
	signal address, next_address : unsigned (COMCNTBW - 1 downto 0);
	signal command_data : std_ulogic_vector (2 * SERVO_CNT_LEN - 1 downto 0);
	signal r_sum : std_ulogic_vector(SERVO_CNT_LEN + D - 1 downto 0) := std_ulogic_vector(to_unsigned(SERVO_MIN_TICKS, SERVO_CNT_LEN + D));
	signal theta_sum : std_ulogic_vector(SERVO_CNT_LEN + D - 1 downto 0) := std_ulogic_vector(to_unsigned(SERVO_MIN_TICKS + SERVO_PERIOD_TICKS / 2, SERVO_CNT_LEN + D));
	signal sequential_rst, wait_strb : std_ulogic;
	signal command_count, next_command_count : integer;
	signal z_value, next_z_value : std_ulogic_vector (SERVO_CNT_LEN - 1 downto 0);
	
begin
	cmd_rom : entity work.command_rom 
	port map (
		clock_i => clk_i,
		addr_i => address,
		data_o => command_data
	);
	
	strb_gen : entity work.periodical_strb_gen
	generic map (
		PRESCALER => WAIT_PRESCALER
	)
	port map (
		clk_i => clk_i,
		rst_i => sequential_rst,
		strb_o => wait_strb
	);
	
	x_out <= r_sum(SERVO_CNT_LEN + D - 1 downto D);
	y_out <= theta_sum(SERVO_CNT_LEN + D - 1 downto D);
	z_out <= z_value;
	
	reg_proc : process(clk_i, rst_i)
	begin
		if rst_i = '1' then
			fsm_state <= IDLE;
			address <= (others => '0');
			command_count <= 0;
			z_value <= std_ulogic_vector(to_unsigned(std_package.SERVO_MAX_TICKS, SERVO_CNT_LEN));
		elsif rising_edge(clk_i) then
			fsm_state <= next_fsm_state;
			address <= next_address;
			command_count <= next_command_count;
			z_value <= next_z_value;
		end if;
	end process reg_proc;
	
	fsm_comb : process(fsm_state, StartStrb_i, wait_strb)
	begin
		next_fsm_state <= fsm_state;
		next_address <= address;
		next_command_count <= command_count;
		next_z_value <= z_value;
		drawing_o <= '0';
		
		case fsm_state is
			when IDLE =>
				next_address <= (others => '0');
				sequential_rst <= '1';
				r_sum <= std_ulogic_vector(to_unsigned(SERVO_MIN_TICKS, SERVO_CNT_LEN + D));
				theta_sum <= std_ulogic_vector(to_unsigned(SERVO_MIN_TICKS + SERVO_PERIOD_TICKS / 2, SERVO_CNT_LEN + D));
				next_z_value <= std_ulogic_vector(to_unsigned(std_package.SERVO_MAX_TICKS, SERVO_CNT_LEN));
				next_command_count <= 0;
				if StartStrb_i = '1' then
					next_fsm_state <= DRAWING;
				end if;				
			when DRAWING => 
				drawing_o <= '1';
				r_sum <= std_ulogic_vector(unsigned(r_sum) + unsigned(command_data(2 * SERVO_CNT_LEN - 1 downto SERVO_CNT_LEN - 1)));
				theta_sum <= std_ulogic_vector(unsigned(theta_sum) + unsigned(command_data(SERVO_CNT_LEN - 1 downto 0)));
				sequential_rst <= '0';
				next_fsm_state <= WAIT_FOR_STROBE;
				if command_count > 11 and command_count < commands.NCOMMANDS - 2 then
					next_z_value <= std_ulogic_vector(to_unsigned(std_package.SERVO_MIN_TICKS, SERVO_CNT_LEN));
				else 
					next_z_value <= std_ulogic_vector(to_unsigned(std_package.SERVO_MAX_TICKS, SERVO_CNT_LEN));
				end if;
			when WAIT_FOR_STROBE =>
				sequential_rst <= '0';
				r_sum <= std_ulogic_vector(unsigned(r_sum) + unsigned(command_data(2 * SERVO_CNT_LEN - 1 downto SERVO_CNT_LEN - 1)));
				theta_sum <= std_ulogic_vector(unsigned(theta_sum) + unsigned(command_data(SERVO_CNT_LEN - 1 downto 0)));
				drawing_o <= '1';
				if wait_strb = '1' then
					next_fsm_state <= WAIT_COMPLETE;
				end if;
			when WAIT_COMPLETE =>
				r_sum <= std_ulogic_vector(unsigned(r_sum) + unsigned(command_data(2 * SERVO_CNT_LEN - 1 downto SERVO_CNT_LEN - 1)));
				theta_sum <= std_ulogic_vector(unsigned(theta_sum) + unsigned(command_data(SERVO_CNT_LEN - 1 downto 0)));
				sequential_rst <= '1';
				next_command_count <= command_count + 1;
				next_address <= address + 1;
				if command_count = commands.NCOMMANDS - 3 then
					next_z_value <= std_ulogic_vector(to_unsigned(std_package.SERVO_MAX_TICKS, SERVO_CNT_LEN));
				end if;
				if command_count >= commands.NCOMMANDS then
					next_fsm_state <= IDLE;
					next_command_count <= 0;
				else
					next_fsm_state <= DRAWING;
				end if;
			when others => 
				next_fsm_state <= IDLE;
		end case;	
		
	end process fsm_comb;
	
end architecture bhv_cmd_proc;