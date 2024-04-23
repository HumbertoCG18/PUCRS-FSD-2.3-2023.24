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
        abc      	: in    std_logic_vector(2 downto 0);		-- abc de dados.
        display     : out   std_logic_vector(6 downto 0)		-- Ya Yb Yc Yd Ye Yf Yg.
    );
end decoder_facil;

architecture arc_decoder_facil of decoder_facil is

begin


	decoder: process(abc)
	begin

		case abc is
			when "000" =>
				display <= "1000111";

			when "001" =>
				display <= "1110111";

			when "010" =>
				display <= "1001110";

			when "011" =>
				display <= "0000110";

			when  "100" =>
				display <= "0001110";

			when others =>
				display <= "0000000";
		end case;

	end process decoder;
                              
end arc_decoder_facil;

