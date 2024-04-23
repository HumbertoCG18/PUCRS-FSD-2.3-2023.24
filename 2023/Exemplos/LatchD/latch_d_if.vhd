--------------------------------------------------
-- File:    latch_d_if.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------


library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all; 
    
entity latch_d is
	port
	(
		e	:	in	std_logic;
		d	:	in	std_logic;
		q	:	out	std_logic;
		qn	:	out	std_logic
	);
end latch_d;

architecture latch_d_if of latch_d is

	signal	q_int	: std_logic := '0';

begin

	latch_d_gen: process(e, d)
	begin
		if e = '1' then
			q_int <= d;
		end if;
	end process latch_d_gen;

	q 	<= q_int;
	qn	<= not q_int;
	
end latch_d_if;


