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

architecture decoder_facil_we of decoder_facil is

begin

	display <= 	"0111000" 	when abc = "000" else
				"0001000"	when abc = "001" else
				"0110001"	when abc = "010" else
				"1111001"	when abc = "011" else
				"1110001"	when abc = "100" else
				"1111111";

end decoder_facil_we;
