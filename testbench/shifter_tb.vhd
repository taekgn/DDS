library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;
--numeric library imported to use unsigned function in for loop
entity tb_shifter is
end tb_shifter;

architecture beh of tb_shifter is
component shifter is port
(
d : in std_logic_vector(3 downto 0);
clk : in std_logic;
res : in std_logic;
q : out std_logic_vector(3 downto 0));
end component;

signal d : std_logic_vector(3 downto 0);
signal clk : std_logic:= '1';
signal res : std_logic := '1';
--by setting 1, circuit will be reseted right after execution
signal q : std_logic_vector(3 downto 0);
constant clk_period : time := 20 ns;
begin
s : shifter port map (
d =>d,
clk => clk,
res => res,
q => q);
--parallel process threading
loop_pro : process
begin
    d <= "0000";--padding empty data to input
for i in 0 to 15 loop
  if i < 15 then
    d<= std_logic_vector(to_unsigned(i,d'length));
    --assign index i to input through data transform
    wait for clk_period;
    end if;
end loop;
wait for clk_period;
end process;

clk_process :process
begin
clk <= not clk;
wait for clk_period/2;
end process;

res_pro : process
begin
wait for clk_period;
res <= '0';--off the reset signal
wait for clk_period;
res <= '1';--off the reset signal
wait for clk_period;
end process;

end beh;
