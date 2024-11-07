library ieee;
use ieee.std_logic_1164.all;

entity TB is;
end entity;

architecture TB of TB is 
    signal sgnClk, sgnRst, sgnDin, sgnDout;
begin

    sgnRst <= '1', '0' after 3 ns;

    process 
    begin
        sgnClk <= '0', '1' after 10 ns;
        wait for 30 ns;
    end process;

    sgnDin <= '1', '0' after 40 ns, '1' after 70 ns, '0' after 190 ns, '1' after 220 ns;

    DUV: entity work.detector port map (clk => sgnClk, rst=> sgnRst, din=> sgnDin, dout=> sgnDout);

end architecture;
