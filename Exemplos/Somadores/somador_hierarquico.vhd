-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity somador_hierarquico is
port
(
	a	:	in	std_logic_vector(3 downto 0);
	b	:	in	std_logic_vector(3 downto 0);

	s	:	out	std_logic_vector(4 downto 0)
);	
end somador_hierarquico;

architecture somador_hierarquico_arch of somador_hierarquico is

	signal	cio	:	std_logic_vector(3 downto 1); -- progagação de carry.

begin

	-- somador completo #0.
	FA_0: entity work.somador_completo
	port map
	(
		a		=> a(0),
		b       => b(0),
		ci      => '0',
		co		=> cio(1),
		s	    => s(0) 
	);

	-- somador completo #1.
	FA_1: entity work.somador_completo
	port map
	(
		a		=> a(1),
		b       => b(1),
		ci      => cio(1),
		co		=> cio(2),
		s	    => s(1)
	);


	-- somador completo #2.
	FA_2: entity work.somador_completo
	port map
	(
		a		=> a(2),
		b       => b(2),
		ci      => cio(2),
		co		=> cio(3),
		s	    => s(2)
	);


	-- somador completo #3.
	FA_3: entity work.somador_completo
	port map
	(
		a		=> a(3),
		b       => b(3),
		ci      => cio(3),
		co		=> s(4),
		s	    => s(3)
	);



end somador_hierarquico_arch;