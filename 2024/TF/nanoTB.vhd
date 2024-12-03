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
        -- Initialize R0, R1, and R2
        0  => X"4000",      -- iXOR R0, R0, R0       ; R0 <= 0
        1  => X"4111",      -- iXOR R1, R1, R1       ; R1 <= 0 (fib1 = 0)
        2  => X"8200",      -- iINC R2               ; R2 <= R2 + 1 (fib2 = 1)

        -- Step 1: Store fib1 and fib2 in memory
        3  => X"1151",      -- iWRITE R1, 21         ; MEM[21] <= fib1
        4  => X"1162",      -- iWRITE R2, 20         ; MEM[20] <= fib2

        -- Compute Fibonacci numbers step by step
        -- Step 2
        5  => X"6312",      -- iADD R3, R1, R2       ; R3 = fib1 + fib2 (next)
        6  => X"4120",      -- iXOR R1, R2, R0       ; fib1 = fib2
        7  => X"4230",      -- iXOR R2, R3, R0       ; fib2 = next
        8  => X"1151",      -- iWRITE R1, 21         ; MEM[21] <= fib1
        9  => X"1162",      -- iWRITE R2, 20         ; MEM[20] <= fib2

        -- Step 3
        10 => X"6312",      -- iADD R3, R1, R2       ; R3 = fib1 + fib2
        11 => X"4120",      -- iXOR R1, R2, R0       ; fib1 = fib2
        12 => X"4230",      -- iXOR R2, R3, R0       ; fib2 = next
        13 => X"1151",      -- iWRITE R1, 21         ; MEM[21] <= fib1
        14 => X"1162",      -- iWRITE R2, 20         ; MEM[20] <= fib2

        -- Step 4
        15 => X"6312",      -- iADD R3, R1, R2
        16 => X"4120",      -- iXOR R1, R2, R0
        17 => X"4230",      -- iXOR R2, R3, R0
        18 => X"1151",      -- iWRITE R1, 21
        19 => X"1162",      -- iWRITE R2, 20

        -- Step 5
        20 => X"6312",
        21 => X"4120",
        22 => X"4230",
        23 => X"1151",
        24 => X"1162",

        -- Step 6
        25 => X"6312",
        26 => X"4120",
        27 => X"4230",
        28 => X"1151",
        29 => X"1162",

        -- Step 7
        30 => X"6312",
        31 => X"4120",
        32 => X"4230",
        33 => X"1151",
        34 => X"1162",

        -- Step 8
        35 => X"6312",
        36 => X"4120",
        37 => X"4230",
        38 => X"1151",
        39 => X"1162",

        -- Step 9
        40 => X"6312",
        41 => X"4120",
        42 => X"4230",
        43 => X"1151",
        44 => X"1162",

        -- Step 10
        45 => X"6312",
        46 => X"4120",
        47 => X"4230",
        48 => X"1151",
        49 => X"1162",

        -- Step 11
        50 => X"6312",
        51 => X"4120",
        52 => X"4230",
        53 => X"1151",
        54 => X"1162",

        -- Step 12
        55 => X"6312",
        56 => X"4120",
        57 => X"4230",
        58 => X"1151",
        59 => X"1162",

        -- Step 13
        60 => X"6312",
        61 => X"4120",
        62 => X"4230",
        63 => X"1151",
        64 => X"1162",

        -- Step 14
        65 => X"6312",
        66 => X"4120",
        67 => X"4230",
        68 => X"1151",
        69 => X"1162",

        -- End of Program
        70 => X"F000",      -- END                   ; Halt execution

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
