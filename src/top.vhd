library IEEE;
    use IEEE.STD_LOGIC_1164.all;
    use IEEE.NUMERIC_STD.all;

entity top is
  port (
    -- Тактовый сигнал
	clk       : std_logic;
    -- Кнопки
    KEY0      : in std_logic;  
    KEY1      : in std_logic;   
    -- Светодиод
    LED       : out std_logic
  );
end entity top;

architecture rtl of top is

 -- signal clk_int      : std_logic;
  signal rs           : std_logic;
  signal a  		  : std_logic;
  signal b 			  : std_logic;
  signal cout 		  : std_logic;

begin
 rs <= KEY0 and KEY1;
 
--Одновибратор KEY0
	  one_p0: process(rs, KEY0)
  begin
    if rs = '1' then
	  b	  <= '1';
      sfr0 <= '0';
    elsif rising_edge(KEY0) then
	  b   <= not KEY0;
      sfr0 <= b or KEY0;
    end if;
  end process;

--Одновибратор KEY1
	  one_p1: process(rs, KEY1)
  begin
    if rs = '1' then
	  a	  <= '1';
      sfr1 <= '0';
    elsif rising_edge(KEY1) then
	  a   <= not KEY1;
      sfr1 <= a or KEY1;
    end if;
  end process;
  
-- Счетчи вверх/вниз
  couter0: entity work.up_counter
  port map (
	clk => clk,
	rs => rs,
	load => sfr0,
	data => sfr1,
	cout => cout
	);
	
	----------------------------------------
-- делитель	  
  c_d: entity work.clk_divider 

	generic map( DIVIDER);
    port map(
		rs => rs,
		clk => clk,
		div_clk => div_clk
		);
-- Индикация                                                                  --
  mux: process (KEY0) begin
    if (KEY0= '1') then 
      LED <= std_logic_vector(count100mhz(11 downto 4));
    else
      LED <= std_logic_vector(countpll(11 downto 4));
    end if;
  end process;
end architecture;
