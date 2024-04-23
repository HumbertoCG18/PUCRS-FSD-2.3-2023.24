-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity somador_3b is
port
(
	op_a	:	in	std_logic_vector(2 downto 0);
	op_b	:	in	std_logic_vector(2 downto 0);
	soma	:	out	std_logic_vector(3 downto 0)
);
end somador_3b;

architecture soma_maneira of somador_3b is

	signal	coi	:	std_logic_vector(2 downto 1);

begin

	-- instanciação do meio somador.
	ha: entity work.half_adder
	port map
	(
		a	=> op_a(0),
		b	=> op_b(0),
		s	=> soma(0),
		co	=> coi(1)
	);

	-- instanciação do somador completo #0.
	fa0: entity work.full_adder
	port map
	(
		a	=> op_a(1),
		b	=> op_b(1),
		ci	=> coi(1),
		s	=> soma(1),
		co	=> coi(2)
	);
	
	
	-- instanciação do somador completo #1.
	fa1: entity work.full_adder
	port map
	(
		a 	=> op_a(2),
		b 	=> op_b(2),
		ci 	=> coi(2),
		s	=> soma(2),
		co	=> soma(3)
	);



end soma_maneira;
