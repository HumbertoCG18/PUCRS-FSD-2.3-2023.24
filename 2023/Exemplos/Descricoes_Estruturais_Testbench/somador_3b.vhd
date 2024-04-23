-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

entity somador_3b is
port
(
	da	:	in	bit_vector(2 downto 0);
	db	:	in	bit_vector(2 downto 0);

	s	:	out	bit_vector(3 downto 0)
);
end somador_3b;

architecture exemplo_3b of somador_3b is

	signal	coi	: bit_vector(2 downto 1);

begin

	fa0: entity work.full_adder
	port map
	(
		a	=> da(0),
		b	=> db(0),
		ci	=> '0',
		s	=> s(0),
		co	=> coi(1)
	);


	fa1: entity work.full_adder
	port map
	(
		a	=> da(1),
		b	=> db(1),
		ci	=> coi(1),
		s	=> s(1),
		co	=> coi(2)
	);


	fa2: entity work.full_adder
	port map
	(
		a	=> da(2),
		b	=> db(2),
		ci	=> coi(2),
		s	=> s(2),
		co	=> s(3)
	);





end exemplo_3b;
