library ieee;
use ieee.std_logic_1164.all;

entity se7 is
	port (A: in std_logic_vector(8 downto 0);
			outp: out std_logic_vector(15 downto 0));
end se7;

architecture bhv of se7 is
begin
	outp <= "0000000"&A;
end bhv;