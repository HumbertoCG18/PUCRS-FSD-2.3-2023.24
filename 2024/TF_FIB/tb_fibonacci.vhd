library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_fibonacci is
end tb_fibonacci;

architecture Behavioral of tb_fibonacci is
    component fibonacci
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               enable : in STD_LOGIC;
               fib_out : out STD_LOGIC_VECTOR(31 downto 0);
               valid : out STD_LOGIC);
    end component;
    
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '0';
    signal fib_out : STD_LOGIC_VECTOR(31 downto 0);
    signal valid : STD_LOGIC;
    
    constant clk_period : time := 10 ns;
    
begin
    uut: fibonacci Port map (
        clk => clk,
        reset => reset,
        enable => enable,
        fib_out => fib_out,
        valid => valid
    );
    
    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin
        -- Reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Enable and generate first 15 Fibonacci numbers
        enable <= '1';
        for i in 0 to 14 loop
            wait for clk_period;
            report "Fibonacci[" & integer'image(i) & "] = " & 
                   integer'image(to_integer(unsigned(fib_out)));
        end loop;
        
        -- Disable
        enable <= '0';
        wait for 50 ns;
        
        -- End simulation
        wait;
    end process;
end Behavioral;