-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	
entity decoder_facil is
port
(
	abc		:	in		std_logic_vector(0 to 2);
	display	:	out		std_logic_vector(0 to 6)	-- Ya=(0)... Yg=(6).
);
end decoder_facil;

architecture decoder_facil_ws of decoder_facil is

begin

	with abc select
	display	<= 	"0111000" when "000",
				"0001000" when "001",
				"0110001" when "010",
				"1111001" when "011",
				"1110001" when "100",
				"1111111" when others;



end decoder_facil_ws;