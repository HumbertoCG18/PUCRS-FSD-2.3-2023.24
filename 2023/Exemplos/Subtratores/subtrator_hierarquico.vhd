-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity subtrator_hierarquico is
port
(
	a_in	:	in	std_logic_vector(2 downto 0);
	b_in	:	in	std_logic_vector(2 downto 0);
	
	d_out	:	out	std_logic_vector(3 downto 0)
);
end subtrator_hierarquico;

architecture sub_hierarquico_arch of subtrator_hierarquico is

	signal boi	:	std_logic_vector(2 downto 1);

begin


	-- instanciação do subtrator completo #2.
	bloco_2: entity work.full_subtractor
	port map
	(
		a	=> a_in(2),
		b	=> b_in(2),
		bi	=> boi(2),
		d	=> d_out(2),
		bo	=> d_out(3)
	);



	-- instanciação do subtrator completo #1.
	bloco_1: entity work.full_subtractor
	port map
	(
		a	=> a_in(1),
		b	=> b_in(1),
		bi	=> boi(1),
		d	=> d_out(1),
		bo	=> boi(2)
	);


	-- instanciação do meio subtrator.
	bloco_0: entity work.half_subtractor
	port map
	(
		a	=> a_in(0),
		b	=> b_in(0),
		d	=> d_out(0),
		bo	=> boi(1)
	);





end sub_hierarquico_arch;