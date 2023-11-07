library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;

entity relogio_xadrez is
    port (
        reset : in std_logic;
        clock : in std_logic;
        load : in std_logic;
        init_time : in std_logic_vector(7 downto 0);
        j1, j2 : in std_logic;
        contj1, contj2 : out std_logic_vector(15 downto 0);
        winJ1, winJ2 : out std_logic
    );
end relogio_xadrez;

architecture Behavioral of relogio_xadrez is
    signal en1, en2 : std_logic := '0'; -- Sinais de habilitação para temporizadores 1 e 2
    signal state : std_logic_vector(1 downto 0) := "00"; -- Define os estados da FSM
    signal timeout1, timeout2 : std_logic := '0'; -- Sinais para indicar timeout de jogadores

    -- Declare outros sinais internos necessários aqui

begin
    process (reset, clock)
    begin
        if reset = '1' then
            -- Inicialize os sinais e a lógica necessária para o estado inicial aqui
            en1 <= '0';
            en2 <= '0';
            state <= "00";
            timeout1 <= '0';
            timeout2 <= '0';
        elsif rising_edge(clock) then
            -- Implemente a lógica da FSM aqui
            case state is
                when "00" =>
                    -- Estado inicial
                    if load = '1' then
                        -- Inicia a contagem dos temporizadores
                        en1 <= '1';
                        en2 <= '1';
                        state <= "01";
                    end if;
                when "01" =>
                    -- Aguardando a jogada do Jogador 1
                    if j1 = '1' then
                        -- Jogador 1 iniciou sua jogada
                        en1 <= '0';
                        state <= "10";
                    elsif timeout1 = '1' then
                        -- Timeout do Jogador 1
                        en1 <= '0';
                        state <= "11";
                    end if;
                when "10" =>
                    -- Aguardando a jogada do Jogador 2
                    if j2 = '1' then
                        -- Jogador 2 iniciou sua jogada
                        en2 <= '0';
                        state <= "01";
                    elsif timeout2 = '1' then
                        -- Timeout do Jogador 2
                        en2 <= '0';
                        state <= "11";
                    end if;
                when "11" =>
                    -- Jogo encerrado por timeout de um jogador
                    null; -- Pode adicionar lógica adicional se necessário
            end case;
        end if;
    end process;

    -- Instancie os módulos temporizadores aqui
    temporizador_1 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load => load,
        en => en1,
        init_time => init_time,
        cont => contj1
    );

    temporizador_2 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load => load,
        en => en2,
        init_time => init_time,
        cont => contj2
    );
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

end Behavioral;
