-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity decoder_facil is
port
(
	abc		:	in	std_logic_vector(0 to 2);
	display	:	out	std_logic_vector(0 to 6) -- Ya=0 ... Yg=6.
);
end decoder_facil;

architecture decoder_facil_ie of decoder_facil is

begin

	decodificador: process(abc)
	begin
		if abc = "000" then
			display <= "0111000";		-- F.
		elsif abc = "001" then
			display <= "0001000";		-- A.
		elsif abc = "010" then
			display <= "0110001";		-- C.
		elsif abc = "011" then
			display <= "1111001";		-- I.
		elsif abc = "100" then
			display <= "1110001";		-- L.
		else
			display <= "1111111";		-- apaga todos os segmentos.
		end if;
	end process decodificador;
	
	
end decoder_facil_ie;