library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
-- this library is able to vector addition although their length are different

entity phase_accu is
port ( 
 D : in STD_LOGIC_VECTOR(3 downto 0);
 CE : in STD_LOGIC;
 CLK : in STD_LOGIC;
 RES : in STD_LOGIC;
 Q : out STD_LOGIC_VECTOR(15 downto 0));
end phase_accu;
architecture behavior of phase_accu is
component REG port(
  D :  in std_logic_vector(15 downto 0);
  CE : in std_logic;
  CLK : in std_logic;
  RES : in std_logic;
  Q : out std_logic_vector(15 downto 0));
end component;

signal regin : std_logic_vector(15 downto 0); -- output from ADD and input will go to REG
signal feed : std_logic_vector(15 downto 0);--feedback wire goes back to ADD
signal realoutput : std_logic_vector(15 downto 0):=(others => '0'); -- final and real output which will be assigned to Q in Entity Class

begin
  Q<= realoutput;
  regin <= feed + d; -- feedback connection whic h goes back to REG input
  preg : REG PORT MAP(D=>regin, CE=>CE, CLK=>CLK, RES=>RES, Q=>feed);
  process(clk)
    begin
  if rising_edge(clk) then
    if ce = '1' then
      realoutput<= feed;-- Assigning datum from REG
  elsif res = '1' then
     realoutput<= "0000000000000000";-- Initialize the output when reset is pressed
    end if;
  end if;
  end process;
  
end behavior;