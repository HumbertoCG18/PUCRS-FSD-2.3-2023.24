-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	
entity latch_d is
port
(
	d	:	in	std_logic;
	en	:	in	std_logic;
	q	:	out	std_logic;
	qn	:	out std_logic
);
end latch_d;

architecture latch_arc of latch_d is

	signal	interno	: std_logic := '0'; 

begin

	process(d, en)
	begin
		if en = '1' then
			interno <= d;
		end if;
	end process;

	q 	<= interno;
	qn	<= not interno;

end latch_arc;
