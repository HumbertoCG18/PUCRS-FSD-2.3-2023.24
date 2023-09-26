-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	
entity doador_sangue_ws is
port
(
	x	:	in	std_logic;
	y	:	in	std_logic;
	
	o	:	out	std_logic;
	a	:	out	std_logic;
	b	:	out	std_logic;
	ab	:	out	std_logic
);
end doador_sangue_ws;

architecture doador_sangue_exemplo_ws of doador_sangue_ws is

	signal	xy_vetor	: std_logic_vector(1 downto 0);

begin

	xy_vetor <= x & y;
	

	with xy_vetor select
		o <= '1' when "00",
			 '0' when others;
			 
			 
	with xy_vetor select
		a <= 	'1' when "00",
				'1' when "01",
				'0' when others;
				
	with xy_vetor select
		b <=	'1' when "00",
				'1' when "10",
				'0' when others;
				
	ab <= '1';


end doador_sangue_exemplo_ws;