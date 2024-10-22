library IEEE;
use IEE.std_logic_1164.all;

entity TB is
end entity

architecture bhr of TB is
	signal sgnA, sgnB, SgnCin: std_logic;
	signal sgnS, sgnCout: std_logic;
begin
	
	sgnA <=   '0', 		     '1' after 40ns;
	
	sgnB <=   '0', 		     '1' after 20ns;
			  '0'after 40ns, '1' after 60ns;
	
	sgnCin <= '0'		    ,'1' after 10ns;
			  '0' after 20ns,'1' after 30ns;
			  '0' after 40ns,'1' after 50ns;
			  '0' after 60ns,'1' after 70ns;
DUT: entity work.FAdder port map (A => sgnA, B => sgnB, Cin => sgnCin, S => sgnS, Cout => sgnCout);

end architecture
