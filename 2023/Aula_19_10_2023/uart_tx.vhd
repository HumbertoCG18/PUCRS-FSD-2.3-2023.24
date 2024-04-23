-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;
	
entity uart_tx is
port
(
	clk	:	in	std_logic;
	en	:	in	std_logic;
	data:	in	std_logic_vector(7 downto 0);
	
	tx	:	out	std_logic
);
end uart_tx;

architecture uart_tx_ex of uart_tx is

	type nomes_estados is (IDLE, START, SEND_DATA, STOP);

	signal estado 	: nomes_estados := IDLE;
	signal cont		: integer := 0;

	signal reg		: std_logic_vector(7 downto 0) := (others => '0');

begin

	process(clk)
	begin
		if clk'event and clk = '1' then
			case estado is
				when IDLE =>
					if en = '1' then
						estado 	<= START;
						reg		<= data;
					else
						estado <= IDLE;					
					end if;
					
					
				when START =>
					estado <= SEND_DATA;
					cont <= 0;
				
				when SEND_DATA =>
					if cont < 7 then
						cont <= cont + 1;
					else
						cont <= 0;
						estado <= STOP;
					end if;
				
				
				when STOP =>
					estado <= IDLE;
				
				when others =>
					estado <= IDLE;
			end case;
		end if;
	end process;


	-- decodificação da saída.
	process(estado, cont, reg)
	begin
		case estado is
			when IDLE =>
				tx <= '1';
			when START =>
				tx <= '0';
			when SEND_DATA => 
				tx <= reg(cont);
			when STOP =>
				tx <= '1';
			when others =>
		end case;
	end process;
	


end uart_tx_ex;
