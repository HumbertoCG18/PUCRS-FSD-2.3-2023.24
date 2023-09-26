-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity somador_completo is
port
(
	a		:	in	std_logic;
	b       :	in	std_logic;
	ci      :	in	std_logic;
	co		:	out	std_logic;
	s	    :	out	std_logic
);
end somador_completo;

architecture somador_completo_arch of somador_completo is
begin

	s		<= a xor b xor ci;
	co		<= (a and b) or (a and ci) or (b and ci);

end somador_completo_arch;
