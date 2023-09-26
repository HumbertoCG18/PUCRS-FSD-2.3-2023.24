-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

entity testbench is

end testbench;

architecture tb of testbench is

	signal	entrada_a, entrada_b	:	bit_vector(2 downto 0) := "000";
	signal	resultado				:	bit_vector(3 downto 0) := "0000";

begin

	cuv: entity work.somador_3b
	port map
	(
		da	=> entrada_a,
		db	=> entrada_b,

		s	=> resultado
	);

	
	entrada_a	<= 	"000",
					"001" after 50 ns,
					"010" after 100 ns,
					"011" after 150 ns,
					"100" after 200 ns,
					"101" after 250 ns,
					"110" after 300 ns,
					"111" after 350 ns;

	entrada_b	<= 	"000",
					"001" after 400 ns,
					"010" after 800 ns,
					"011" after 1600 ns,
					"100" after 3200 ns,
					"101" after 6400 ns,
					"110" after 12800 ns,
					"111" after 25600 ns;



end tb;

