--------------------------------------------------
-- File:    instances_full_adder.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------

    
entity instances_full_adder is

	port
	(
		a_in	: in	bit_vector(2 downto 0);
		b_in	: in	bit_vector(2 downto 0);

		sum		: out	bit_vector(3 downto 0)

	);

end instances_full_adder;


architecture instances_full_adder of instances_full_adder is
    
	signal	carry_int	:	bit_vector(1 downto 0) := (others => '0');

begin


	full_adder_0: entity work.full_adder
	port map
	(
		a	=> a_in(0),
		b	=> b_in(0),
		ci	=> '0',

		s	=> sum(0),
		co	=> carry_int(0)
	);

	full_adder_1: entity work.full_adder
	port map
	(
		a	=> a_in(1),
		b	=> b_in(1),
		ci	=> carry_int(0),

		s	=> sum(1),
		co	=> carry_int(1)
	);

	full_adder_2: entity work.full_adder
	port map
	(
		a	=> a_in(2),
		b	=> b_in(2),
		ci	=> carry_int(1),

		s	=> sum(2),
		co	=> sum(3)
	);


end instances_full_adder;


