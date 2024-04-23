-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

entity full_adder is
port
(
	a	:	in	bit;
	b	:	in	bit;
	ci	:	in	bit;

	s	:	out	bit;
	co	:	out bit
);
end full_adder;

architecture exemplo_somador of full_adder is

begin

	s	<= a xor b xor ci;

	co	<= (a and b) or (a and ci) or (b and ci);

end exemplo_somador;
