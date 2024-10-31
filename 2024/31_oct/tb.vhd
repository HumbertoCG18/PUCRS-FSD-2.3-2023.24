tb.vhd
library ieee;
use ieee.std_logic_1164.all;

entity tb is
end entity;

architecture tb of tb is 
  signal sgnClk, sgnRst, sgnCe, sgnLd: std_logic;
  signal sgnDataBus, sgnCount: std_logic_vector(7 downto 0);
begin

  process
  begin
    sgnClk <= '0', '1' after 5ns;
    wait for 10ns;
  end process;
  
  sgnRst <= '1', '0' after 2ns;
  
  sgnCe <= '1', '0' after 52ns, '1' after 102ns;
  
  sgnDataBus <= x"07";
  
  sgnLd <= '0', '1' after 203ns, '0' after 263ns;
  

DUT : entity work.contador port map (
			clk => sgnClk, rst => sgnRst, ce  => sgnCe, ld  => sgnLd,
			databus => sgnDatabus, count => sgnCount
	  );

end architecture;

