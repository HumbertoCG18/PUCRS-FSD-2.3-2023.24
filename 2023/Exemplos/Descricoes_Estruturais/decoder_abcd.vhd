-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

entity decoder_abcd is
port
(
	x	:	in	bit;
	y	:	in	bit;
	
	-- segmentos para display 7-segmentos anodo comum.
	a	:	out	bit;
	b	:	out bit;
	c	:	out	bit;
	d	:	out	bit;
	e	:	out	bit;
	f	:	out bit;
	g	:	out	bit
);
end decoder_abcd;

architecture decoder of decoder_abcd is
begin

	a	<= y;
	b	<= x xor y;
	c	<= x and (not y);
	d	<= x nor y;
	e	<= '0';
	f	<= x and y;
	g	<= x and (not y);

end decoder;
