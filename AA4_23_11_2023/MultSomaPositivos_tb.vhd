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
    dut: MultSomaPositivos
        generic map (
            N => N
        )
        port map (
            clock => clock_tb,
            reset => reset_tb,
            C => C_tb,
            D => D_tb,
            MS => MS_tb
        );

    clock_process: process
    begin
        while now < 100 ns loop
            clock_tb <= '0';
            wait for 5 ns;
            clock_tb <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    test_process: process
    begin
        -- Define os vetores C e D
        C_tb <= "10101010"; -- Vetor C: 170 em decimal
        D_tb <= "01101110"; -- Vetor D: 110 em decimal
        
        -- Sinaliza reset e aguarda um ciclo de clock
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';
        
        -- Aguarda um pouco para a saída estabilizar
        wait for 100 ns;
        
        -- Verifica o resultado esperado
        assert MS_tb = "1010110001000100"
            report "Resultado incorreto"
            severity error;
        
        wait;
    end process;

end architecture testbench;
