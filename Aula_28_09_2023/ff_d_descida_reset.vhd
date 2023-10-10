-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	
entity ff_d_d is
port
(
	d		:	in	std_logic;
	reset	:	in	std_logic;
	clk		:	in	std_logic;
	q		:	out	std_logic;
	qn		:	out std_logic
);
end ff_d_d;

architecture ff_descida of ff_d_d is

	signal	interno : std_logic := '0';

begin


	process(clk, reset)
	begin
	
		if reset = '0' then
			interno <= '0';
		
		else	
			if clk'event and clk = '0' then
				interno <= d;
			end if;
		end if;
	
	end process;


	q 	<= interno;
	qn	<= not interno;


end ff_descida;
