library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity adder_16bit is
	--This component adds 16 bit inputs A and B
	port(A,B: in std_logic_vector(15 downto 0);
		  S: out std_logic_vector(15 downto 0);
		  C: out std_logic);
end entity adder_16bit;

architecture struct of adder_16bit is
	component full_adder is
		port (A,B,C : in std_logic; S,Cout : out std_logic);
	end component;
	
	signal carry: std_logic_vector(15 downto 0);
	
begin
	--Using the carry generated in the ith adder, the Sum of i+1 is calculated
	fa0: full_adder port map(A=>A(0),B=>B(0),C=>'0',S=>S(0),Cout=>carry(0));
	fa1: full_adder port map(A=>A(1),B=>B(1),C=>carry(0),S=>S(1),Cout=>carry(1));
	fa2: full_adder port map(A=>A(2),B=>B(2),C=>carry(1),S=>S(2),Cout=>carry(2));
	fa3: full_adder port map(A=>A(3),B=>B(3),C=>carry(2),S=>S(3),Cout=>carry(3));
	fa4: full_adder port map(A=>A(4),B=>B(4),C=>carry(3),S=>S(4),Cout=>carry(4));
	fa5: full_adder port map(A=>A(5),B=>B(5),C=>carry(4),S=>S(5),Cout=>carry(5));
	fa6: full_adder port map(A=>A(6),B=>B(6),C=>carry(5),S=>S(6),Cout=>carry(6));
	fa7: full_adder port map(A=>A(7),B=>B(7),C=>carry(6),S=>S(7),Cout=>carry(7));
	fa8: full_adder port map(A=>A(8),B=>B(8),C=>carry(7),S=>S(8),Cout=>carry(8));
	fa9: full_adder port map(A=>A(9),B=>B(9),C=>carry(8),S=>S(9),Cout=>carry(9));
	fa10: full_adder port map(A=>A(10),B=>B(10),C=>carry(9),S=>S(10),Cout=>carry(10));
	fa11: full_adder port map(A=>A(11),B=>B(11),C=>carry(10),S=>S(11),Cout=>carry(11));
	fa12: full_adder port map(A=>A(12),B=>B(12),C=>carry(11),S=>S(12),Cout=>carry(12));
	fa13: full_adder port map(A=>A(13),B=>B(13),C=>carry(12),S=>S(13),Cout=>carry(13));
	fa14: full_adder port map(A=>A(14),B=>B(14),C=>carry(13),S=>S(14),Cout=>carry(14));
	fa15: full_adder port map(A=>A(15),B=>B(15),C=>carry(14),S=>S(15),Cout=>carry(15));
   C<=carry(15);
end struct;
	
