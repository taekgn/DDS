LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;-- to use for loop


ENTITY tb_dds IS
END tb_dds;
 
ARCHITECTURE behavior OF tb_dds IS 
    -- Component Declaration for Lookup Table Implementation in VHDL
component dds
port ( 
	  shifter_in : in  std_logic_vector(3 downto 0) ; --data from wave
 	  mclk : in std_logic ;--main clock pin
 	  clr : in std_logic ;--main clock pin
 	  sclk : out std_logic ;--main clock pin 
 	  cs : out std_logic ;--main clock pin
 	  data_1 : out std_logic ;--main clock pin	  
	  data_2 : out  std_logic
      );
end component ;
--Inputs
signal shifter_in : std_logic_vector(3 downto 0) ; --data from wave
signal mclk : std_logic := '0' ;--main clock pin
signal clr : std_logic := '1';--main clock pin
--Outputs
signal sclk : std_logic ;--main clock pin 
signal cs : std_logic ;--main clock pin
signal data_1 : std_logic ;--main clock pin	  
signal data_2 : std_logic;
   
constant clk_period : time := 20 ns;

BEGIN
 -- Instantiate the Lookup Table Implementation
   uut: dds PORT MAP (
	shifter_in =>shifter_in,
    mclk=>mclk,
    clr=>clr,
    sclk=> sclk,
    cs => cs,
    data_1 => data_1,
	data_2 => data_2);

d_proc: process
begin
  shifter_in <= "0101";
for i in 0 to 31 loop
  if i < 31 then
    shifter_in<= std_logic_vector(to_unsigned(i,shifter_in'length));
    wait for clk_period;
    end if;
end loop;
wait for clk_period;
end process;

res_pro : process
begin
wait for clk_period;
clr <='0';
end process;

clk_pro : process
begin
wait for clk_period/2;
mclk <= not mclk;
end process;

END;