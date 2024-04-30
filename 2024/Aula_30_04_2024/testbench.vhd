-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;
	
entity testbench is

end testbench;

architecture tb of testbench is

	constant ATRASO						: time := 10 ns;

	signal	tb_op_mode	: std_logic_vector(1 downto 0) := "00";
	signal	tb_op_1		: std_logic_vector(3 downto 0) := "0000";
	signal	tb_op_2		: std_logic_vector(3 downto 0) := "0000";
	signal	tb_saida	: std_logic_vector(4 downto 0);
	
	
	
begin


	ULA: entity work.ULA
	port map
	(
		op_mode	=> tb_op_mode,	
		op_1	=> tb_op_1,	
		op_2	=> tb_op_2,	
		saida	=> tb_saida		
	);

					
	entradas_gen: process
	begin
		wait for ATRASO;
		if tb_op_2 < "1111" then
			tb_op_2 <= tb_op_2 + 1;
		else
			tb_op_2 <= "0000";
			
			if tb_op_1 < "1111" then
				tb_op_1 <= tb_op_1 + 1;
			else
				tb_op_1 <= "0000";

				if tb_op_mode < "11" then
					tb_op_mode <= tb_op_mode + 1;
				else
					tb_op_mode <= "00";
					
					report "fim da simulacao.";
					wait;
				end if;
			end if;
		end if;

	end process entradas_gen;

end tb;
