library ieee;
use ieee.std_logic_1164.all;

entity debounce is
port ( 
      clk : in  std_logic ;
	  D : in  std_logic ; 
      Q : out  std_logic
      );
end debounce ;

architecture Behavioral of debounce is
component FF
port ( 
      clk : in  std_logic ;
	  D : in  std_logic ; 
      Q : out  std_logic
      );
end component ;
signal z : std_logic;-- it connects ff1 and ff2
begin
  --creates flip flop objects
  ff1: FF port map (clk=>clk ,d=>d, q=>z);
  ff2: FF port map (clk=>clk ,d=>z, q=>q);
end Behavioral;