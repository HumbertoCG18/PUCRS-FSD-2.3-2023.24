-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity elementos_memoria_tb is
end elementos_memoria_tb;

architecture testbench_elementos_memoria of elementos_memoria_tb is

	signal	dado_tb			:	std_logic	:= '0';
	signal	enable_clock_tb	:	std_logic	:= '0';

	signal	preset_tb		:	std_logic	:= '1';
	signal	reset_tb		:	std_logic	:= '1';

	signal	q_latch_d		:	std_logic;
	signal	qn_latch_d		:	std_logic;
	
	signal	q_ff_d_sub		:	std_logic;
	signal	qn_ff_d_sub		:	std_logic;

	signal	q_ff_d_desc		:	std_logic;
	signal	qn_ff_d_desc	:	std_logic;

	signal	q_ff_d_7474		:	std_logic;
	signal	qn_ff_d_7474	:	std_logic;


begin


	latch_d: entity work.latch_d
	port map
	(
		d		=> dado_tb,
		en		=> enable_clock_tb,

		q		=> q_latch_d,
		qn		=> qn_latch_d
	);


	ff_d_subida: entity work.ff_d_subida
	port map
	(
		d		=> dado_tb,
		clock	=> enable_clock_tb,
		q		=> q_ff_d_sub,
		qn		=> qn_ff_d_sub
	);

	ff_d_descida: entity work.ff_d_descida
	port map
	(
		d		=> dado_tb,
		clock	=> enable_clock_tb,
		q		=> q_ff_d_desc,
		qn		=> qn_ff_d_desc
	);


	ff_7474: entity work.ff_7474
	port map
	(
		d		=> dado_tb,
		clock	=> enable_clock_tb,

		preset	=> preset_tb,
		reset	=> reset_tb,

		q		=> q_ff_d_7474,
		qn		=> qn_ff_d_7474
	);


	-- geração enable/clock.
	enable_clock_tb <= not enable_clock_tb after 25 ns;


	preset_tb	<= '0' after 262 ns, '1' after 365 ns;
	reset_tb	<= '0' after 641 ns, '1' after 834 ns;

	dado_tb		<= not dado_tb after 66 ns;



end testbench_elementos_memoria;