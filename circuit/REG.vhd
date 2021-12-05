library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG is
port ( 
 D : in STD_LOGIC_VECTOR(15 downto 0);
 CE : in STD_LOGIC;
 CLK : in STD_LOGIC; -- this makes to synchronize
 RES : in STD_LOGIC; -- when it's on, removes output data
 Q : out STD_LOGIC_VECTOR(15 downto 0));
end REG;
architecture behavior of REG is
signal q_buffer : std_logic_vector(15 downto 0);--buffer signal
begin 

  PROCESS(CLK) -- input in parenthesis decide prority
    BEGIN
      IF rising_edge(CLK) then
        IF RES = '1' then
        q_buffer <= "0000000000000000"; -- when reset is 1, output becomes zero
        elsif ce = '1' then
        q_buffer <= D; -- this is when data is synchronized.
      else q_buffer <= q_buffer;
        END IF;
      END IF;
    END PROCESS;   
q<=q_buffer;--assign buffer signal into final output
end behavior;
