Library ieee;
use ieee.std_logic_1164.all;

entity hAdder is
  port(
    A, B: in  std_logic;
    S, C: out std_logic
  );
end entity;

architecture comportamento of hAdder is
begin

  S <= A xor B;
  C <= A and B;

end architecture;
