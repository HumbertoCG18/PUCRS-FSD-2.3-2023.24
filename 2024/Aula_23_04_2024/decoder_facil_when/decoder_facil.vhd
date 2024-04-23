--------------------------------------------------
-- File:    bcd_decoder.vhd
-- Author:  Prof. M.Sc. Marlon Moraes
-- E-mail:  marlon.moraes@pucrs.br
--------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;   
  
entity decoder_facil is
    port
    (
        abc		: in	std_logic_vector(2 downto 0);		-- entrada de dados.
        display	: out	std_logic_vector(6 downto 0)		-- Ya Yb Yc Yd Ye Yf Yg.
    );
end decoder_facil;

architecture arc_decoder_facil  of decoder_facil is

begin

    -- display acionado por nível lógico alto.
    display <=  "1000111"  when abc = "000" else  -- F
                "1110111"  when abc = "001" else  -- A
                "1001110"  when abc = "010" else  -- C
                "0000110"  when abc = "011" else  -- I
                "0001110"  when abc = "100" else  -- L
                "0000000";								-- condição padrão desliga tudo.            
                                                        
end arc_decoder_facil ;

