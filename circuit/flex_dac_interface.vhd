library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--numeric library is used for unsigned, integer and natural type data
--so it can allow to use for-while loop as well

entity dac_interface is
Port (  d   : in STD_LOGIC_VECTOR(11 downto 0);
    ce   : in std_logic ;--clock enable pin
    clk  : in STD_LOGIC;
		res  : in STD_LOGIC;--res
    SCLK : out STD_LOGIC;
		cs   : out STD_LOGIC;--cs 
    data_1  : out STD_LOGIC;--data_1,2
		data_2      : out STD_LOGIC);
end dac_interface;
architecture behave of dac_interface is
type thread is (initialize, padding, serial_tx, dormant);--enumerate class declaration
--It contains customized data type using enumerate class
signal handler : thread := dormant;--dormant state is used to set default state
--handler will be a controller for DAC Inteface circuit
signal d_buffer  : STD_LOGIC_VECTOR(15 downto 0)  := (others => '0');--internal shift register of this circuit
--this data buffer vector will be a shift register for DAC
signal cs_buffer  : STD_LOGIC    := '1';--it's a buffer for final CS output
signal Sd_buffer  : STD_LOGIC    := '0';--clcok ce_buffer signal
signal sclkbegin  : STD_LOGIC    := '0';-- it's a signal alerts shifting process initiation

begin
  sync_pro : process(clk) --synchronous parallel process and it controls main process
	variable index : INTEGER := 0;
    begin
	--Sequential Field Declaration
		if falling_edge(clk) then
		  --Data is clocked into the 16-bit shift register on the falling edges of SCLK after the fall of SYNC
		  if ce = '0' then
      handler <= dormant;--deactivate handler
      -- halts the data printing	
			elsif ce = '1' then
			handler <= initialize;
			--starts to shift internal register
			case handler is
				when dormant =>
					Sd_buffer <= '0';
					cs_buffer <= '1';
					--makes all output zero except sclk
				when initialize =>
					cs_buffer <= '0';
					sclkbegin <= '1';
					--it will initiate and enable sclk generation
					Sd_buffer <= '0';
					d_buffer <= (others => '0');
					--padding buffer vector by all zeros
					handler <= padding;
				when padding =>
					index := 0;
					d_buffer <= d & "0000";
					--assigning actual input data and padding 4 bits for empty array
					cs_buffer <= '1';
					handler <= serial_tx;
					--tx state is the process actually prints data
				when serial_tx =>
					index := index + 1;
					if(index > 14) then
						cs_buffer <= '1';
						--becaue when index is 15, actually it prints 16th element
						--since index counted from 0
						--so if-statment should declare respect to 14
					end if;
					if(index < 14) then
						handler <= serial_tx;
						--if it's not reached end then repeats shifting register
					else
						handler <= padding;
					end if;
					d_buffer <= d_buffer(d_buffer'high - 1 downto d_buffer'low) & "0";
					--shift right logic operation
					Sd_buffer <= d_buffer(d_buffer'high);
					--sliced vector assigning to output buffer				
        end case;
			end if; -- ce if statement close
		end if;--clock if statement close
		if rising_edge(clk) then
		--reset signal should be updated when rising edge according to lecture notes
			if res = '1' then
		  index := 0;
		  cs_buffer <= '1';
		  d_buffer <= (others => '0');
		  --by padding zeros into shift register, reset the register
			handler <= dormant;
			end if;--reset close		
		end if;
    end process sync_pro;
	
	--Concurrent Field Declaration
    SCLK <= clk and sclkbegin;
    cs <= not cs_buffer; --cs buffer signal should be fliped
    --because it shows wrong diagram when not statement was not here
    data_1 <= Sd_buffer when ce = '1' else
    '0' when ce = '0';
    data_2 <= Sd_buffer when ce = '1' else
    '0' when ce = '0';
    --Actually, dormant state in handler enumerate class doesn't work
    --So by declaring when else statement for data_1,2 in Concurrent Field
    --It solved issue that keep printing data even though ce = '0'
end behave;