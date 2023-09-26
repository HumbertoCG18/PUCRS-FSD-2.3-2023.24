-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity fsm_moore is
port
(
	clock 	:	in	std_logic;
	e		:	in	std_logic;
	s		:	out	std_logic_vector(2 downto 0)
);
end fsm_moore;

architecture exemplo of fsm_moore is

	type	estado_maquina	is (A, B, C, D);

	signal	estado_atual	:	estado_maquina;
	signal	estado_futuro	:	estado_maquina;

begin

	ff: process(clock)
	begin
		if clock'event and clock = '1' then
			estado_atual <= estado_futuro;
		end if;
	end process ff;

	decoder_est_futuro: process(estado_atual, e)
	begin
		case estado_atual is
			when A =>
				if e = '0' then
					estado_futuro <= A;
				else
					estado_futuro <= C;
				end if;
			when B =>
				if e = '0' then
					estado_futuro <= C;
				else
					estado_futuro <= A;
				end if;
			when C =>
				if e = '0' then
					estado_futuro <= B;
				else
					estado_futuro <= D;
				end if;
			when D =>
				if e = '0' then
					estado_futuro <= A;
				else
					estado_futuro <= D;
				end if;
			when others =>
				estado_futuro <= A;
		end case;
	end process decoder_est_futuro;



	decoder_saida: process(estado_atual)
	begin
		case estado_atual is
			when A => 
				s	<= "111";
			when B => 
				s	<= "101";
			when C => 
				s	<= "001";
			when D => 
				s	<= "100";
			when others => 
				s	<= "000";
		end case;

	end process decoder_saida;

end exemplo;