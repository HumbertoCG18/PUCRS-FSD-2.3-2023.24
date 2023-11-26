library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OperacoesVetor is
    generic (
        N : integer := 8  -- Tamanho do vetor
    );
    port (
        clock   : in std_logic;           -- Sinal de clock
        reset   : in std_logic;           -- Sinal de reset
        A       : in signed(N-1 downto 0); -- Vetor A de entrada
        B       : in signed(N-1 downto 0); -- Vetor B de entrada
        C       : out signed(N-1 downto 0); -- Vetor C de saída (soma)
        D       : out signed(N-1 downto 0)  -- Vetor D de saída (subtração)
    );
end entity OperacoesVetor;

architecture Behavioral of OperacoesVetor is
    signal soma_temp : signed(N downto 0); -- Adicione +1 ao tamanho para evitar estouro
    signal sub_temp : signed(N downto 0);  -- Adicione +1 ao tamanho para evitar estouro
begin
    process(clock, reset)
    begin
        if reset = '1' then
            soma_temp <= (others => '0');
            sub_temp <= (others => '0');
        elsif rising_edge(clock) then
            for i in 0 to N-1 loop
                soma_temp <= soma_temp + ('0' & A(i)) + ('0' & B(i));  -- Soma dos elementos de A e B
                sub_temp <= sub_temp + ('0' & A(i)) - ('0' & B(i));    -- Subtração dos elementos de A e B
            end loop;
            
            C <= soma_temp(N-1 downto 0);  -- Atribui o resultado da soma à saída C
            D <= sub_temp(N-1 downto 0);   -- Atribui o resultado da subtração à saída D
        end if;
    end process;
end architecture Behavioral;
