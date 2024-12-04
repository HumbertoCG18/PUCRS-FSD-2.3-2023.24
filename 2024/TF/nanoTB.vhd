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
        -- Program Instructions
        -- Address => Instruction (Hex),        -- Assembly Comment
        0   => X"0690",   -- iREAD R0, 105      ; R0 <= MEM[105] (C)
        1   => X"0651",   -- iREAD R1, 101      ; R1 <= MEM[101] (fib1)
        2   => X"0662",   -- iREAD R2, 102      ; R2 <= MEM[102] (fib2)
        3   => X"0643",   -- iREAD R3, 100      ; R3 <= MEM[100] (N)
        4   => X"7003",   -- iLESS R0, R0, R3   ; R0 = 1 if R0 < R3 else 0
        5   => X"3070",   -- iBRANCH 7, R0      ; If R0 == 1, jump to address 7
        6   => X"F000",   -- END                ; Halt execution
        7   => X"1671",   -- iWRITE R1, 103     ; MEM[103 + C] <= R1 (store fib1)
        8   => X"6312",   -- iADD R3, R1, R2    ; R3 = R1 + R2 (next)
        9   => X"4000",   -- iXOR R0, R0, R0    ; R0 <= 0
        10  => X"4120",   -- iXOR R1, R2, R0    ; R1 = R2
        11  => X"4230",   -- iXOR R2, R3, R0    ; R2 = R3
        12  => X"0690",   -- iREAD R0, 105      ; R0 <= MEM[105] (C)
        13  => X"0683",   -- iREAD R3, 104      ; R3 <= MEM[104] (1)
        14  => X"6003",   -- iADD R0, R0, R3    ; R0 = R0 + 1 (C = C + 1)
        15  => X"1690",   -- iWRITE R0, 105     ; MEM[105] <= R0 (update C)
        16  => X"1651",   -- iWRITE R1, 101     ; MEM[101] <= R1 (update fib1)
        17  => X"1662",   -- iWRITE R2, 102     ; MEM[102] <= R2 (update fib2)
        18  => X"2000",   -- iJMP 0             ; Jump back to address 0

        -- Data Memory
        100 => X"0006",   -- N = 6              ; Number of Fibonacci numbers to calculate
        101 => X"0000",   -- fib1 = 0
        102 => X"0001",   -- fib2 = 1
        104 => X"0001",   -- Constant 1
        105 => X"0000",   -- C = 0              ; Loop counter

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
