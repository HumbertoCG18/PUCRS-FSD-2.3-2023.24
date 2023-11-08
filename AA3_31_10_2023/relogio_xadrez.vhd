library IEEE;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;

entity relogio_xadrez is
    port( reset : in std_logic;
          clock : in std_logic;
          load : in std_logic;
          init_time : in std_logic_vector(7 downto 0);
          j1, j2 : in std_logic;

          contj1, contj2 : out std_logic_vector(15 downto 0);
          winJ1, winJ2 : out std_logic
    );
end relogio_xadrez;

architecture relogio_xadrez of relogio_xadrez is
    type states is (IDLE, J1Joga, J2Joga, J1Ganha, J2Ganha);
    signal  EA, PE  : states    := IDLE;

    signal clock_int, reset_int, load_int, en_int1, en_int2, j1_int, j2_int : std_logic;
    signal init_time_int : std_logic_vector(7 downto 0);
    signal contj1_int, contj2_int : std_logic_vector(15 downto 0);
    signal winJ1_int, winJ2_int : std_logic;

begin

    clock_int <= clock;
    reset_int <= reset;
    load_int <= load;
    j1_int <= j1;
    j2_int <= j2;
    init_time_int <= init_time;

    contador1 : entity work.temporizador port map (
            clock => clock_int,
            reset => reset_int,
            load => load_int,
            en => en_int1,
            init_time => init_time_int,
            cont => contj1_int
        );

    contador2 : entity work.temporizador port map (
            clock => clock_int,
            reset => reset_int,
            load => load_int,
            en => en_int2,
            init_time => init_time_int,
            cont => contj2_int
        );

        process (clock, reset)
        begin
            if reset = '1' then
                EA <= IDLE;
                PE  <= EA;
                reset_int <= '1';
            else if clock'event and clock = '1' then
                    case EA is
                        when IDLE =>
                        en_int1 <= '0';
                        en_int2 <= '0';
                            if j1_int = '1' then
                                en_int1 <= '1';
                                EA <= J1Joga;
                                PE <= J2Joga;
                            else
                                EA <= IDLE;
                            end if;

                        when J1Joga =>
                            if contj1_int = x"0" then
                                EA <= J2Ganha;
                            else if j1_int = '1' then
                                en_int1 <= '0';
                                en_int2 <= '1';
                                EA <= PE;
                                PE <= J1Joga;
                            else
                                EA <= J1Joga;
                            end if;
                            end if;

                        when J2Joga =>
                            if contj2_int = x"0" then
                                EA <= J1Ganha;
                            else if j2_int = '1' then
                                en_int1 <= '1';
                                en_int2 <= '0';
                                EA <= PE;
                                PE <= J2Joga;
                            else
                                EA <= J2Joga;
                            end if;
                            end if;

                        when J1Ganha =>
                            PE <= EA;
                        when J2Ganha =>
                            PE <= EA;
                        end case;
                    end if;
                end if;
            end process;
    
            process (EA, contj1_int, contj2_int, j1, j2)
            begin
                case EA is
                    when J1Ganha =>
                        winJ1_int <= '1';
                        winJ2_int <= '0';
                    when J2Ganha =>
                        winJ1_int <= '0';
                        winJ2_int <= '1';
                    when others =>
                        winJ1_int <= '0';
                        winJ2_int <= '0';
                end case;
            end process;
            contj1 <= contj1_int;
            contj2 <= contj2_int;
            winJ1 <= winJ1_int;
            winJ2 <= winJ2_int;
    end relogio_xadrez;