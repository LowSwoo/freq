--------------------------------------------------------------------------------
-- TITLE: Generic divider
-- AUTHOR: Serge Nikolaevich Koyankin (koyankin@yandex.ru)
-- DATE CREATED: 2016-09-06
-- Updated: 2018-06-04
-- FILENAME: divider.vhdl
-- PROJECT: single architecture
-- COPYRIGHT: Software placed into TAPR Open Hardware License
--  (http://www.tapr.org/OHL) by the author.
--  Software 'as is' without warranty. Author liable for nothing.
-- DESCRIPTION:
--  ...
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity clk_divider is
  port (
    rs      : in std_logic;
    clk     : in std_logic;
    divider : in std_logic_vector(31 downto 0);
    div_clk : out std_logic);
end clk_divider;

architecture rtl of clk_divider is

  signal counter  : unsigned(31 downto 0);

begin

  clk_maker : process (rs, clk)
  begin
    if rs = '1' then
      counter <= (others => '0');
    elsif rising_edge(clk) then
      if counter = unsigned(divider)-1 then
        counter <= (others => '0');
      else
        counter <= counter + 1;
      end if;

      if counter >= to_integer(unsigned(divider)/2) then
        div_clk <= '1';
      else
        div_clk <= '0';
      end if;
    end if;
  end process;

end rtl;
