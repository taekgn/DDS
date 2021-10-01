LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Tb_DIV4096 IS
END Tb_DIV4096; 

ARCHITECTURE behavior OF Tb_DIV4096 IS
 
 --€“ Component Declaration for the Unit Under Test (UUT)
 
COMPONENT DIV4096
PORT(
clk : IN std_logic;
res : IN std_logic;
q : OUT std_logic
);
END COMPONENT;
 
--Inputs
signal clk : std_logic := '0';
signal res : std_logic := '0';
 
--Outputs
signal q : std_logic;
 
 --€“ Clock period definitions
constant clk_period : time := 20 ns;
 
BEGIN
 
 -- Instantiate the Unit Under Test (UUT)
uut: DIV4096 PORT MAP (
clk => clk,
res => res,
q => q
);
 
--parallel process threading

clk_process :process
begin
clk <= not clk;
--keep switch 1 and 0
wait for clk_period/2;
end process;
 
res_proc: process
begin
wait for 100 ns;
res <= '1';
--can't use "NOT" because it's going to repeat reseting circuit
wait for 100 ns;
res <= '0';
wait;
end process;

 
END;