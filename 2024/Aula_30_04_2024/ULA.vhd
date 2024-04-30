-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;
	
entity ULA is
	port
	(
		op_mode	: in	std_logic_vector(1 downto 0);
		op_1	: in	std_logic_vector(3 downto 0);
		op_2	: in	std_logic_vector(3 downto 0);
		saida	: out	std_logic_vector(4 downto 0)
	);
end ULA;

architecture exemplo of ULA is


begin


end exemplo;
