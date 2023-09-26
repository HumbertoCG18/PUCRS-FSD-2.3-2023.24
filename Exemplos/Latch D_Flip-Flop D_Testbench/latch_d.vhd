-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity latch_d is
port
(
	d		:	in	std_logic;
	en		:	in	std_logic;

	q		:	out	std_logic;
	qn		:	out	std_logic
);
end latch_d;

architecture latch_d_exemplo of latch_d is

begin

	latch_gen: process(d, en)
	begin
		if en = '1' then
			q	<= d;
			qn	<= not d;
		end if;
	end process latch_gen;

end latch_d_exemplo;