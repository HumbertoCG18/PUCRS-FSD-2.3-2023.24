--------------------------------------------------
-- File:    votador.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------

entity votador_entity is
	port
	(
		a	: in	bit;
		b	: in	bit;
		c	: in	bit;
		d	: in	bit;
		
		us	: out	bit;
		un	: out	bit;
		ms	: out	bit;
		mn	: out	bit
	);
end votador_entity;

architecture votador_architecture of votador_entity is
begin

	us	<= a and b and c and d;
	
	un	<= (not a) and (not b) and (not c) and (not d);

	ms	<= 	((not a) and b and c and d) or
			(a and b and (not c)) or
			(a and (not b) and d) or
			(a and c and (not d));
	
	mn	<= 	(a and (not b) and (not c) and (not d)) or 
			((not a) and b and (not c)) or 
			((not a) and (not b) and d) or 
			((not a) and c and (not d));
	
end votador_architecture;