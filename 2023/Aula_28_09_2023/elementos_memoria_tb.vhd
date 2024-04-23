-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity testbench is

end testbench;

architecture tb of testbench is

	signal	dado			:	std_logic := '0';
	signal	habilita		:	std_logic := '1';
	signal	saida_latch		:	std_logic := '0';
	signal	saida_latch_n	:	std_logic := '0';
	
	signal	saida_subida	:	std_logic := '0';
	signal	saida_subida_n	:	std_logic := '0';

	signal	saida_descida	:	std_logic := '0';
	signal	saida_descida_n	:	std_logic := '0';	
	
	signal 	saida_2			:	std_logic := '0';
	signal 	saida_3			:	std_logic := '0';
	signal 	saida_4			:	std_logic := '0';
	signal 	saida_5			:	std_logic := '0';

begin

	-- esta construção não é sintetizável.
	-- isto funciona somente em simulação!
	habilita <= not habilita after 10 ns;

	dado <= '0',
			'1' after 12 ns,
			'0' after 26 ns,
			'1' after 62 ns,
			'0' after 84 ns,
			'1' after 94 ns;

	-- instanciações dos circuitos que desejamos verificar.
	exemplo_lach: entity work.latch_d
	port map
	(
		d	=> dado,
		en	=> habilita,
		q	=> saida_latch,
		qn	=> saida_latch_n
	);



	-- instanciação do FF borda de subida.
	subida: entity work.ff_d_s
	port map
	(
		d	=> dado,
		clk	=> habilita,
		q	=> saida_subida,
		qn	=> saida_subida_n
	);
	
	
	-- instanciação do FF borda de subida.
	subida2: entity work.ff_d_s
	port map
	(
		d	=> saida_subida,
		clk	=> habilita,
		q	=> saida_2,
		qn	=> open
	);

	-- instanciação do FF borda de subida.
	subida3: entity work.ff_d_s
	port map
	(
		d	=> saida_2,
		clk	=> habilita,
		q	=> saida_3,
		qn	=> open
	);
	
	
	-- instanciação do FF borda de subida.
	subida4: entity work.ff_d_s
	port map
	(
		d	=> saida_3,
		clk	=> habilita,
		q	=> saida_4,
		qn	=> open
	);
	
	
	-- instanciação do FF borda de subida.
	subida5: entity work.ff_d_s
	port map
	(
		d	=> saida_4,
		clk	=> habilita,
		q	=> saida_5,
		qn	=> open
	);
	
	

	-- instanciação do FF borda de subida.
	descida: entity work.ff_d_d
	port map
	(
		d	=> dado,
		clk	=> habilita,
		q	=> saida_descida,
		qn	=> saida_descida_n
	);	
	
	
	

end tb;
