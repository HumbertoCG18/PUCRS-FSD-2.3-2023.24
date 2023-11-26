library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MultSomaPositivos_tb is
end entity MultSomaPositivos_tb;

architecture testbench of MultSomaPositivos_tb is
    constant N : integer := 8; -- Tamanho do vetor

    signal clock_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal C_tb : std_logic_vector(N-1 downto 0) := (others => '0');
    signal D_tb : std_logic_vector(N-1 downto 0) := (others => '0');
    signal MS_tb : std_logic_vector(N*2-1 downto 0);

    file mem_dump_file: text;
    
    component MultSomaPositivos
        generic (
            N : integer := 8
        );
        port (
            clock   : in std_logic;
            reset   : in std_logic;
            C       : in std_logic_vector(N-1 downto 0);
            D       : in std_logic_vector(N-1 downto 0);
            MS      : out std_logic_vector(N*2-1 downto 0)
        );
    end component;

begin
    --... (restante do seu código) ...
    
    -- Lógica para criar o arquivo de dump no início da simulação
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
        write(mem_dump_file, "C_tb = " & to_string(C_tb));
        write(mem_dump_file, "D_tb = " & to_string(D_tb));
        
        -- Loop para acompanhar a simulação
        while now < 500 ns loop
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
