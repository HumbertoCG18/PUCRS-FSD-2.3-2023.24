library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity NanoCPU_TB is
end NanoCPU_TB;

architecture TB of NanoCPU_TB is

    signal ck, rst: std_logic := '0';
    signal dataR, dataW: std_logic_vector(15 downto 0);
    signal address: std_logic_vector(7 downto 0);
    signal we, ce: std_logic;

    -- Memory array signal for 256 x 16-bit positions
    type memoryArray is array (0 to 255) of std_logic_vector(15 downto 0);

    signal memory: memoryArray := (
        -- Inicialização dos registradores
        0  => X"4000",  -- iXOR R0, R0, R0        ; R0 <= 0 (constante zero)
        1  => X"4111",  -- iXOR R1, R1, R1        ; R1 <= 0 (fib1)
        2  => X"4222",  -- iXOR R2, R2, R2        ; R2 <= 0 (fib2)
        3  => X"8220",  -- iINC R2, R2            ; R2 <= R2 + 1 (fib2 = 1)
        4  => X"0130",  -- iREAD R3, 20           ; R3 <= M[20] (N)
        5  => X"0157",  -- iREAD R7, 21           ; R7 <= M[21] (-1)
        6  => X"4666",  -- iXOR R6, R6, R6        ; R6 <= 0
        7  => X"8660",  -- iINC R6, R6            ; R6 <= R6 + 1 (R6 = 1)

        -- Loop principal
        8  => X"1011",  -- iWRITE R1, 22          ; M[22] <= R1 (armazena fib1)
        9  => X"6337",  -- iADD R3, R3, R7        ; R3 <= R3 + (-1) (decrementa N)
        10 => X"7043",  -- iLESS R4, R0, R3       ; R4 <= 1 se R0 < R3 (N > 0)
        11 => X"30D4",  -- iBRANCH 13, R4         ; Se R4 == 1, salta para endereço 13
        12 => X"F000",  -- END                    ; Fim do programa

        -- Cálculo do próximo número
        13 => X"6512",  -- iADD R5, R1, R2        ; R5 <= R1 + R2 (next)
        14 => X"4120",  -- iXOR R1, R2, R0        ; R1 <= R2 (fib1 = fib2)
        15 => X"4250",  -- iXOR R2, R5, R0        ; R2 <= R5 (fib2 = next)
        16 => X"3086",  -- iBRANCH 8, R6          ; Salta incondicionalmente para endereço 8

        -- Dados iniciais
        20 => X"000E",  -- N = 14
        21 => X"FFFF",  -- -1 (para decremento)
        22 => X"0000",  -- Local para armazenar o resultado

        others => (others => '0')
    );

begin

    rst <= '1', '0' after 2 ns;        -- Gera o sinal de reset
    ck  <= not ck after 1 ns;          -- Gera o sinal de clock

    CPU: entity work.nanoCPU port map (
        ck      => ck,
        rst     => rst,
        address => address,
        dataR   => dataR,
        dataW   => dataW,
        ce      => ce,
        we      => we
    );

    -- Escrita na memória
    process(ck)
    begin
        if rising_edge(ck) then
            if we = '1' then
                memory(to_integer(unsigned(address))) <= dataW; 
            end if;
        end if;
    end process;

    dataR <= memory(to_integer(unsigned(address)));   -- Leitura da memória

end TB;
