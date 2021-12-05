----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:34:59 02/11/2021 
-- Design Name: 
-- Module Name:    DIV16 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
  
entity DIV16 is
port ( clk,res: in std_logic;
q: out std_logic);
end DIV16;
  
architecture bhv of DIV16 is
signal clk_i : std_logic := '0' ; -- The signal will be one at Power-on Reset 
signal count : integer := 0 ; -- The counter will be reset at Power-on Reset
  
begin
  process(clk) --synchronous so only clk is on sensitivity
  begin
	  if rising_edge(clk) then
		count <=count+1;
	  if count = 15 then --because it counts from 0, so 1 should be subtracted from 16
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

