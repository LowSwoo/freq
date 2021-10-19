library ieee;
use ieee.std_logic_1164.all;

entity univibrator is
  port(
    key0 : in std_logic;   -- входной сигнал
    rs   : in std_logic;   -- Сброс
    sfr : out std_logic  -- Импульс по фронту входного сигнала
--    sff : out std_logic   -- Импульс по срезу входного сигнала
  );
end entity univibrator;

architecture struct of univibrator is

  signal a : std_logic;
  signal b : std_logic;

begin

  one_p: process(rs, key0)
  begin
    if rs = '1' then
      a   <= '1';
	  b	  <= '1';
      sfr <= '0';
--      sff <= '0';
    elsif rising_edge(key0) then
	  b   <= not key0;
      --a   <= key0 nor b;
      sfr <= b or key0;
--      sff <= f nor a;
    end if;
  end process;
end architecture struct;
