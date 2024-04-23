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

	decoder: process(num_in)
	begin

		if num_in = "000" then
			bcd_out <= "10001110";

		elsif num_in = "001" then
			bcd_out <= "11101110";

		elsif num_in = "010" then
			bcd_out <= "10011100";

		elsif num_in = "011" then
			bcd_out <= "00001100";

		elsif num_in = "100" then
			bcd_out <= "00011100";

		else
			bcd_out <= "00000000";

		end if;
	end process decoder;
                                                        
end bcd_decoder;

