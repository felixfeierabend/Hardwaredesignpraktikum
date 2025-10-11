-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

-- DATE "10/11/2025 20:03:25"

-- 
-- Device: Altera 5CGXFC7C7F23C8 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	adder IS
    PORT (
	operand_a_i : IN std_logic_vector(2 DOWNTO 0);
	operand_b_i : IN std_logic_vector(2 DOWNTO 0);
	result_o : BUFFER std_logic_vector(3 DOWNTO 0)
	);
END adder;

-- Design Ports Information
-- result_o[0]	=>  Location: PIN_K21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- result_o[1]	=>  Location: PIN_L22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- result_o[2]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- result_o[3]	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- operand_a_i[0]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- operand_b_i[0]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- operand_a_i[1]	=>  Location: PIN_M18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- operand_b_i[1]	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- operand_a_i[2]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- operand_b_i[2]	=>  Location: PIN_L17,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF adder IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_operand_a_i : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_operand_b_i : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_result_o : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \operand_a_i[0]~input_o\ : std_logic;
SIGNAL \operand_b_i[0]~input_o\ : std_logic;
SIGNAL \Add0~0_combout\ : std_logic;
SIGNAL \operand_a_i[1]~input_o\ : std_logic;
SIGNAL \operand_b_i[1]~input_o\ : std_logic;
SIGNAL \Add0~1_combout\ : std_logic;
SIGNAL \operand_a_i[2]~input_o\ : std_logic;
SIGNAL \operand_b_i[2]~input_o\ : std_logic;
SIGNAL \Add0~2_combout\ : std_logic;
SIGNAL \Add0~3_combout\ : std_logic;
SIGNAL \ALT_INV_operand_b_i[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_operand_a_i[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_operand_b_i[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_operand_a_i[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_operand_b_i[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_operand_a_i[2]~input_o\ : std_logic;

BEGIN

ww_operand_a_i <= operand_a_i;
ww_operand_b_i <= operand_b_i;
result_o <= ww_result_o;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_operand_b_i[0]~input_o\ <= NOT \operand_b_i[0]~input_o\;
\ALT_INV_operand_a_i[0]~input_o\ <= NOT \operand_a_i[0]~input_o\;
\ALT_INV_operand_b_i[1]~input_o\ <= NOT \operand_b_i[1]~input_o\;
\ALT_INV_operand_a_i[1]~input_o\ <= NOT \operand_a_i[1]~input_o\;
\ALT_INV_operand_b_i[2]~input_o\ <= NOT \operand_b_i[2]~input_o\;
\ALT_INV_operand_a_i[2]~input_o\ <= NOT \operand_a_i[2]~input_o\;

-- Location: IOOBUF_X89_Y38_N39
\result_o[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Add0~0_combout\,
	devoe => ww_devoe,
	o => ww_result_o(0));

-- Location: IOOBUF_X89_Y36_N56
\result_o[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Add0~1_combout\,
	devoe => ww_devoe,
	o => ww_result_o(1));

-- Location: IOOBUF_X89_Y35_N79
\result_o[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Add0~2_combout\,
	devoe => ww_devoe,
	o => ww_result_o(2));

-- Location: IOOBUF_X89_Y38_N56
\result_o[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Add0~3_combout\,
	devoe => ww_devoe,
	o => ww_result_o(3));

-- Location: IOIBUF_X89_Y35_N95
\operand_a_i[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_operand_a_i(0),
	o => \operand_a_i[0]~input_o\);

-- Location: IOIBUF_X89_Y37_N38
\operand_b_i[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_operand_b_i(0),
	o => \operand_b_i[0]~input_o\);

-- Location: LABCELL_X88_Y37_N0
\Add0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~0_combout\ = ( !\operand_a_i[0]~input_o\ & ( \operand_b_i[0]~input_o\ ) ) # ( \operand_a_i[0]~input_o\ & ( !\operand_b_i[0]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111111111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_operand_a_i[0]~input_o\,
	dataf => \ALT_INV_operand_b_i[0]~input_o\,
	combout => \Add0~0_combout\);

-- Location: IOIBUF_X89_Y36_N21
\operand_a_i[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_operand_a_i(1),
	o => \operand_a_i[1]~input_o\);

-- Location: IOIBUF_X89_Y37_N55
\operand_b_i[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_operand_b_i(1),
	o => \operand_b_i[1]~input_o\);

-- Location: LABCELL_X88_Y37_N9
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_combout\ = ( \operand_a_i[0]~input_o\ & ( !\operand_a_i[1]~input_o\ $ (!\operand_b_i[0]~input_o\ $ (\operand_b_i[1]~input_o\)) ) ) # ( !\operand_a_i[0]~input_o\ & ( !\operand_a_i[1]~input_o\ $ (!\operand_b_i[1]~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010110101010010110101010010101010101101010100101101010100101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_operand_a_i[1]~input_o\,
	datac => \ALT_INV_operand_b_i[0]~input_o\,
	datad => \ALT_INV_operand_b_i[1]~input_o\,
	datae => \ALT_INV_operand_a_i[0]~input_o\,
	combout => \Add0~1_combout\);

-- Location: IOIBUF_X89_Y37_N4
\operand_a_i[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_operand_a_i(2),
	o => \operand_a_i[2]~input_o\);

-- Location: IOIBUF_X89_Y37_N21
\operand_b_i[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_operand_b_i(2),
	o => \operand_b_i[2]~input_o\);

-- Location: LABCELL_X88_Y37_N12
\Add0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~2_combout\ = ( \operand_b_i[1]~input_o\ & ( \operand_a_i[1]~input_o\ & ( !\operand_a_i[2]~input_o\ $ (\operand_b_i[2]~input_o\) ) ) ) # ( !\operand_b_i[1]~input_o\ & ( \operand_a_i[1]~input_o\ & ( !\operand_a_i[2]~input_o\ $ 
-- (!\operand_b_i[2]~input_o\ $ (((\operand_a_i[0]~input_o\ & \operand_b_i[0]~input_o\)))) ) ) ) # ( \operand_b_i[1]~input_o\ & ( !\operand_a_i[1]~input_o\ & ( !\operand_a_i[2]~input_o\ $ (!\operand_b_i[2]~input_o\ $ (((\operand_a_i[0]~input_o\ & 
-- \operand_b_i[0]~input_o\)))) ) ) ) # ( !\operand_b_i[1]~input_o\ & ( !\operand_a_i[1]~input_o\ & ( !\operand_a_i[2]~input_o\ $ (!\operand_b_i[2]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110100101100110011010011001100110011001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_operand_a_i[2]~input_o\,
	datab => \ALT_INV_operand_b_i[2]~input_o\,
	datac => \ALT_INV_operand_a_i[0]~input_o\,
	datad => \ALT_INV_operand_b_i[0]~input_o\,
	datae => \ALT_INV_operand_b_i[1]~input_o\,
	dataf => \ALT_INV_operand_a_i[1]~input_o\,
	combout => \Add0~2_combout\);

