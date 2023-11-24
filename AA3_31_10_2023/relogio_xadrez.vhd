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

architecture a1 of relogio_xadrez is
    signal clock_int, reset_int, load_int, en_int, j1_int, j2_int : std_logic;
    signal init_time_int : std_logic_vector(7 downto 0);
    signal contj1_int, contj2_int : std_logic_vector(15 downto 0);
    signal winJ1_int, winJ2_int : std_logic;
begin

    clock_int <= clock;
    reset_int <= reset;
    load_int <= load;
    en_int <= '1'; -- Sempre habilitado
    j1_int <= j1;
    j2_int <= j2;
    init_time_int <= init_time;

    contador1 : entity work.temporizador port map (
            clock => clock_int,
            reset => reset_int,
            load => load_int,
            en => en_int,
            init_time => init_time_int,
            cont => contj1_int
        );

    contador2 : entity work.temporizador port map (
            clock => clock_int,
            reset => reset_int,
            load => load_int,
            en => en_int,
            init_time => init_time_int,
            cont => contj2_int
        );

    process
    begin
        wait for 100 ns; -- Aguarda inicialização do temporizador
        wait until j1_int = '1'; -- Espera pelo início do jogador 1
        winJ1_int <= '0';
        winJ2_int <= '0';
        wait until contj1_int = "0000000000000100"; -- Verifica se o jogador 1 atingiu 4 segundos
        winJ1_int <= '1';
        wait;
    end process;

    process
    begin
        wait for 100 ns; -- Aguarda inicialização do temporizador
        wait until j2_int = '1'; -- Espera pelo início do jogador 2
        winJ1_int <= '0';
        winJ2_int <= '0';
        wait until contj2_int = "0000000000000100"; -- Verifica se o jogador 2 atingiu 4 segundos
        winJ2_int <= '1';
        wait;
    end process;

    contj1 <= contj1_int;
    contj2 <= contj2_int;
    winJ1 <= winJ1_int;
    winJ2 <= winJ2_int;

end a1;
