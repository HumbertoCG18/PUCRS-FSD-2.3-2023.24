library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contador is
  port(
    clk, rst, ce, ld: in std_logic;
    databus: in std_logic_vector(7 downto 0);
    count : out std_logic_vector(7 downto 0)
  );
end entity;

architecture comportamento of contador is
  signal sgnCount:std_logic_vector(7 downto 0);
begin

  process(clk, rst)
  begin
    if(rst='1')then
      sgnCount <= (others=>'0');
    elsif(rising_edge(clk))then
      if(ce='1')then
        if(ld='1')then
          sgnCount<=dataBus;
        else
          sgnCount<=sgnCount+1;
        end if;
      end if;
    end if;
  end process;

  count <= sgnCount;

end architecture;
