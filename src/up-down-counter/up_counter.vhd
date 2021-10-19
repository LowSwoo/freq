library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity up_down_counter is
    port (
        clk  : in std_logic;
        rs   : in std_logic; -- 0 - normal | 1 - reset
        dir : in std_logic; -- 0 - up | 1 - down
		data : in std_logic;
        cout : out std_logic_vector(31 downto 0)
    );
end entity up_down_counter;

architecture rtl of up_down_counter is
    signal count : unsigned(31 downto 0):=x"50000000"; -- модуль счета по умолчанию 50 000 000 
begin
    p1 : process (clk, rs, dir) begin
        if (rs = '1') then
            count <= (others => '0');
        else
            if rising_edge(clk) then
                if (data = '1') then
                    count <= count + 1000000;
                else
					if  (dir = '1') then
                    count <= count - 1000000;
					end if;
                end if;
            end if;
        end if;
    end process;
    cout <= std_logic_vector(count);
end architecture;