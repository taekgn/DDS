library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity wave_gen is
port ( 
 D : in STD_LOGIC_VECTOR(4 downto 0);--2 power 5 which is 32
 Q : out STD_LOGIC_VECTOR(11 downto 0)); -- 2 power of 12 which is 
end wave_gen;
architecture behavior of wave_gen is
--Inorder to create lookup array, MATLAB was used
begin
  q<=   "000001011100" when d = "00000" else --92:0
		"000001101000" when d ="00001" else --104:1
		"000001110000" when d ="00010" else --112:2
		"000001110100" when d ="00011" else --116:3
		"000001110011" when d ="00100" else --115:4
		"000001101011" when d ="00101" else --107:5
		"000001011111" when d ="00111" else --95:6
		"000001001110" when d ="01000" else --78:7
		"000000111100" when d ="01001" else--60:8
		"000000101010" when d ="01010" else--42:9
		"000000011001" when d ="01100" else--25:10
		"000000001101" when d ="01101" else--13:11
		"000000000101" when d ="01110" else--5:12
		"000000000100" when d ="01111" else--4:13
		"000000001000" when d ="10001" else--8:14
		"000000010000" when d ="10010" else--16:15
		"000000011100" when d ="10011" else--28:16
		"000000101001" when d ="10100" else--41:17
		"000000110101" when d ="10101" else--53:18
		"000000111111" when d ="10110" else--63:19
		"000001000101" when d ="10111" else--69:20
		"000001001000" when d ="11000" else--72:21
		"000001000110" when d ="11001" else--70:22
		"000001000010" when d ="11010" else--66:23
		"000000111100" when d ="11011" else--60:24
		"000000110110" when d ="11010" else--54:25
		"000000110010" when d ="11011" else--50:26
		"000000110000" when d ="11110" else--48:27
		"000000110011" when d ="11100" else--51:28
		"000000111001" when d ="11101" else--57:29
		"000001000011" when d ="11110" else--67:30
		"000001001111" when d ="11111";--79:31		
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