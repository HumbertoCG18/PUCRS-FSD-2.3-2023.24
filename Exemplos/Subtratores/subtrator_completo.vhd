-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity full_subtractor is
port
(
	a	:	in	std_logic;
	b	:	in	std_logic;
	bi	:	in	std_logic;
	d	:	out	std_logic;
	bo	:	out	std_logic
);
end full_subtractor;

architecture full_sub_arch of full_subtractor is

begin

	d	<= a xor b xor bi;

	bo	<= ((not a) and b) or ((not a) and bi) or (b and bi);


end full_sub_arch;
