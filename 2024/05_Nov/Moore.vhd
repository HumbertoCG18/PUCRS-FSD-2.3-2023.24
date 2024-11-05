library IEEE;
use IEEE.std_logic_1164.all;

entity Moore is
port(
	clock, reset: in std_logic;
	x: in std_logic;
	z: out std_logic
);
end entity;

architecture comportamento of moore is
 type Estados is (S0, S1, S2, S3);
 signal EA, PE: Estados;
begin
-- processo estado atual
process (clock, reset)
begin
	if(reset= '1') then 
		EA<=S0;
	elsif(rising_edge(clock))then
		EA <= PE
	end if;
	end process;

--processo calculo Proximo estado
	process(EA, x)
	begin
		case(EA) is
		begin
			when S0 =>
				if(x='0') then PE<=S0;
				else PE<=S2;
				end if;
			when S1 =>
				if(x='0') then PE<=S0;
					else PE<=S2;
					end if;
			when S2 =>
			if(x='0') then PE<=S2;
				else PE<=S3;
				end if;
			when S3 =>
			if(x='0') then PE<=S3;
					  else PE<=S1;
			end case;
	end process;

-- logica para saida do circuito
process(EA)
begin
	if((EA=S0) || (EA=S3)) then
		z<='0';
		else
			x<='1';
	end if;


end process;
end architecture;
