LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

ENTITY tb_dac_interface IS
END tb_dac_interface;
 
ARCHITECTURE behavior OF tb_dac_interface IS 
    -- Component Declaration for Lookup Table Implementation in VHDL
    COMPONENT dac_interface
    PORT(
	  D : in  std_logic_vector(11 downto 0) ; --data from wave
    ce : in std_logic ;--clock enable pin
    clk : in std_logic ;--main clock pin
	  res : in std_logic ;	  	  
    sclk : out std_logic;
	  cs : out std_logic; --chip select in
	  data_1 : out  std_logic;
	  data_2 : out  std_logic
      );
    END COMPONENT;
   --Inputs
   signal d : std_logic_vector(11 downto 0) := (others => '0');
   signal ce : std_logic := '0';
   signal clk : std_logic:='0';
   signal res : std_logic:='0';
  --Outputs
   signal sclk : std_logic := '0';
   signal cs : std_logic :='0';
   signal data_1 : std_logic:='0';
   signal data_2 : std_logic:='0';
constant clk_period : time := 20 ns;

BEGIN
 -- Instantiate the Lookup Table Implementation
   uut: dac_interface PORT MAP (
      d => d,
      ce=> ce,
		  clk => clk,
		  res => res,
		  sclk => sclk,
		  cs => cs,
		  data_1 => data_1,
		  data_2=>data_2);
		  
clk <= not clk after 20 ns;		  
--parallel process threading
ce_process :process
variable counter : natural range 0 to 18 := 0;
--total cycle is 18, for double CS printing and 16 bits register
begin
wait for 72 ns;
ce<= '1';
wait for 720 ns; --40 times 18 = 720, rising & falling so 40 ns
ce <= '0';
wait for 144 ns;
end process;
 
res_proc: process
begin
wait for 20 ns;
res <= '1';
wait for 20 ns;
res <= '0';
wait for 700 ns;
res <= '1';
wait for 40 ns;
end process;

d_proc: process
begin
d <= "000000000000";
for i in 1833 to 2047 loop
  if i < 2047 then -- because 2048 is 12 power to 2, so must be 2047
    d<= std_logic_vector(to_unsigned(i,d'length));
    --assign index i to input through data transform
    wait for clk_period*3;
    end if;
end loop;
wait for clk_period;
end process;

END;