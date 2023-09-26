--------------------------------------------------
-- File:    Flip Flop D.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;

entity flip_flop_d is
port
(
	d	:	in		std_logic;
	clk:	in		std_logic;
	q	:	out 	std_logic;
	qn	:	out	std_logic
);
end flip_flop_d;

architecture ff_d of flip_flop_d is

	signal d_int	: std_logic := '0';

begin
	d_int <= d;

	proc_ff_d: process(clk)
	begin
		if clk'event and clk = '1' then
			q <= d_int;
			qn<= not d_int;
		end if;
	end process;

end ff_d;