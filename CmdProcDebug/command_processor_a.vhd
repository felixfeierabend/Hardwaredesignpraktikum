library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
use work.commands.all;
use work.RC_servo_pgk.all;

architecture bhv of command_processor is

    type fsm_state is (IDLE, SET_ROM, WAIT_ROM, CALC_MOVE, SLEEP);

    constant DEGREE_LSB : natural := 0;
    constant DEGREE_MSB : natural := SERVO_CNT_LEN-1;
    constant RADIUS_LSB : natural := SERVO_CNT_LEN;
    constant RADIUS_MSB : natural := (2*SERVO_CNT_LEN)-1;

    signal state, next_state, last_state : fsm_state;
    signal rom_address, next_rom_address : unsigned(COMCNTBW-1 downto 0);
    signal drawing, next_drawing : std_ulogic;
    signal summed_radius, next_summed_radius : signed(SERVO_CNT_LEN + PARTIAL_STEP_EXPONENT - 1 downto 0);
    signal summed_degree, next_summed_degree : signed(SERVO_CNT_LEN + PARTIAL_STEP_EXPONENT - 1 downto 0);
    signal z_degree, next_z_degree : unsigned(SERVO_CNT_LEN - 1 downto 0);
    signal strb_generator_reset, next_strb_generator_reset : std_ulogic;
    signal partial_step_cnt, next_partial_step_cnt : natural;

    signal next_move_strb : std_ulogic;

    signal delta_data : std_ulogic_vector(2*SERVO_CNT_LEN-1 downto 0);

begin
    command_rom : entity work.command_rom(rtl)
        port map (
            clock_i => clk_i,
            addr_i => rom_address,
            data_o => delta_data
        );

    strb_generator : entity work.strb_generator_sync_reset(bhv)
        port map (
            clk_i => clk_i,
            reset_i => reset_i,
            sync_reset_i => strb_generator_reset,
            next_move_strb_o => next_move_strb
        );

    reg_process : process (clk_i, reset_i) is
    begin
        if reset_i = '1' then
            state <= IDLE;
            last_state <= IDLE;
            rom_address <= (others => '0');
            drawing <= '0';
            strb_generator_reset <= '0';
            summed_radius <= (others => '0');
            summed_degree <= (others => '0');
            z_degree <= (others => '0');
            partial_step_cnt <= 0;
        elsif rising_edge(clk_i) then
            last_state <= state;
            state <= next_state;
            rom_address <= next_rom_address;
            drawing <= next_drawing;
            strb_generator_reset <= next_strb_generator_reset;
            summed_radius <= next_summed_radius;
            summed_degree <= next_summed_degree;
            z_degree <= next_z_degree;
            partial_step_cnt <= next_partial_step_cnt;
        end if;
    end process reg_process;

    fsm_process : process (state, start_strb_i, next_move_strb, rom_address, drawing, summed_radius, summed_degree, z_degree, partial_step_cnt, delta_data, last_state) is
    begin
        -- defaults
        next_state <= state;
        next_rom_address <= rom_address;
        next_drawing <= drawing;
        next_strb_generator_reset <= '0';
        next_summed_radius <= summed_radius;
        next_summed_degree <= summed_degree;
        next_z_degree <= z_degree;
        next_partial_step_cnt <= partial_step_cnt;

        case state is
        when IDLE =>
            if start_strb_i = '1' then
                next_drawing <= '1';
                next_strb_generator_reset <= '1';
                -- init summed radius (0°)
                next_summed_radius <= resize(to_signed(ZERO_DEGREES_CLK_CNT, SERVO_CNT_LEN), SERVO_CNT_LEN + PARTIAL_STEP_EXPONENT) sll PARTIAL_STEP_EXPONENT;
                -- init summed degree (90°)
                next_summed_degree <= resize(to_signed(NINETY_DEGREES_CLK_CNT, SERVO_CNT_LEN), SERVO_CNT_LEN + PARTIAL_STEP_EXPONENT) sll PARTIAL_STEP_EXPONENT;
                -- init z degree (180°)
                next_z_degree <= to_unsigned(ONE_EIGHTY_DEGREES_CLK_CNT, SERVO_CNT_LEN);
                next_state <= SET_ROM;
            end if;
        when SET_ROM =>
            if rom_address < NCOMMANDS-1 then
                -- skip first incrementation because rom contains first delta data at init value of rom_address
                if last_state = CALC_MOVE then
                    next_rom_address <= rom_address + 1;
                end if;
                next_state <= WAIT_ROM;
            else
                -- finished drawing, going back to IDLE
                next_rom_address <= (others => '0');
                next_drawing <= '0';
                next_state <= IDLE;
            end if;
        -- wait one clk cycle for command_rom to output new delta_data
        when WAIT_ROM =>
            -- check command no. and controll z-servo
            -- set z to 0° at command No. 11
            if rom_address = 11 then
                next_z_degree <= to_unsigned(ZERO_DEGREES_CLK_CNT, SERVO_CNT_LEN);
            -- set z to 180° two commands before the end
            elsif rom_address = (NCOMMANDS-1)-2 then
                next_z_degree <= to_unsigned(ONE_EIGHTY_DEGREES_CLK_CNT, SERVO_CNT_LEN);
            end if;
            next_state <= CALC_MOVE;
        when CALC_MOVE =>
            if (partial_step_cnt < 2**PARTIAL_STEP_EXPONENT) then
                next_summed_radius <= summed_radius + resize(signed(delta_data(RADIUS_MSB downto RADIUS_LSB)), SERVO_CNT_LEN + PARTIAL_STEP_EXPONENT);
                next_summed_degree <= summed_degree + resize(signed(delta_data(DEGREE_MSB downto DEGREE_LSB)), SERVO_CNT_LEN + PARTIAL_STEP_EXPONENT);
                next_strb_generator_reset <= '1';
                next_state <= SLEEP;
            else
                -- partial steps 2^d reached, read next command from rom
                next_partial_step_cnt <= 0;
                next_state <= SET_ROM;
            end if;
        when SLEEP => 
            if next_move_strb = '1' then
                next_partial_step_cnt <= partial_step_cnt + 1;
                next_state <= CALC_MOVE;
            end if;
        end case;
    end process fsm_process;

    -- get unsigned value of summed radius and degree
    x_servo_cnt_o <= unsigned(summed_radius(SERVO_CNT_LEN + PARTIAL_STEP_EXPONENT - 1 downto PARTIAL_STEP_EXPONENT));
    y_servo_cnt_o <= unsigned(summed_degree(SERVO_CNT_LEN + PARTIAL_STEP_EXPONENT - 1 downto PARTIAL_STEP_EXPONENT));
    z_servo_cnt_o <= z_degree;
    drawing_o <= drawing;

end architecture bhv;