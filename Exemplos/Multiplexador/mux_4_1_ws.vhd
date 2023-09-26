-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity mux_4_1 is
port
(
	a,b,c,d		:	in		std_logic;						-- entradas de dados.
	sel			:	in		std_logic_vector(1 downto 0);	-- entrada de controle.
	y			:	out		std_logic
);
end mux_4_1;

architecture mux_4_1_ws of mux_4_1 is
begin

	with sel select
	y	<=	a	when "00",
			b	when "01",
			c	when "10",
			d	when "11",
			'0' when others;

end mux_4_1_ws;