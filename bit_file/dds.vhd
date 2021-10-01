library ieee;
use ieee.std_logic_1164.all;

entity dds is
port ( 
	  shifter_in : in  std_logic_vector(3 downto 0) ; --data from wave
 	  mclk : in std_logic ;--main clock pin
 	  clr : in std_logic ;--main clock pin
 	  sclk : out std_logic ;--main clock pin 
 	  cs : out std_logic ;--main clock pin
 	  data_1 : out std_logic ;--main clock pin	  
	  data_2 : out  std_logic);
end dds ;

architecture Behavioral of dds is
COMPONENT DIV8
PORT(
mclk : IN std_logic;
clr : IN std_logic;
clk : OUT std_logic);
END COMPONENT;
COMPONENT DIV16
PORT(
clk : IN std_logic;
res : IN std_logic;
q : OUT std_logic);
END COMPONENT;
COMPONENT DIV4096
PORT(
clk : IN std_logic;
res : IN std_logic;
q : OUT std_logic);
END COMPONENT;
component debounce is
port ( 
      clk : in  std_logic ;
      D   : in  std_logic ;
      Q   : out  std_logic);
end component;
component shifter is port
(
d : in std_logic_vector(3 downto 0);
clk : in std_logic;
res : in std_logic;
q : out std_logic_vector(3 downto 0));
end component;
COMPONENT phase_accu is 
port ( 
 D : in STD_LOGIC_VECTOR(3 downto 0);
 CE : in STD_LOGIC;
 CLK : in STD_LOGIC;
 RES : in STD_LOGIC;
 Q : out STD_LOGIC_VECTOR(15 downto 0));
end component;
COMPONENT wave_gen
PORT(
         d : IN  std_logic_vector(4 downto 0);
         q : OUT  std_logic_vector(11 downto 0));
END COMPONENT;
COMPONENT dac_interface
PORT(
	  D : in  std_logic_vector(11 downto 0) ; --data from wave
	  ce : in std_logic ;--clock enable pin
    clk : in std_logic ;--main clock pin
	  res : in std_logic ;	  	  
    sclk : out std_logic;
	  cs : out std_logic; --chip select in
	  data_1 : out  std_logic;
	  data_2 : out  std_logic);
END COMPONENT;

signal div8out : std_logic;--clok for entire models
signal div16out : std_logic;--output from div16
signal ms : std_logic;--output of div4096
signal syncout : std_logic;--output from debounce
signal por : std_logic;--reset input for all timing blocks

signal shi2fase : std_logic_vector(3 downto 0);
signal faseout : std_logic_vector(15 downto 0);
signal wavein : std_logic_vector(4 downto 0);
signal wav2dac : std_logic_vector(11 downto 0);--output from wave goes to dac

signal da : std_logic;
signal db : std_logic;

begin
por <= clr;
wavein <= faseout(4 downto 0);
data_1 <= da;
data_2 <= db;

uut_div8: DIV8 PORT MAP (mclk => mclk,clr => por, clk => div8out);
uut_div4096: DIV4096 PORT MAP (clk => div8out,res => por,q => ms);
uut_div16: DIV16 PORT MAP ( clk => div8out, res => por, q => div16out);
  
uut_debounce: debounce port map(clk => div8out, D => clr, Q => syncout);
uut_shifter: shifter port map(D => shifter_in, clk => div8out, res=>syncout, Q => shi2fase);  
uut_accu: phase_accu PORT MAP (d => shi2fase, ce => div16out, clk => div8out, res=> syncout, q => faseout);

uut_wave: wave_gen PORT MAP (d => wavein,q => wav2dac);
uut_dac : dac_interface PORT map(D=>wav2dac, ce =>div16out, clk =>div8out, res=>syncout,
sclk=>sclk, cs =>cs, data_1 => da, data_2 => db);

end Behavioral;