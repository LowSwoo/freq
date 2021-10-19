library ieee;
use ieee.std_logic_1164.all;

entity univibrator is
  port(
    clk : in std_logic;   -- Тактовая частота
    rs  : in std_logic;   -- Сброс
    f   : in std_logic;   -- Асинхронный входной сигнал
    sfr : out std_logic  -- Импульс по фронту входного сигнала
  );
end entity univibrator;

architecture struct of univibrator is

  signal a : std_logic;

begin

  one_p: process(rs, clk)
  begin
    if rs = '1' then
      a   <= '1';
      sfr <= '0';
    elsif rising_edge(clk) then
      a   <= not f;
      sfr <= f and a;
    end if;
  end process;

end architecture struct;