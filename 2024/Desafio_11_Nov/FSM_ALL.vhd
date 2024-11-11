library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detector_sequencias is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        inA   : in  STD_LOGIC;
        inB   : in  STD_LOGIC;
        found : out STD_LOGIC
    );
end detector_sequencias;

architecture Behavioral of detector_sequencias is
    signal foundA_signal : STD_LOGIC;
    signal foundB_signal : STD_LOGIC;
begin
    -- Instanciação da FSM A
    fsmA_inst : entity work.fsm_A
        port map (
            clk    => clk,
            reset  => reset,
            inA    => inA,
            foundA => foundA_signal
        );

    -- Instanciação da FSM B
    fsmB_inst : entity work.fsm_B
        port map (
            clk    => clk,
            reset  => reset,
            inB    => inB,
            foundB => foundB_signal
        );

    -- Lógica para o sinal 'found'
    found <= '1' when (foundA_signal = '1' and foundB_signal = '1') else '0';

end Behavioral;