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

architecture mux_4_1_we of mux_4_1 is
begin

	y <= 	a 	when sel = "00" else
			b	when sel = "01" else
			c	when sel = "10" else
			d	when sel = "11" else
			'0';

end mux_4_1_we;