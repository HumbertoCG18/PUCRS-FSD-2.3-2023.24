--------------------------------------------------------------------------------
-- Temporizador decimal do cronometro de xadrez
-- Fernando Moraes - 25/out/2023
--------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
library work;

entity temporizador is
    port( clock, reset, load, en : in std_logic;
          init_time : in  std_logic_vector(7 downto 0);
          cont      : out std_logic_vector(15 downto 0)
      );
end temporizador;

architecture a1 of temporizador is
    signal segL, segH, minL, minH : std_logic_vector(3 downto 0);
    signal en1, en2, en3, en4: std_logic;
begin

   en1 <= ...;
   en2 <= ...;
   en3 <= ...;
   en4 <= ...;

   sL : entity work.dec_counter port map ( ... );
   sH : entity work.dec_counter port map ( ... );
   mL : entity work.dec_counter port map ( ... );
   mH : entity work.dec_counter port map ( ... );
   
   cont <= minH & minL & segH & segL;
end a1;