-- Location: LABCELL_X88_Y37_N18
\Add0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~3_combout\ = ( \operand_b_i[1]~input_o\ & ( \operand_a_i[1]~input_o\ & ( (\operand_b_i[2]~input_o\) # (\operand_a_i[2]~input_o\) ) ) ) # ( !\operand_b_i[1]~input_o\ & ( \operand_a_i[1]~input_o\ & ( (!\operand_a_i[2]~input_o\ & 
-- (\operand_b_i[2]~input_o\ & (\operand_a_i[0]~input_o\ & \operand_b_i[0]~input_o\))) # (\operand_a_i[2]~input_o\ & (((\operand_a_i[0]~input_o\ & \operand_b_i[0]~input_o\)) # (\operand_b_i[2]~input_o\))) ) ) ) # ( \operand_b_i[1]~input_o\ & ( 
-- !\operand_a_i[1]~input_o\ & ( (!\operand_a_i[2]~input_o\ & (\operand_b_i[2]~input_o\ & (\operand_a_i[0]~input_o\ & \operand_b_i[0]~input_o\))) # (\operand_a_i[2]~input_o\ & (((\operand_a_i[0]~input_o\ & \operand_b_i[0]~input_o\)) # 
-- (\operand_b_i[2]~input_o\))) ) ) ) # ( !\operand_b_i[1]~input_o\ & ( !\operand_a_i[1]~input_o\ & ( (\operand_a_i[2]~input_o\ & \operand_b_i[2]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000100010001000100010001011100010001000101110111011101110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_operand_a_i[2]~input_o\,
	datab => \ALT_INV_operand_b_i[2]~input_o\,
	datac => \ALT_INV_operand_a_i[0]~input_o\,
	datad => \ALT_INV_operand_b_i[0]~input_o\,
	datae => \ALT_INV_operand_b_i[1]~input_o\,
	dataf => \ALT_INV_operand_a_i[1]~input_o\,
	combout => \Add0~3_combout\);

-- Location: LABCELL_X67_Y60_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


