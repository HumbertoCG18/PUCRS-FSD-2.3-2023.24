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
		abc			: in    std_logic_vector(2 downto 0);		-- entrada de dados.
		display		: out   std_logic_vector(6 downto 0)	-- Ya Yb Yc Yd Ye Yf Yg.
    );
end decoder_facil;

architecture arc_decoder_facil of decoder_facil is

begin

	decoder: process(abc)
	begin

		if abc = "000" then
			display <= "1000111";

		elsif abc = "001" then
			display <= "1110111";

		elsif abc = "010" then
			display <= "1001110";

		elsif abc = "011" then
			display <= "0000110";

		elsif abc = "100" then
			display <= "0001110";

		else
			display <= "0000000";

		end if;
	end process decoder;
                                                        
end arc_decoder_facil;

