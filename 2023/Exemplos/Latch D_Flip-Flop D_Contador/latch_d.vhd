--------------------------------------------------
-- File:    Latch D.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------


library ieee;
	use ieee.std_logic_1164.all;
	
entity latch_d is
port
(
	d	: in	std_logic;
	en	: in	std_logic;
	q	: out	std_logic;
	qn	: out	std_logic
);
end latch_d;

architecture latch of latch_d is

	signal d_int	: std_logic := '0';
begin

	d_int <= d;

	latch_proc: process(d_int, en)
	begin
		if en = '1' then
			q <= d_int;
			qn<= not d_int;
		end if;
	end process latch_proc;

end latch;

