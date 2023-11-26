library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MultSomaPositivos is
    generic (
        N : integer := 8  -- Tamanho do vetor
    );
    port (
        clock   : in std_logic;
        reset   : in std_logic;
        C       : in std_logic_vector(N-1 downto 0); -- Vetor C
        D       : in std_logic_vector(N-1 downto 0); -- Vetor D
        MS      : out std_logic_vector(N*2-1 downto 0) -- Resultado da multiplicação das somas dos valores positivos
    );
end entity MultSomaPositivos;

architecture Behavioral of MultSomaPositivos is
    signal sumC, sumD : unsigned(N downto 0) := (others => '0'); -- Sinais para armazenar as somas dos valores positivos de C e D
begin
    process(clock, reset)
        variable prod : unsigned(N*2-1 downto 0) := (others => '0'); -- Variável para armazenar o resultado da multiplicação
    begin
        if reset = '1' then
            MS <= (others => '0');
            sumC <= (others => '0');
            sumD <= (others => '0');
        elsif rising_edge(clock) then
            -- Soma dos valores positivos de C
            for i in 0 to N-1 loop
                if C(i) = '1' then
                    sumC <= sumC + to_unsigned(i, N+1);
                end if;
            end loop;

            -- Soma dos valores positivos de D
            for i in 0 to N-1 loop
                if D(i) = '1' then
                    sumD <= sumD + to_unsigned(i, N+1);
                end if;
            end loop;

            -- Multiplicação das somas
            prod := sumC * sumD;

            MS <= std_logic_vector(prod); -- Resultado final da multiplicação das somas dos valores positivos
        end if;
    end process;
end architecture Behavioral;
