-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity decoder_facil_mux is
port
(
	abc		:	in		std_logic_vector(2 downto 0);
	tipo	:	in		std_logic;
	display	:	out		std_logic_vector(6 downto 0) -- A=6...G=0.
);
end decoder_facil_mux;

architecture ex_lista_sensibilidade of decoder_facil_mux is

	signal	display_anodo : std_logic_vector(6 downto 0);
	signal	display_catodo:	std_logic_vector(6 downto 0);

begin

	-- display anodo comum.
	display_anodo <= 	not	"1000111" when abc = "000" else
						not	"1110111" when abc = "001" else
						not "1001110" when abc = "010" else
						not "0000110" when abc = "011" else
						not "0001110" when abc = "100" else
						not "0000000";


	-- display cátodo comum.
	with abc select
	display_catodo	 <= "1000111" when "000",
						"1110111" when "001",
						"1001110" when "010",
						"0000110" when "011",
						"0001110" when "100",
						"0000000" when others;

	-- multiplexador.
	mux: process(display_anodo, display_catodo, tipo)
	begin
		if tipo = '0' then
			display <= display_anodo;
		elsif tipo = '1' then
			display <= display_catodo;
		else
			display <= "1010101";
		end if;

	end process mux;



end ex_lista_sensibilidade;