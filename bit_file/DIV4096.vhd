library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity DIV4096 is
port ( clk,res: in std_logic;
q: out std_logic);
end DIV4096;
  
architecture bhv of DIV4096 is
signal clk_i : std_logic := '0' ; -- The signal will be one at Power-on Reset 
signal count : integer := 0 ; -- The counter will be reset at Power-on Reset
  
begin
  process(clk) --synchronous so only clk is on sensitivity
  begin
	  if rising_edge(clk) then
		count <=count+1;
	  if count = 4095 then --because it counts from 0, so 1 should be subtracted from 4096
	    clk_i<= not clk_i;
		  count <= 0;--reseting count number
		elsif(res='1') then
		  count<= 0;
		  clk_i<='0';
	  end if;
  end if;
  q <= clk_i;
end process;
end bhv;