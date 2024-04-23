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

architecture decoder_facil_cw of decoder_facil is
begin

	decoder: process(abc)
	begin
		case abc is
			when "000" =>	
				display <= "0111000";	-- F.
			when "001" =>
				display <= "0001000";	-- A.
			when "010" =>
				display	<= "0110001";	-- C.
			when "011" =>
				display <= "1111001";	-- I.
			when "100" =>
				display	<= "1110001";	-- L.
			when others =>
				display <= "1111111";	-- apaga todos os segmentos.
		end case;
	end process decoder;

end decoder_facil_cw;