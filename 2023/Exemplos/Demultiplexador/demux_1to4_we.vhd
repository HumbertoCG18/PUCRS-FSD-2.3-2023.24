-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity demux_1to4 is
port
(
	e	:	in	std_logic;
	sel	:	in	std_logic_vector(1 downto 0);
	y	:	out	std_logic_vector(0 to 3)
);
end demux_1to4;

architecture demux_1to4_we of demux_1to4 is

begin

	y(0) 	<= 	e	when sel = "00" else
				'0'	when sel = "01" else
				'0'	when sel = "10" else
				'0'	when sel = "11" else
				'0';

	y(1) 	<= 	'0' when sel = "00" else
				e	when sel = "01" else
				'0'	when sel = "10" else
				'0'	when sel = "11" else
				'0';

	y(2) 	<= 	'0' when sel = "00" else
				'0'	when sel = "01" else
				e	when sel = "10" else
				'0'	when sel = "11" else
				'0';

	y(3) 	<= 	'0' when sel = "00" else
				'0'	when sel = "01" else
				'0'	when sel = "10" else
				e	when sel = "11" else
				'0';

end demux_1to4_we;