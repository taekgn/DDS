library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
  
entity DIV8 is
port ( mclk,clr: in std_logic;
clk: out std_logic);
end DIV8;
  
architecture bhv of DIV8 is
signal tmp : std_logic := '0' ; -- The signal will be one at Power-on Reset 
signal count : integer := 0 ; -- The counter will be reset at Power-on Reset
--tmp is temporary space to store a bit datum
  
begin
  process(mclk,clr)--asynchronous so clr and mclk both are on sensitivity
  begin
	  if(clr='1') then
		  tmp<='0';
		  count<=0;
	  elsif rising_edge(mclk) then 
		count <=count+1;
	  if count = 7 then --because it counts from 0, so 1 should be subtracted from 8
		  count <= 0;--reseting count number
		  tmp <= not tmp;--makes true when reached 8th cycles
	  end if;
  end if;
  clk <= tmp;--assigns temporary datum into output
end process;
end bhv;


