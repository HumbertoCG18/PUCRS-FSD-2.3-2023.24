library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;

entity tb_relogio_xadrez is
end tb_relogio_xadrez;

architecture test of tb_relogio_xadrez is
    signal clock, reset, load, en, j1, j2 : std_logic;
    signal init_time : std_logic_vector(7 downto 0);
    signal contj1, contj2 : std_logic_vector(15 downto 0);
    signal winJ1, winJ2 : std_logic;
begin
    uut: entity work.relogio_xadrez
        port map (
            clock => clock,
            reset => reset,
            load => load,
            en => en,
            init_time => init_time,
            j1 => j1,
            j2 => j2,
            contj1 => contj1,
            contj2 => contj2,
            winJ1 => winJ1,
            winJ2 => winJ2
        );

    clock_process : process
    begin
        while now < 1000 ms loop
            clock <= '0';
            wait for 5 ns;
            clock <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    stimulus : process
    begin
        reset <= '1';
        load <= '0';
        en <= '0';
        j1 <= '0';
        j2 <= '0';
        init_time <= "00000100"; -- Defina o tempo inicial conforme necessário

        wait for 10 ns;
        reset <= '0';

        -- Exemplo de partida
        wait for 10 ns;
        load <= '1';
        init_time <= x"20"; -- Inicializa com 20 minutos
        wait for 10 ns;
        load <= '0';
        j1 <= '1'; -- Jogador 1 começa
        wait for 120 ns;
        j1 <= '0';
        j2 <= '1'; -- Jogador 2 joga
        wait for 120 ns;
        j2 <= '0';
        j1 <= '1'; -- Jogador 1 joga
        wait for 240 ns;
        j1 <= '0';
        j2 <= '1'; -- Jogador 2 joga
        wait;
    end process;
end test;
