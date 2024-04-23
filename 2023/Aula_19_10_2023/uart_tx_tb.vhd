-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br 

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.std_logic_arith.all;

entity uart_tx_tb is

end uart_tx_tb;

architecture tb of uart_tx_tb is

    signal  tb_clk    :   std_logic := '0';
    signal  tb_data   :   std_logic_vector(7 downto 0) := "00100110";
    signal  tb_en     :   std_logic := '0';
    signal  tb_tx     :   std_logic := '0';

begin

	-- cria um sinal de clock com período de 10 ns (freq. 100MHz).
    tb_clk  <= not tb_clk after 5 ns;


	-- processo que gera um novo dado e um enable.
    process
    begin
        wait for 28 ns;
        tb_data <= tb_data + 1;

		-- geração de um pulso de enable com largura de 1 ciclo de clock.
        wait for 35 ns;
        tb_en <= '1';

        wait for 10 ns;
        tb_en <= '0';

        wait for 50 ns;

    end process;
    
    
    -- instanciação do bloco uart_tx como duv.
    duv: entity work.uart_tx
	port map
	(
		clk		=> tb_clk,
		en		=> tb_en,
		data 	=> tb_data,
		
		tx		=> tb_tx
	);
    
    
    


end tb;
