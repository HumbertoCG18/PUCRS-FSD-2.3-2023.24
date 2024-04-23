--------------------------------------------------
-- File:    bcd_decoder.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;   
  
entity bcd_decoder is
    port
    (
        num_in      : in    std_logic_vector(2 downto 0);		-- entrada de dados.
        
        -- interface com o display.					
        bcd_out     : out   std_logic_vector(7 downto 0)		-- Ya Yb Yc Yd Ye Yf Yg Ypto.
    );
end bcd_decoder;

architecture bcd_decoder of bcd_decoder is

begin

    -- display acionado por nível lógico alto.
    bcd_out <=  "10001110"  when num_in = "000" else  -- F
                "11101110"  when num_in = "001" else  -- A
                "10011100"  when num_in = "010" else  -- C
                "00001100"  when num_in = "011" else  -- I
                "00011100"  when num_in = "100" else  -- L
                "00000000";								-- condição padrão desliga tudo.            
                                                        
end bcd_decoder;

