library ieee;
use ieee.std_logic_1164.all;

entity detector is 
    port (
        clk, rst: in std_logic;
        din:      in std_logic;
        dout:     out std_logic
    )
end entity;

architecture comportamento of detector is 
    type estadosDoDetector is (S0, S1, S11, S110, S1101);
    signal EA, PE: estadosDoDetector;

begin 

    -- DEFINIÇÃO ESTÁDO ATUAL 
    process(clk, rst)
    begin
       if (rst='1') then
        EA <= S0;
    elseif (rising_edge(clk))then 
        EA <= PE;
    end if;
    end process;

    -- CALCULO PRÓXIMO ESTADO
    process(EA, din)
    begin
        case(EA)
        when S0    =>
            if (din='1')then
                PE <= S1;
            else
                PE <= S0;
            end if;
        when S1    =>
            if (din='1')then
                PE <= S11;
            else
                PE <= S0;
            end if;
        when S11   =>
        if (din='1')then
                PE <= S11;
            else
                PE <= S110;
            end if;
        when S110  =>
        if (din='1')then
                PE <= S1101;
            else
                PE <= S0;
            end if;
        when S1101 =>
        if (din='1')then
                PE <= S11;
            else
                PE <= S0;
            end if;
        end case;
    end process;

    -- Lógica de Saida
    process (EA)
    begin 
        if (EA=S1101) then 
          dout <='1';
        else 
          dout <='0';
        end if;
    end process;
    end;