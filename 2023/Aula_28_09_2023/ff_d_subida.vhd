-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	
entity ff_d_s is
port
(
	d	:	in	std_logic;
	clk	:	in	std_logic;
	q	:	out	std_logic;
	qn	:	out std_logic
);
end ff_d_s;

architecture ff_subida of ff_d_s is

	signal	interno : std_logic := '0';

begin


	process(clk)
	begin
		if clk'event and clk = '1' then
			interno <= d;
		end if;
	
	end process;


	q 	<= interno;
	qn	<= not interno;


end ff_subida;
