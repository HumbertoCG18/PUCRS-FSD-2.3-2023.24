library ieee;
use library.std_logic_1164.all;

entity Q02   
	port(
		C: in std_logic_vector(2 downto 0)
		S: out std_logic_vector(5 downto 0)
	);
end entity;

architecture comportamento of Q02 is
	begin
		process(C)
			begin
				if(C="000" or C= "001" or C="101" or C="110")then
					S(0) <= '1';
				else
					S(0) <= '0';
				end if;
				
				if(C="000" or C= "001" or C="100" or C="110")then
					S(1) <= '1';
				else
					S(1) <= '0';
				end if;
				
				if(C="010" or C= "011" or C="101" or C="110")then
					S(2) <= '1';
				else
					S(2) <= '0';
				end if;
				
				if(C="010" or C= "011" or C="100" or C="110")then
					S(3) <= '1';
				else
					S(3) <= '0';
				end if;
				
				if(C="001" or C= "011" or C="111")then
					S(4) <= '1';
				else
					S(4) <= '0';
				end if;
				
				if(C="000" or C= "010" or C="100" or C="101" or C="111")then
					S(5) <= '1';
				else
					S(5) <= '0';
				end if;
			end;
		end process;
	end;
end architecture;