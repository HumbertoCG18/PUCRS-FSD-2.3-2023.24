Library ieee;
use ieee.std_logic_1164.all;

entity tb is
end entity;

architecture bhr of tb is
  signal sgnA: std_logic;
begin

  sgnA <= '0', '1' after 10ns, '0' after 20ns, '1' after 30ns;

end architecture;