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

architecture demux_1to4_ie of demux_1to4 is

begin

	demux: process(e, sel)
	begin
		if sel = "00" then
			y(0) <= e;
			y(1) <= '0';
			y(2) <= '0';
			y(3) <= '0';

		elsif sel = "01" then
			y	<= '0' & e & "00";

		elsif sel = "10" then
			y	<= "00" & e & '0';

		elsif sel = "11" then
			y	<= "000" & e;
		else
			y	<= "0000";
		end if;

	end process demux;



end demux_1to4_ie;