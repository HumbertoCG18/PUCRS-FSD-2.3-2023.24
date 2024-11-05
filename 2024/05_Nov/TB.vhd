library IEEE;
use IEEE.std_logic_1164.all;

entity tb is 
end entity;

architecture bhr of tb is 
    signal sgnClock, sgnReset, sgnX, sgnZ: std_logic;

    begin 
    process
    begin
        sgnClock <= '0', '1' after 5ns;
        wait for 10ns;
    end process;
    
    sgnReset <= '1', '0' after 3ns;

    sgnX <= '0', '1' after 14ns, '0' after 24ns, '1' after 34ns, '0' after 44ns, '1' after 54ns, '0' after 94ns;

    DUT: entity work.Moore port map (clock=>sgnClock, reset=>sgnReset, x=>sgnX, z=>sgnZ);

end architecture;