-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;

entity testbench is

end testbench;

architecture testbench_tb of testbench is

	signal	a_tb :	std_logic_vector(2 downto 0);
	signal	b_tb :	std_logic_vector(2 downto 0);
	signal 	saida:	std_logic_vector(3 downto 0);

begin

	duv: entity work.subtrator_hierarquico
	port map
	(
		a_in	=> a_tb,
		b_in	=> b_tb,
		
		d_out	=> saida
	);


	process
	begin
		a_tb 	<= "111";
		b_tb	<= "111";
		wait for 50 ns;
		
		a_tb 	<= "111";
		b_tb	<= "110";
		wait for 50 ns;

		a_tb 	<= "111";
		b_tb	<= "101";
		wait for 50 ns;
		
		a_tb 	<= "111";
		b_tb	<= "100";
		wait for 50 ns;		

		a_tb 	<= "111";
		b_tb	<= "011";
		wait for 50 ns;
		
		a_tb 	<= "111";
		b_tb	<= "010";
		wait for 50 ns;
		
		a_tb 	<= "111";
		b_tb	<= "001";
		wait for 50 ns;

		a_tb 	<= "111";
		b_tb	<= "000";
		wait for 50 ns;

		wait;
		
	end process;
	

end testbench_tb;