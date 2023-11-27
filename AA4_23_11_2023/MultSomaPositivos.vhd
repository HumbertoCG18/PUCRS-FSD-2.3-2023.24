architecture Behavioral of MultSomaPositivos is
    signal result_C, result_D : std_logic_vector(N-1 downto 0);
    signal sumC, sumD : unsigned(N downto 0) := (others => '0');
begin
    process(clock, reset)
        variable prod : unsigned(N*2-1 downto 0) := (others => '0');
    begin
        if reset = '1' then
            MS <= (others => '0');
            sumC <= (others => '0');
            sumD <= (others => '0');
            result_C <= (others => '0');
            result_D <= (others => '0');
        elsif rising_edge(clock) then
            -- Adição de vetores A e B
            for i in 0 to N-1 loop
                result_C(i) <= A(i) + B(i);
            end loop;

            -- Subtração de vetores A e B
            for i in 0 to N-1 loop
                result_D(i) <= A(i) - B(i);
            end loop;

            -- Soma dos valores positivos de C
            for i in 0 to N-1 loop
                if result_C(i) = '1' then
                    sumC <= sumC + to_unsigned(i, N+1);
                end if;
            end loop;

            -- Soma dos valores positivos de D
            for i in 0 to N-1 loop
                if result_D(i) = '1' then
                    sumD <= sumD + to_unsigned(i, N+1);
                end if;
            end loop;

            -- Multiplicação das somas
            prod := sumC * sumD;

            MS <= std_logic_vector(prod); -- Resultado final da multiplicação das somas dos valores positivos
        end if;
    end process;
end architecture Behavioral;
