Library ieee;
use ieee.std_logic_1164.all;

entity tb is
end entity;

architecture bhr of tb is
  signal sgnA: std_logic;
  signal sgnB: std_logic;
  signal sgnS: std_logic;
begin

  sgnA <= '0', '1' after 20ns;
  sgnB <= '0', '1' after 10ns, '0' after 20ns, '1' after 30ns;
  
  DUT: entity work.portaE port map(
    A => sgnA,
    B => sgnB,
    S => sgnS
  );

end architecture;
