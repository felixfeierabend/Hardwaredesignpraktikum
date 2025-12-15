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

-- DATE "10/27/2025 10:27:12"

-- 
-- Device: Altera 5CSXFC6D6F31C6 Package FBGA896
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

ENTITY 	fsm_board IS
    PORT (
	board_clk_i : IN std_logic;
	board_rst_i : IN std_logic;
	board_start_button_i : IN std_logic;
	board_led_o : OUT std_logic
	);
END fsm_board;

-- Design Ports Information
-- board_led_o	=>  Location: PIN_AC23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- board_rst_i	=>  Location: PIN_AJ4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- board_clk_i	=>  Location: PIN_AF14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- board_start_button_i	=>  Location: PIN_AK4,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF fsm_board IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_board_clk_i : std_logic;
SIGNAL ww_board_rst_i : std_logic;
SIGNAL ww_board_start_button_i : std_logic;
SIGNAL ww_board_led_o : std_logic;
SIGNAL \board_rst_i~input_o\ : std_logic;
SIGNAL \board_clk_i~input_o\ : std_logic;
SIGNAL \board_start_button_i~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;

BEGIN

ww_board_clk_i <= board_clk_i;
ww_board_rst_i <= board_rst_i;
ww_board_start_button_i <= board_start_button_i;
board_led_o <= ww_board_led_o;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X86_Y0_N19
\board_led_o~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_board_led_o);

-- Location: IOIBUF_X22_Y0_N35
\board_rst_i~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_board_rst_i,
	o => \board_rst_i~input_o\);

-- Location: IOIBUF_X32_Y0_N1
\board_clk_i~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_board_clk_i,
	o => \board_clk_i~input_o\);

-- Location: IOIBUF_X22_Y0_N52
\board_start_button_i~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_board_start_button_i,
	o => \board_start_button_i~input_o\);

-- Location: LABCELL_X42_Y17_N0
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


