-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;

entity full_adder is
port
(
	a,b,ci	:	in	std_logic;
	s,co	:	out	std_logic
);
end full_adder;

architecture fa of full_adder is

begin
	s	<= a xor b xor ci;
	co	<= (a and b) or (a and ci) or (b and ci);

end fa;
