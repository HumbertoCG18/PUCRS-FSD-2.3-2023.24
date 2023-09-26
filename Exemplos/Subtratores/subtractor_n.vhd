--------------------------------------------------
-- File:    subtractor_n.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all; 
    
entity subtractor_n is

	generic
	(
		NUM_BITS	: integer	:= 4
	);
	port
	(
		a_in		: in	std_logic_vector(NUM_BITS - 1 downto 0);
		b_in		: in	std_logic_vector(NUM_BITS - 1 downto 0);

		dif_out		: out	std_logic_vector(NUM_BITS downto 0)
	);

end subtractor_n;

architecture subtractor_n of subtractor_n is
begin

	dif_out	<= ('0' & a_in) - ('0' & b_in);

end subtractor_n;


