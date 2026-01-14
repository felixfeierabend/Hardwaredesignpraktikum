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

-- DATE "10/11/2025 11:11:37"

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

ENTITY 	combinatorial_circuit IS
    PORT (
	operand_a_i : IN std_logic;
	operand_b_i : IN std_logic;
	and_o : OUT std_logic;
	or_o : OUT std_logic
	);
END combinatorial_circuit;

-- Design Ports Information
-- and_o	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- or_o	=>  Location: PIN_W9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- operand_a_i	=>  Location: PIN_P6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- operand_b_i	=>  Location: PIN_W8,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF combinatorial_circuit IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_operand_a_i : std_logic;
SIGNAL ww_operand_b_i : std_logic;
SIGNAL ww_and_o : std_logic;
SIGNAL ww_or_o : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \operand_a_i~input_o\ : std_logic;
SIGNAL \operand_b_i~input_o\ : std_logic;
SIGNAL \and_o~0_combout\ : std_logic;
SIGNAL \or_o~0_combout\ : std_logic;
SIGNAL \ALT_INV_operand_b_i~input_o\ : std_logic;
SIGNAL \ALT_INV_operand_a_i~input_o\ : std_logic;

BEGIN

ww_operand_a_i <= operand_a_i;
ww_operand_b_i <= operand_b_i;
and_o <= ww_and_o;
or_o <= ww_or_o;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_operand_b_i~input_o\ <= NOT \operand_b_i~input_o\;
\ALT_INV_operand_a_i~input_o\ <= NOT \operand_a_i~input_o\;

-- Location: IOOBUF_X4_Y0_N2
\and_o~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \and_o~0_combout\,
	devoe => ww_devoe,
	o => ww_and_o);

-- Location: IOOBUF_X4_Y0_N36
\or_o~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \or_o~0_combout\,
	devoe => ww_devoe,
	o => ww_or_o);

-- Location: IOIBUF_X4_Y0_N18
\operand_a_i~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_operand_a_i,
	o => \operand_a_i~input_o\);

-- Location: IOIBUF_X4_Y0_N52
\operand_b_i~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_operand_b_i,
	o => \operand_b_i~input_o\);

-- Location: LABCELL_X4_Y1_N0
\and_o~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \and_o~0_combout\ = ( \operand_b_i~input_o\ & ( \operand_a_i~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_operand_a_i~input_o\,
	dataf => \ALT_INV_operand_b_i~input_o\,
	combout => \and_o~0_combout\);

-- Location: LABCELL_X4_Y1_N9
\or_o~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \or_o~0_combout\ = ( \operand_b_i~input_o\ ) # ( !\operand_b_i~input_o\ & ( \operand_a_i~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_operand_a_i~input_o\,
	dataf => \ALT_INV_operand_b_i~input_o\,
	combout => \or_o~0_combout\);

-- Location: MLABCELL_X72_Y28_N3
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


