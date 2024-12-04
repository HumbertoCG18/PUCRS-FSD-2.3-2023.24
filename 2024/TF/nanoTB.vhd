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

    signal memory: memoryArray :=

    (
        -- Initialize R0, R1, R2, and read N into R3
        0  => X"4000",      -- iXOR R0, R0, R0       ; R0 <= 0
        1  => X"4111",      -- iXOR R1, R1, R1       ; R1 <= 0 (fib1 = 0)
        2  => X"8200",      -- iINC R2               ; R2 <= R2 + 1 (fib2 = 1)
        3  => X"0143",      -- iREAD R3, 20          ; R3 <= MEM[20] (N)

        -- Loop Start
        4  => X"1151",      -- iWRITE R1, 21         ; MEM[21] <= fib1
        5  => X"6312",      -- iADD R3, R1, R2       ; R3 = fib1 + fib2 (next)
        6  => X"4120",      -- iXOR R1, R2, R0       ; fib1 = fib2
        7  => X"4230",      -- iXOR R2, R3, R0       ; fib2 = next
        8  => X"9300",      -- iDEC R3               ; R3 = R3 - 1 (decrement N)
        9  => X"1143",      -- iWRITE R3, 20         ; MEM[20] <= R3 (update N)
        10 => X"7303",      -- iLESS R3, R0, R3      ; R3 = 1 if R0 < R3 else 0
        11 => X"3043",      -- iBRANCH 4, R3         ; If R3 == 1, jump to address 4
        12 => X"F000",      -- END                   ; Halt execution

        -- Data Memory
        20 => X"000E",      -- N = 14                ; Number of Fibonacci numbers to calculate
        21 => X"0000",      -- Placeholder for fib1  ; Receives Fibonacci numbers

        others => (others => '0')
    );

begin

    rst <= '1', '0' after 2 ns;        -- Generates the reset signal
    ck  <= not ck after 1 ns;          -- Generates the clock signal 

    CPU: entity work.nanoCPU port map
    (
        ck      => ck,
        rst     => rst,
        address => address,
        dataR   => dataR,
        dataW   => dataW,
        ce      => ce,
        we      => we
    ); 

    -- Memory Write Process
    process(ck)
    begin
        if rising_edge(ck) then
            if we = '1' then
                memory(CONV_INTEGER(address)) <= dataW; 
            end if;
        end if;
    end process;

    dataR <= memory(CONV_INTEGER(address));   -- Memory Read

end TB;
