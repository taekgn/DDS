LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--use ieee.std_logic_unsigned.all; -- this library is able to remove error at vector addition
USE ieee.numeric_std.all;
--numeric library imported to use unsigned function in for loop

ENTITY tb_phase_accu IS
END tb_phase_accu; 

ARCHITECTURE behavior OF tb_phase_accu IS
 
 --€“ Component Declaration for the Unit Under Test (UUT)
 
COMPONENT phase_accu is 
port ( 
 D : in STD_LOGIC_VECTOR(3 downto 0);
 CE : in STD_LOGIC;
 CLK : in STD_LOGIC;
 RES : in STD_LOGIC;
 Q : out STD_LOGIC_VECTOR(15 downto 0));
end component;
 
--Inputs
signal d_i : std_logic_vector(3 downto 0) := "0000";
signal ce_i : std_logic := '0';
signal clk_i : std_logic := '1';
signal res_i : std_logic := '1';
 
--Outputs
signal q_i : std_logic_vector(15 downto 0);

constant clk_period : time := 20 ns;
 
BEGIN
 
 -- Instantiate the Unit Under Test (UUT)
uut: phase_accu PORT MAP (
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
wait for 10 ns;
res_i <= '1';
wait for 10 ns;
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

loop_pro : process
begin
    d_i <= "0000";--padding empty data to input
for i in 0 to 15 loop
  if i < 15 then
    d_i<= std_logic_vector(to_unsigned(i,d_i'length));
    --assign index i to input through data transform
    wait for clk_period;
    end if;
end loop;
wait for clk_period;
end process;

END;
