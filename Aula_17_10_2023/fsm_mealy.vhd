-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;

entity fsm_mealy is
port
(
	clock, reset, entrada	:	in	std_logic;
	saidas					:	out std_logic_vector(1 downto 0)
);
end fsm_mealy;

architecture exemplo of fsm_mealy is

	type estados_fsm	is (INICIO, IDLE, RCD, GER, UPDATE);
	signal	est_atual	: estados_fsm := INICIO;
	signal	est_futuro	: estados_fsm := IDLE;

begin


	-- construção dos FF.
	process(clock, reset)
	begin
	
		if reset = '1' then
			est_atual <= IDLE;
		else
	
			if clock'event and clock = '1' then
				est_atual <= est_futuro;
			end if;
	
		end if;	

	end process;


	-- construção da lógica de decodificação do estado futuro.
	decoder_estado_futuro: process(est_atual, entrada)
	begin
		case est_atual is
			when INICIO =>
				est_futuro <= IDLE;
		
			when IDLE =>
				if entrada = '0' then
					est_futuro <= RCD;
				else
					est_futuro <= UPDATE;				
				end if;
			
			when RCD =>
				if entrada = '0' then
					est_futuro <= RCD;
				else
					est_futuro <= GER;				
				end if;

			when GER => 
				if entrada = '0' then
					est_futuro <= UPDATE;
				else
					est_futuro <= IDLE;				
				end if;

			
			when UPDATE => 
				est_futuro <= IDLE;
			
			
			when others => 
		
		end case;
	end process decoder_estado_futuro;


	-- construção da lógica de decodificação da saída.
	dec_saidas: process(est_atual, entrada)
	begin
		case est_atual is
			when IDLE =>
				if entrada = '0' then
					saidas <= "00";
				else
					saidas <= "11";				
				end if;
			when RCD =>
				if entrada = '0' then
					saidas <= "10";
				else
					saidas <= "01";				
				end if;
			
			when GER => 
				if entrada = '0' then
					saidas <= "00";
				else
					saidas <= "11";				
				end if;

			when UPDATE =>
				if entrada = '0' then
					saidas <= "01";
				else
					saidas <= "10";				
				end if;
			when others =>
				saidas <= "00";
		
		end case;
	
	
	end process dec_saidas;


end exemplo;
