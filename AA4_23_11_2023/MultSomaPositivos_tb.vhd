library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MultSomaPositivos is
    generic (
        N : integer := 8
    );
    port (
        clock   : in std_logic;
        reset   : in std_logic;
        A       : in std_logic_vector(N-1 downto 0);
        B       : in std_logic_vector(N-1 downto 0);
        MS      : out std_logic_vector(N*2-1 downto 0)
    );
end entity MultSomaPositivos;

architecture Behavioral of MultSomaPositivos is
    signal C, D : std_logic_vector(N-1 downto 0);
    signal sum_C, sum_D : integer := 0;
    signal mult_result : integer := 0;
begin
    process(clock, reset)
        variable i : integer;
        variable temp_val_C, temp_val_D : integer;
    begin
        if reset = '1' then
            -- Reinicializa valores
            C <= (others => '0');
            D <= (others => '0');
            sum_C <= 0;
            sum_D <= 0;
            mult_result <= 0;
        elsif rising_edge(clock) then
            if A /= B then
                -- Adição e subtração dos vetores A e B
                for i in 0 to N-1 loop
                    C(i) <= A(i) + B(i);
                    D(i) <= A(i) - B(i);
                end loop;
            end if;

            -- Cálculo da soma dos valores positivos de C
            for i in 0 to N-1 loop
                if C(i) >= '0' then
                    temp_val_C := to_integer(unsigned(C(i)));
                    sum_C <= sum_C + temp_val_C;
                end if;
            end loop;

            -- Cálculo da soma dos valores positivos de D
            for i in 0 to N-1 loop
                if D(i) >= '0' then
                    temp_val_D := to_integer(unsigned(D(i)));
                    sum_D <= sum_D + temp_val_D;
                end if;
            end loop;

            -- Multiplicação das somas dos valores positivos de C e D
            mult_result <= sum_C * sum_D;

            -- Saída final
            MS <= std_logic_vector(to_unsigned(mult_result, N*2));
        end if;
    end process;
end architecture Behavioral;
