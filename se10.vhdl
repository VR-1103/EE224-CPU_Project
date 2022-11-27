library ieee;
use ieee.std_logic_1164.all;

entity se10 is
	--This component increases the size of a vector to a 16 bit vector, keeping the value of the vector same
	port (A: in std_logic_vector(5 downto 0);
			outp: out std_logic_vector(15 downto 0));
end se10;

architecture bhv of se10 is
begin
	outp <= "0000000000"&A; --concatenation being used
end bhv;
