-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

entity doador_sangue is
	port
	(
		x	:	in	bit;	-- entrada de dado X.
		y	:	in	bit;	-- entrada de dado Y.
		o	:	out	bit;
		a	:	out	bit; 
		b	:	out	bit; 
		ab	:	out	bit
	);
end doador_sangue;

architecture doador_sangue_arch of doador_sangue is
	
	constant	VCC	:	bit := '1';		-- constante que gera nível lógico alto.

begin

	o 	<= x nor y;
	a 	<= not x;
	b 	<= not y;
	ab	<= VCC;

end doador_sangue_arch;