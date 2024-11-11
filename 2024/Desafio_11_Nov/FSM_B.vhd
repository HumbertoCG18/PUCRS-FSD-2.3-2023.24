library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_B is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        inB    : in  STD_LOGIC;
        foundB : out STD_LOGIC
    );
end fsm_B;

architecture Behavioral of fsm_B is
    type state_type is (B0, B1, B2, B3, B4, B5);
    signal state, next_state : state_type;
begin
    -- Processos de Estado
    process(clk, reset)
    begin
        if reset = '1' then
            state <= B0;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    -- Lógica de Próximo Estado e Saída
    process(state, inB)
    begin
        case state is
            when B0 =>
                if inB = '1' then
                    next_state <= B1;
                else
                    next_state <= B0;
                end if;
                foundB <= '0';
            when B1 =>
                if inB = '1' then
                    next_state <= B2;
                else
                    next_state <= B0;
                end if;
                foundB <= '0';
            when B2 =>
                if inB = '0' then
                    next_state <= B3;
                else
                    next_state <= B0;
                end if;
                foundB <= '0';
            when B3 =>
                if inB = '1' then
                    next_state <= B4;
                else
                    next_state <= B0;
                end if;
                foundB <= '0';
            when B4 =>
                if inB = '1' then
                    next_state <= B5;
                else
                    next_state <= B0;
                end if;
                foundB <= '0';
            when B5 =>
                next_state <= B0;  -- Retorna ao estado inicial
                foundB <= '1';
        end case;
    end process;
end Behavioral;