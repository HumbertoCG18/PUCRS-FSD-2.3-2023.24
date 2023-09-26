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

architecture demux_1to4_ws of demux_1to4 is

begin

	with sel select
	y(0) 	<= 	e	when "00",
				'0'	when "01",
				'0'	when "10",
				'0'	when "11",
				'0' when others;

	with sel select
	y(1) 	<= 	'0'	when "00",
				e	when "01",
				'0'	when "10",
				'0'	when "11",
				'0' when others;

	with sel select
	y(2) 	<= 	'0'	when "00",
				'0' when "01",
				e	when "10",
				'0'	when "11",
				'0' when others;

	with sel select
	y(3) 	<= 	'0'	when "00",
				'0' when "01",
				'0' when "10",
				e	when "11",
				'0' when others;


end demux_1to4_ws;