-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;

entity somador_easy is
generic
(
	NUMERO_BITS	:	integer	:= 8

);
port
(
	a	:	in	std_logic_vector(NUMERO_BITS - 1 downto 0);
	b	:	in	std_logic_vector(NUMERO_BITS - 1 downto 0);

	s	:	out	std_logic_vector(NUMERO_BITS downto 0)
);	
end somador_easy;

architecture somador_easy_arch of somador_easy is

begin

	s	<= ('0' & a) + ('0' & b);

end somador_easy_arch;