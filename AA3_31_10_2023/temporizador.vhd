library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;

entity temporizador is
    port( 
        clock, reset, load, en : in std_logic;
        init_time : in std_logic_vector(7 downto 0);
        cont : out std_logic_vector(15 downto 0)
    );
end temporizador;

architecture a1 of temporizador is
    signal segL, segH, minL, minH : std_logic_vector(3 downto 0);
    signal en1, en2, en3, en4: std_logic;
begin

    en1 <= en and load;
    en2 <= en and not load and not segL(3);
    en3 <= en and not load and segL(3) and not minL(3);
    en4 <= en and not load and segL(3) and minL(3) and not minH(3);

    sL : entity work.dec_counter port map (
        clock => clock,
        reset => reset,
        load  => en1,
        en    => en2,
        first_value => init_time(3 downto 0),
        limit => x"9",
        cont  => segL
    );

    sH : entity work.dec_counter port map (
        clock => clock,
        reset => reset,
        load  => en2,
        en    => en3,
        first_value => init_time(7 downto 4),
        limit => x"5",
        cont  => segH
    );

    mL : entity work.dec_counter port map (
        clock => clock,
        reset => reset,
        load  => en3,
        en    => en4,
        first_value => "0100", -- 4 minutos
        limit => x"9",
        cont  => minL
    );

    mH : entity work.dec_counter port map (
        clock => clock,
        reset => reset,
        load  => en4,
        en    => '1',
        first_value => "0000",
        limit => x"9",
        cont  => minH
    );

    cont <= minH & minL & segH & segL;

end a1;
