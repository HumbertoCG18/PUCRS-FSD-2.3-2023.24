-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity contador_progressivo is
port
(
	clock	:	in	std_logic;
	inicia	:	in	std_logic;
	
	q		:	out	std_logic_vector(1 downto 0)
);
end contador_progressivo;

architecture contador of contador_progressivo is

	signal	cont	: integer := 0;

begin


	process(clock,inicia)
	begin

		if inicia = '0' then
			cont <= 0;
		else
			if clock'event and clock = '1' then
				if cont < 3 then
					cont <= cont + 1;
				else
					cont <= 0;
				end if;
			end if;
		end if;
	end process;

	q	<= conv_std_logic_vector(cont,2);

end contador;
	