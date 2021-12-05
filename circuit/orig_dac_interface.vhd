library ieee;
use ieee.std_logic_1164.all;

entity dac_interface is
port ( 
	  d : in  std_logic_vector(11 downto 0) ; --data from wave generator
 	  ce : in std_logic ;--clock enable pin
 	  clk : in std_logic ;--main clock pin
	  res : in std_logic ;-- synchronus reset	  	  
 	  sclk : out std_logic; --serial clock
	  cs : out std_logic; --chip select in
	  data_1 : out  std_logic;-- data which is going to channel A of PmodDA2
	  data_2 : out  std_logic -- data which is going channel B of PmodDA2
); end dac_interface ;

architecture Behavioral of dac_interface is
signal reg : std_logic_vector(15 downto 0); -- input shift register
signal datum : std_logic    := '0'; --a temporary bit for each element in register vector
begin
  process(clk)
  variable counter : natural range 0 to 17 := 0;--index variable to slice vector
  --total cycle is 18, for double CS printing and 16 bits register
  begin
  if rising_edge(clk) then	
  counter := counter + 1; 
	 if res = '1' then --synchronous reset declaration
	 datum <='0';
	 cs <= '0';
	 reg <= (others=>'0');
	 elsif ce = '1' then
	     if counter = 1 then
	       reg <= d & "ZZ"&"0U";-- padding datums into shift register
	       --Z stands for high impedance, U stands for unknown
	       --it added because they can be easily seen on timing diagram
	       --by checking their color, could know whether it's MSB or LSB
	       --If blue line comes out then, it means MSB
	       datum <= reg(counter-1);--taking each array value to match with index
	       cs <= '1';
	     elsif counter = 2 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 3 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 4 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 5 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 6 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 7 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 8 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 9 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 10 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 11 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 12 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 13 then
	         cs <= '0';
  	         datum <= reg(counter-1);
	     elsif counter = 14 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 15 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 16 then
	         cs <= '0';
	         datum <= reg(counter-1);
	     elsif counter = 17 then
	         cs <= '1';
	         datum <= 'U';--painting into red to mark it as LSB
	         counter := 0;
	      else datum <= 'U';
	     end if; 
	  end if;    
	end if;
  if falling_edge(clk) then	
	 if ce = '1' then
	     if counter = 1 then
	       cs <= '1';
	     elsif counter = 2 then
	         cs <= '0';
	     elsif counter = 3 then
	         cs <= '0';
	     elsif counter = 4 then
	         cs <= '0';
	     elsif counter = 5 then
	         cs <= '0';
	     elsif counter = 6 then
	         cs <= '0';
	     elsif counter = 7 then
	         cs <= '0';
	     elsif counter = 8 then
	         cs <= '0';
	     elsif counter = 9 then
	         cs <= '0';
	     elsif counter = 10 then
	         cs <= '0';
	     elsif counter = 11 then
	         cs <= '0';
	     elsif counter = 12 then
	         cs <= '0';
	     elsif counter = 13 then
	         cs <= '0';
	     elsif counter = 14 then
	         cs <= '0';
	     elsif counter = 15 then
	         cs <= '0';
	     elsif counter = 16 then
	         cs <= '0';
	     elsif counter = 17 then
	         cs <= '1';
	     end if; 
	  end if;    
	end if; 	
end process;
sclk <= clk and ce;-- serial clock  
data_1 <= datum; data_2 <= datum;
end Behavioral;