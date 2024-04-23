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

architecture mux_4_1_cw of mux_4_1 is

begin

	mux: process(a, b, c, d, sel)
	begin

		case sel is
			when "00" =>
				y <= a;

			when "01" =>
				y <= b;

			when "10" =>
				y <= c;

			when "11" =>
				y <= d;

			when others =>
				y <= '0';

		end case;

	end process mux;

end mux_4_1_cw;