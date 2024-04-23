-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity somador_hard is
port
(
	a	:	in	std_logic_vector(3 downto 0);
	b	:	in	std_logic_vector(3 downto 0);

	s	:	out	std_logic_vector(4 downto 0)
);	
end somador_hard;

architecture somador_hard_arch of somador_hard is

	signal	cio	:	std_logic_vector(3 downto 1); -- progagação de carry.

begin

	-- meio somador.
	s(0)	<= a(0) xor b(0);
	cio(1)	<= a(0) and b(0);

	-- somador completo #1
	s(1)	<= a(1) xor b(1) xor cio(1);
	cio(2)	<= (a(1) and b(1)) or (a(1) and cio(1)) or (b(1) and cio(1));

	-- somador completo #2
	s(2)	<= a(2) xor b(2) xor cio(2);
	cio(3)	<= (a(2) and b(2)) or (a(2) and cio(2)) or (b(2) and cio(2));

	-- somador completo #3
	s(3)	<= a(3) xor b(3) xor cio(3);
	s(4)	<= (a(3) and b(3)) or (a(3) and cio(3)) or (b(3) and cio(3));


end somador_hard_arch;
