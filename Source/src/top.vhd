library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity top is
  port (
    -- Тактовый сигнал
    clk : std_logic;
    -- Кнопки
    KEY0 : in std_logic;
    KEY1 : in std_logic;
    -- Светодиод
    LED : out std_logic
  );
end entity top;

architecture rtl of top is

  -- signal clk_int      : std_logic;
  signal rs : std_logic;
  signal uv0_out : std_logic;
  signal uv1_out : std_logic;
  signal div_out : std_logic_vector(31 downto 0);

begin
  rs <= KEY0 and KEY1;
  -- univibrators block
  uv0 : entity work.univibrator
    port map(
      clk => clk,
      rs => rs,
      f => KEY0,
      sfr => uv0_out
    );
  uv1 : entity work.univibrator
    port map(
      clk => clk,
      rs => rs,
      f => KEY1,
      sfr => uv1_out
    );
  -- end univibrators block
  -- Счетчик вверх/вниз
  couter0 : entity work.up_down_counter
    port map(
      clk => clk,
      rs => rs,
      up => uv0_out,
      down => uv1_out,
      cout => div_out
    );
  ---------------------------------------

  -- делитель	  
  clk_divider : entity work.clk_divider
  port map(
    rs => rs,
    clk => clk,
    divider => div_out,
    div_clk => LED
  );
  -- Индикация                                                                  --
  -- mux : process (KEY0) begin
  --   if (KEY0 = '1') then
  --     LED <= std_logic_vector(count100mhz(11 downto 4));
  --   else
  --     LED <= std_logic_vector(countpll(11 downto 4));
  --   end if;
  -- end process;
end architecture;