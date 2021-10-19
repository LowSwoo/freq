library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity up_down_counter is
    port (
        clk : in std_logic;
        rs : in std_logic; -- 0 - normal | 1 - reset
        up : in std_logic;
        down : in std_logic;
        cout : out std_logic_vector(31 downto 0)
    );
end entity up_down_counter;

architecture rtl of up_down_counter is
    signal count : unsigned(31 downto 0) := x"00000032"; -- модуль счета по умолчанию 50 000 000 
begin
    p1 : process (clk, rs, up, down) begin
        if (rs = '1') then
            count <= x"00000032";
        else
            if rising_edge(clk) then
                if (up = '1') then
                    count <= count + 10;
                end if;
                if (down = '1') then
                    count <= count - 10;
                end if;
            end if;
        end if;
    end process;
    cout <= std_logic_vector(count);
end architecture;