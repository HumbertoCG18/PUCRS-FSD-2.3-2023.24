--------------------------------------------------
-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br
--------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;   
  
entity testbench is


end testbench;

architecture tb of testbench is

	signal	tb_abc			: std_logic_vector(2 downto 0) := "000";		-- abc de dados.
	signal	tb_display		: std_logic_vector(6 downto 0) := "0000000";		-- Ya Yb Yc Yd Ye Yf Yg.

begin

	circuito: entity work.decoder_facil
    port map
	(
        abc      	=> tb_abc, -- abc do decoder.vhdl está conectado com a "tb_abc"
        display     => tb_display -- mesma logica do de cima	
    );

		 -- Geração estimulos do testbench
	tb_abc <= 	"000",
				"001" after 50 ns,
				"010" after 100 ns,
				"011" after 150 ns,
				"100" after 200 ns,
				"101" after 250 ns,
				"110" after 300 ns,
				"111" after 350 ns;
	




end tb;