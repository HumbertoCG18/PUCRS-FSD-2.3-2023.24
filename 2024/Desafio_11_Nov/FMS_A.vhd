library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_A is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        inA    : in  STD_LOGIC;
        foundA : out STD_LOGIC
    );
end fsm_A;

architecture Behavioral of fsm_A is
    type state_type is (A0, A1, A2, A3, A4);
    signal state, next_state : state_type;
begin
    -- Processos de Estado
    process(clk, reset)
    begin
        if reset = '1' then
            state <= A0;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    -- Lógica de Próximo Estado e Saída
    process(state, inA)
    begin
        case state is
            when A0 =>
                if inA = '0' then
                    next_state <= A1;
                else
                    next_state <= A0;
                end if;
                foundA <= '0';
            when A1 =>
                if inA = '1' then
                    next_state <= A2;
                else
                    next_state <= A1;
                end if;
                foundA <= '0';
            when A2 =>
                if inA = '1' then
                    next_state <= A3;
                else
                    next_state <= A0;
                end if;
                foundA <= '0';
            when A3 =>
                if inA = '0' then
                    next_state <= A4;
                else
                    next_state <= A0;
                end if;
                foundA <= '0';
            when A4 =>
                next_state <= A0;  -- Retorna ao estado inicial
                foundA <= '1';
        end case;
    end process;
end Behavioral;