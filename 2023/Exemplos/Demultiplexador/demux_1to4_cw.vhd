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

architecture demux_1to4_cw of demux_1to4 is
begin

	demux: process(sel, e)
	begin
		case sel is
			when "00" => 
				y(0) <= e;
				y(1) <= '0';
				y(2) <= '0';
				y(3) <= '0';
			when "01" => 
				y(0) <= '0';
				y(1) <= e;
				y(2) <= '0';
				y(3) <= '0';

			when "10" => 
				y(0) <= '0';
				y(1) <= '0';
				y(2) <= e;
				y(3) <= '0';

			when "11" => 
				y(0) <= '0';
				y(1) <= '0';
				y(2) <= '0';
				y(3) <= e;

			when others => 
				y <= "0000";
		end case;


	end process demux;


end demux_1to4_cw;