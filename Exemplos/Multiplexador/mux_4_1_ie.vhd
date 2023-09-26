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

architecture mux_4_1_ie of mux_4_1 is

begin

	mux: process(a,b,c,d,sel)
	begin
		if sel = "00" then
			y <= a;
		elsif sel = "01" then
			y <= b;
		elsif sel = "10" then
			y <= c;
		elsif sel = "11" then
			y <= d;
		else
			y <= '0';
		end if;

	end process mux;


end mux_4_1_ie;