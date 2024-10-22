library IEEE;
use ieee.std_logic_1164.all;

entity FAdder is
  port(
    A, B, Cin: in  std_logic;
    S, Cout:   out std_logic
  );
end entity;

architecture bhr of FAdder is
begin

--  S    <= (not A and not B and     C) or 
--          (not A and     B and not C) or
--          (    A and not B and not C) or
--          (    A and     B and     C);

  S <= A xor B xor Cin;
  
  Cout <= (B and Cin) or (A and Cin) or (A and B);

end architecture;
