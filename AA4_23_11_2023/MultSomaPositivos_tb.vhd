library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MultSomaPositivos_tb is
end entity MultSomaPositivos_tb;

architecture testbench of MultSomaPositivos_tb is
    constant N : integer := 8; -- Tamanho do vetor

    signal clock_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal A_tb, B_tb : std_logic_vector(N-1 downto 0) := (others => '0');
    signal MS_tb : std_logic_vector(N*2-1 downto 0);

    file mem_dump_file: text;
    
    component MultSomaPositivos
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
    end component;

begin
    DUT: MultSomaPositivos
        generic map (
            N => N
        )
        port map (
            clock => clock_tb,
            reset => reset_tb,
            A     => A_tb,
            B     => B_tb,
            MS    => MS_tb
        );
    
    clock_process: process
    begin
        while now < 1000 ns loop
            clock_tb <= '0';
            wait for 5 ns;
            clock_tb <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process clock_process;

    stimulus: process
    begin
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';
        
        -- Inserindo valores nos vetores A e B para o teste
        A_tb <= "10101010"; -- Altere conforme necessário
        B_tb <= "01100110"; -- Altere conforme necessário
        
        wait for 100 ns;
        wait;
    end process stimulus;

    -- Processo de escrita do arquivo de dump
    process
        variable file_opened : boolean := FALSE;
    begin
        file_opened := FALSE;
        wait for 0 ns;
        
        -- Abre o arquivo de dump
        file_open(mem_dump_file, "mips.txt", write_mode);
        file_opened := TRUE;
        
        -- Captura os valores iniciais
        report "Início da simulação" severity note;
        write(mem_dump_file, "Valores iniciais:");
        write(mem_dump_file, "A_tb = " & to_string(A_tb));
        write(mem_dump_file, "B_tb = " & to_string(B_tb));
        
        -- Loop para acompanhar a simulação
        while now < 1000 ns loop
            wait for 1 ns;
        end loop;
        
        -- Captura os valores finais
        write(mem_dump_file, "Fim da simulação:");
        write(mem_dump_file, "MS_tb = " & to_string(MS_tb));
        
        -- Fecha o arquivo no final da simulação
        if file_opened then
            file_close(mem_dump_file);
        end if;
        wait;
    end process;
    
end architecture testbench;
