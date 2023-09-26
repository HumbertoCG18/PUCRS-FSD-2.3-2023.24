-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity ff_7474 is
port
(
	d		:	in	std_logic;
	clock	:	in	std_logic;

	preset	:	in	std_logic;
	reset	:	in	std_logic;

	q		:	out	std_logic;
	qn		:	out	std_logic
);
end ff_7474;

architecture ff_d of ff_7474 is

begin

	ff_gen: process(clock, preset, reset)
	begin
		if (preset = '0') and (reset = '1') then
			q	<= '1';
			qn	<= '0';
		elsif (preset = '1') and (reset = '0') then
			q	<= '0';	
			qn	<= '1';	
		else
			if clock'event and clock = '1' then
				q 	<= d;
				qn	<= not d;
			end if;
		end if;

	end process ff_gen;

end ff_d;