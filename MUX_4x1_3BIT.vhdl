Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_4x1_3BIT is 
	port(A,B,C,D: in std_logic_vector(2 downto 0);S1,S0: in std_logic; Y: out std_logic_vector(2 downto 0));
end entity MUX_4x1_3BIT;

architecture struct of MUX_4x1_3BIT is
	component MUX_4_1  is
	  port (C1, C0, D3, D2, D1, D0: in std_logic; Y: out std_logic);
	end component;
	
begin
	M1 : MUX_4_1 port map (S1,S0,A(2),B(2),C(2),D(2),Y(2));
	M2 : MUX_4_1 port map (S1,S0,A(1),B(1),C(1),D(1),Y(1));
	M3 : MUX_4_1 port map (S1,S0,A(0),B(0),C(0),D(0),Y(0));
end struct;