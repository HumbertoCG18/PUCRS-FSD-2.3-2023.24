--------------------------------------------------
-- File:    full_adder.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------

entity full_adder is

	port
	(
		a	:	in	bit;
		b	:	in	bit;
		ci	:	in	bit;

		s	:	out bit;
		co	:	out	bit
	);

end full_adder;

architecture full_adder of full_adder is
begin

	co	<= (a and ci) or (b and ci) or (a and b);
	s 	<= a xor b xor ci;

end full_adder;


