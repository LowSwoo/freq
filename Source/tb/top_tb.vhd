library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture testbench of top_tb is
    signal clk: std_logic := '0';
    signal KEY0, KEY1, LED: std_logic;
    begin
    dut: entity work.top
    port map(
        clk => clk,
        KEY0 => KEY0,
        KEY1 => KEY1,
        LED => LED
    );

    p_clk: process
    begin
        clk <= not clk; wait for 1 ns;
    end process;
    
    k0: process 
    begin
        KEY0 <= '1'; wait for 1 us;
        KEY0 <= '0'; wait for 5 us;

        KEY0 <= '1'; wait for 3 us;
        KEY0 <= '0'; wait for 3 us;
        KEY0 <= '1'; wait for 3 us;
        KEY0 <= '0'; wait for 3 us;
        KEY0 <= '1'; wait for 3 us;
        KEY0 <= '0'; wait for 3 us;
        KEY0 <= '1'; wait for 3 us;
        KEY0 <= '0'; wait for 3 us;


        

    end process;

    k1: process 
    begin
        KEY1 <= '1'; wait for 1 us;
        KEY1 <= '0'; wait for 5 us;

        KEY1 <= '1'; wait for 750 ns;
        KEY1 <= '0'; wait for 750 ns;
        KEY1 <= '1'; wait for 750 ns;
        KEY1 <= '0'; wait for 750 ns;
        KEY1 <= '1'; wait for 750 ns;
        KEY1 <= '0'; wait for 750 ns;
        KEY1 <= '1'; wait for 750 ns;
        KEY1 <= '0'; wait for 750 ns;


    end process;


end testbench;