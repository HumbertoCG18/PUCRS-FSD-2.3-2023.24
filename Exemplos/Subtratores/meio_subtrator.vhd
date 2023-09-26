-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity half_subtractor is
port
(
	a	:	in	std_logic;
	b	:	in	std_logic;
	d	:	out	std_logic;
	bo	:	out	std_logic
);
end half_subtractor;

architecture half_subtractor_arch of half_subtractor is

begin

	d	<= a xor b;
	bo	<= (not a) and b;

end half_subtractor_arch;