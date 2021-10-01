library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter is port
(
d : in std_logic_vector(3 downto 0);
clk : in std_logic;
res : in std_logic;
q : out std_logic_vector(3 downto 0));
end entity;

architecture beh of shifter is
component ffsr
port ( 
      d : in std_logic;    
      clk :in std_logic;  
	  res: in std_logic;  
      q : out  std_logic);
end component ;
begin
  latch1 : ffsr port map (d=>d(0), clk=>clk ,res=>res, q=>q(0));
  latch2 : ffsr port map (d=>d(1), clk=>clk ,res=>res, q=>q(1));
  latch3 : ffsr port map (d=>d(2), clk=>clk ,res=>res, q=>q(2));
  latch4 : ffsr port map (d=>d(3), clk=>clk ,res=>res, q=>q(3));
end beh;