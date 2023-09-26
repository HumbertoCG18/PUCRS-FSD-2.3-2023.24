-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	
entity doador_sangue_we is
port
(
	x	:	in	std_logic;
	y	:	in	std_logic;
	
	o	:	out	std_logic;
	a	:	out	std_logic;
	b	:	out	std_logic;
	ab	:	out	std_logic
);
end doador_sangue_we;

architecture doador_sangue_exemplo_we of doador_sangue_we is
begin

	o <= 	'1' when (x = '0') and (y = '0') else
			'0';
			
	a <=	'1' when (x = '0') else
			'0';
			
	b <= 	'1' when (y = '0') else
			'0';

	ab <=	'1';

end doador_sangue_exemplo_we;