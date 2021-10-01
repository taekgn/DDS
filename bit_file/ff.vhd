library ieee;
use ieee.std_logic_1164.all;

entity FF is
port ( 
      clk : in  std_logic ;
	  D : in  std_logic ; 
      Q : out  std_logic);
end FF ;

architecture Behavioral of FF is
begin
  process (clk)--synchronous flipflop
    begin
	  if rising_edge(clk) then
	  Q <=D;--synchronous output update
      end if;
    end process ;
end Behavioral;