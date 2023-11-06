library IEEE;
use ieee.std_logic_1164.all;
library ieee;
use ieee.std_logic_unsigned.all;
library work;

entity relogio_xadrez is
    port( 
        clock, reset, load, en : in std_logic;
        j1, j2 : in std_logic;
        contj1, contj2 : out std_logic_vector(15 downto 0);
        winJ1, winJ2 : out std_logic
    );
end relogio_xadrez;

architecture relogio_xadrez of relogio_xadrez is
    -- DECLARACAO DOS ESTADOS
    type states is (EA, PE, J1Joga, J2Joga, J1Ganha, J2Ganha, Empate);
    signal estado_atual, prox_estado : states;
    signal conta_tempo, tempo_anterior, vetor : integer := 0;
    signal tempo_j1, tempo_j2 : integer := 0;
    signal cont_temp1, cont_temp2 : std_logic_vector(15 downto 0);
begin

    temporizador1 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load  => load,
        en    => en,
        init_time => x"00",  -- Defina o valor inicial conforme necessário
        cont  => cont_temp1
    );

    temporizador2 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load  => load,
        en    => en,
        init_time => x"00",  -- Defina o valor inicial conforme necessário
        cont  => cont_temp2
    );

    process (clock, reset)
    begin
        if reset = '1' then
            estado_atual <= EA;
            prox_estado  <= EA;
            tempo_j1 <= 0;
            tempo_j2 <= 0;
        elsif rising_edge(clock) then
            estado_atual <= prox_estado;

            -- Lógica de transição de estados
            case estado_atual is
                when EA =>
                    prox_estado <= PE;
                when PE =>
                    if j1 = '1' then
                        prox_estado <= J1Joga;
                        tempo_j1 <= cont_temp1;
                        tempo_j2 <= 0;
                    elsif j2 = '1' then
                        prox_estado <= J2Joga;
                        tempo_j1 <= 0;
                        tempo_j2 <= cont_temp2;
                    else
                        prox_estado <= PE;
                    end if;
                when J1Joga =>
                    if tempo_j1 = 0 then
                        prox_estado <= J2Ganha;
                    else
                        prox_estado <= J1Joga;
                    end if;
                when J2Joga =>
                    if tempo_j2 = 0 then
                        prox_estado <= J1Ganha;
                    else
                        prox_estado <= J2Joga;
                    end if;
                when J1Ganha =>
                    prox_estado <= EA;
                when J2Ganha =>
                    prox_estado <= EA;
                when Empate =>
                    prox_estado <= EA;
            end case;
        end if;
    end process;

    process (estado_atual, cont_temp1, cont_temp2, j1, j2)
    begin
        case estado_atual is
            when J1Ganha =>
                winJ1 <= '1';
                winJ2 <= '0';
            when J2Ganha =>
                winJ1 <= '0';
                winJ2 <= '1';
            when Empate =>
                winJ1 <= '0';
                winJ2 <= '0';
            when others =>
                winJ1 <= '0';
                winJ2 <= '0';
        end case;

        contj1 <= cont_temp1;
        contj2 <= cont_temp2;
    end process;

end relogio_xadrez;
