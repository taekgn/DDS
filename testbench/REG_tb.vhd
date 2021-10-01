LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all; -- this library is able to remove error at vector addition
use ieee.numeric_std.all;

ENTITY tb_REG IS
END tb_REG; 

ARCHITECTURE behavior OF tb_REG IS
 
 --€“ Component Declaration for the Unit Under Test (UUT)
 
COMPONENT REG is 
port ( 
 D : in STD_LOGIC_VECTOR(15 downto 0);
 CE : in STD_LOGIC;
 CLK : in STD_LOGIC; -- this makes to synchronize
 RES : in STD_LOGIC; -- when it's on, removes output data
 Q : out STD_LOGIC_VECTOR(15 downto 0));
end component;
 
--Inputs
signal d_i : std_logic_vector(15 downto 0) := "0000000000000000";
signal ce_i : std_logic := '0';
signal clk_i : std_logic := '1';
signal res_i : std_logic := '1';
 
--Outputs
signal q_i : std_logic_vector(15 downto 0);

constant clk_period : time := 20 ns;
 
BEGIN
 
 -- Instantiate the Unit Under Test (UUT)
uut: REG PORT MAP (
d => d_i,
ce => ce_i,
clk => clk_i,
res=> res_i,
q => q_i);
 
--parallel process threading

clk_process :process
begin
clk_i <= not clk_i;
wait for clk_period/2;
end process;
 
res_proc: process
begin
wait for 100 ns;
res_i <= '1';
wait for 100 ns;
res_i <= '0';
wait;
end process;

ce_proc: process
begin
wait for clk_period;
ce_i <= '1';
wait for 2*clk_period;
ce_i <= '0';
wait for clk_period;
ce_i <= '1';
wait for 2*clk_period;
ce_i <= '0';
end process;

d_proc: process
begin
d_i <= "0000000000000000";
for i in 24577 to 32767 loop
  if i < 32767 then -- because 32768 is 16 power to 2, so must be 32768
    d_i<= std_logic_vector(to_unsigned(i,d_i'length));
    --assign index i to input through data transform
    wait for clk_period*3;
    end if;
end loop;
wait for clk_period;
end process;

END;