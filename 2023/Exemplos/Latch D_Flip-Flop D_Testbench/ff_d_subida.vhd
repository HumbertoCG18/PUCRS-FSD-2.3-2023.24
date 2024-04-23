-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity ff_d_subida is
port
(
	d		:	in	std_logic;
	clock	:	in	std_logic;
	q		:	out	std_logic;
	qn		:	out	std_logic
);
end ff_d_subida;

architecture ff_d of ff_d_subida is

begin

	ff_gen: process(clock)
	begin
		if clock'event and clock = '1' then
			q 	<= d;
			qn	<= not d;
		end if;
	end process ff_gen;

end ff_d;