Library ieee;
use ieee.std_logic_1164.all;

entity portaE is
  port(
    A, B: in  std_logic;
    S   : out std_logic
  );
end entity;

architecture bhr of portaE is
begin

  S <= A and B;

end architecture;
