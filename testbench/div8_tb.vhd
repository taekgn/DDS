LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Tb_DIV8 IS
END Tb_DIV8;
 
ARCHITECTURE behavior OF Tb_DIV8 IS
 
 --€“ Component Declaration for the Unit Under Test (UUT)
 
COMPONENT DIV8
PORT(
mclk : IN std_logic;
clr : IN std_logic;
clk : OUT std_logic
);
END COMPONENT;
 
--Inputs
signal mclk : std_logic := '0';
signal clr : std_logic := '0';
 
--Outputs
signal clk : std_logic;
 
 --€“ Clock period definitions
constant clk_period : time := 20 ns;
 
BEGIN
 
 -- Instantiate the Unit Under Test (UUT)
uut: DIV8 PORT MAP (
mclk => mclk,
clr => clr,
clk => clk
);

--parallel process threading
clk_process :process
begin
mclk <= not mclk;
--keep switch 1 and 0
wait for clk_period/2;
end process;
 
clr_proc: process
begin
wait for 100 ns;
clr <= '1';
--can't use "NOT" because it's going to repeat clearing circuit
wait for 100 ns;
clr <= '0';
wait;
end process;

 
END;
