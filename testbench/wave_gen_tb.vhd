LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;
--numeric library imported to use unsigned function
ENTITY tb_wave_gen IS
END tb_wave_gen;
 
ARCHITECTURE behavior OF tb_wave_gen IS 
COMPONENT wave_gen
PORT(
         d : IN  std_logic_vector(4 downto 0);
         q : OUT  std_logic_vector(11 downto 0));
END COMPONENT;
--Inputs
signal d : std_logic_vector(4 downto 0) := (others => '0');
--Outputs
signal q : std_logic_vector(11 downto 0);
   
constant clk_period : time := 20 ns;

BEGIN
 -- Instantiate the Lookup Table Implementation
   uut: wave_gen PORT MAP (
          d => d,
          q => q);

d_proc: process
begin
  d <= "00000";
for i in 0 to 31 loop
  if i < 31 then -- because 32 is 6 power to 2, so must be 31
    d<= std_logic_vector(to_unsigned(i,d'length));
    --assign index i to input through data transform
    wait for clk_period;
    end if;
end loop;
wait for clk_period;
end process;

END;