library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_debounce is
end tb_debounce ;

architecture Behavioral of tb_debounce is

-- Declare the component.
component debounce is
    port ( 
      clk : in  std_logic ;
      D   : in  std_logic ;
      Q   : out  std_logic
      );
end component;

-- Declare internal signals to match each signal in component
signal clk : std_logic := '0' ; -- Preset clock to 0
signal D : std_logic ;
signal Q : std_logic ;

begin

U_debounce: debounce port map(
    clk => clk,  
    D => D,
    Q => Q
  ) ;

clk <= not clk after 20 ns;
process
  begin
  D <= '1' ;
  wait for 30 ns ;
  D <=  not d ;
  wait for 10 ns ;
  -- Jitter invoked while instant time
  D <= '1' ;
  wait for 5 ns ;
  D <= '0' ;
  wait for 1 ns ;
  D <= '1' ;
  wait for 10 ns ;
  D <= '0' ;
  wait for 40 ns ;
end process ;

end Behavioral;


