library ieee;
use ieee.std_logic_1164.all;

entity tbRegistrador is
end entity

architecture comportamento of tbRegistrador is
signal sgnD, sgnQ, sgnNQ: std_logic_vector(3 downto 0);
signal sgnClock, sgnReset: std_logic;

begin

    process 
    begin
        sgnClock <= '0', '1' afer 50 ns;
        wait for 100ns;
    end process;

    sgnReset <= '1', '0' after 10 ns;

    sgnD <= x'3',x'7' after 70 ns, x'0' after 110 ns, x'2' after 140 ns, x'4' after 170 ns;

    DUT: entity worl.Registrador port map (D => sgnD, Q => sgnQ, nQ => sgnNQ, clock => sgnClock, reset => sgnReset);

    
end architecture;