library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fibonacci is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           fib_out : out STD_LOGIC_VECTOR(31 downto 0);
           valid : out STD_LOGIC);
end fibonacci;

architecture Behavioral of fibonacci is
    signal fib_current : unsigned(31 downto 0) := (others => '0');
    signal fib_next : unsigned(31 downto 0) := to_unsigned(1, 32);
    signal fib_temp : unsigned(31 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            fib_current <= (others => '0');
            fib_next <= to_unsigned(1, 32);
            valid <= '0';
        elsif rising_edge(clk) then
            if enable = '1' then
                fib_temp <= fib_current + fib_next;
                fib_current <= fib_next;
                fib_next <= fib_temp;
                valid <= '1';
            else
                valid <= '0';
            end if;
        end if;
    end process;
    
    fib_out <= std_logic_vector(fib_current);
end Behavioral;