--------------------------------------------------
-- File:    exemplo.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------
    
entity exemplo_entity is
	port
	(
		a	: in	bit;
		b	: in	bit;
		c	: in	bit;
		d	: in	bit;
                    
		ya	: out	bit;
		yb	: out	bit

	);
end exemplo_entity;

architecture exemplo_architecture of exemplo_entity is  

begin

	ya <= (a xor b) or (c nor d);

	yb <= ((not a) and b) or (c nand d);

end exemplo_architecture;


