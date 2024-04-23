--------------------------------------------------
-- Prof. Marlon Moraes
-- marlon.moraes@pucrs.br
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

architecture arc_decoder_facil of decoder_facil is

begin

    -- display acionado por nível lógico alto.
	with abc select
		display <= 	"1000111"	when 	"000",		-- F                             	
					"1110111"	when 	"001",		-- A                             
					"1001110"	when 	"010",		-- C                             
					"0000110"	when 	"011",		-- I                             
					"0001110"	when 	"100",		-- L                             
					"0000000" 	when others;		-- condição padrão desliga tudo.
                                                        
end arc_decoder_facil;

