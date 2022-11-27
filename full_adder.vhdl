library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity full_adder is
  port (A,B,C : in std_logic; S,Cout : out std_logic);
end entity full_adder;

architecture Struct of full_adder is
  signal P,Q,R : std_logic;
  begin
    HA1 : HALF_ADDER port map(A=>A,B=>B,S=>P,C=>Q);
	 HA2 : HALF_ADDER port map(A=>C,B=>P,S=>S,C=>R);
	 OR1 : OR_2 port map(A=>R,B=>Q,Y=>Cout);
end Struct;