-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity fsm_mealy is
port
(
	clock	:	in	std_logic;
	e		:	in	std_logic;
	s		:	out	std_logic_vector(2 downto 0)
);
end fsm_mealy;

architecture fsm_exemplo of fsm_mealy is

	type nome_estados	is (A, B, C, D);
	signal	estado_atual	:	nome_estados := A;
	signal	estado_futuro	:	nome_estados := A;

begin

	ff_gen: process(clock)
	begin
		if clock'event and clock = '1' then
			estado_atual <= estado_futuro;
		end if;
	end process ff_gen;


	decoder: process(e, estado_atual)
	begin
		case estado_atual is
			when A =>
				if e = '0' then
					estado_futuro 	<= D;
					s				<= "111";
				else
					estado_futuro 	<= C;
					s				<= "010";
				end if;
			when B =>
				if e = '0' then
					estado_futuro 	<= A;
					s				<= "110";
				else
					estado_futuro 	<= B;
					s				<= "000";
				end if;
			when C =>
				if e = '0' then
					estado_futuro 	<= B;
					s				<= "100";
				else
					estado_futuro 	<= B;
					s				<= "000";
				end if;
			when D => 
				if e = '0' then
					estado_futuro 	<= D;
					s				<= "010";
				else
					estado_futuro 	<= C;
					s				<= "110";
				end if;

		end case;
	end process decoder;


end fsm_exemplo;