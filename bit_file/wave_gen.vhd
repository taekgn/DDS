library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity wave_gen is
port ( 
 D : in STD_LOGIC_VECTOR(4 downto 0);--2 power 5 which is 32
 Q : out STD_LOGIC_VECTOR(11 downto 0)); -- 2 power of 12 which is 
end wave_gen;
architecture behavior of wave_gen is
type t_lu_table is array(0 to 31) of integer range 0 to 128;
--created user cutomized data type
constant lu_table  : t_lu_table := (
92, 104, 112, 116, 115, 107, 95, 78, 60, 42, 25, 13, 5, 4, 8, 16, 28, 41, 53,
63, 69, 72, 70, 66, 60, 54, 50, 48, 51, 57, 67, 79
);
--this is a arraylist for lookup table
--Inorder to create lookup array, MATLAB was used
begin
  q<= std_logic_vector(to_unsigned(lu_table(to_integer(unsigned(d))),12));
  --integer from arraylist is reconverted into vector with length of 12
end behavior;

--Belows are MATALB code

--function lookup
--np=32; %sampling rate
--A=32; %Amplitude
--t=linspace(0,1-1/np,np); %Interval
--lu_table = (round(sin(2*pi*t*2)*A+cos(2*pi*t)*A)+60);
--%creates trigonometry lookup table
--%60 added to convert everything into positive number
--plot(lu_table) %plots diagram to compare visually
--end