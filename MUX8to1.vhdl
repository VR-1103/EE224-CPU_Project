Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX8to1 is 
  port (A7,A6,A5,A4,A3,A2,A1,A0,S2,S1,S0: in std_logic;Y_out : out std_logic);
  end entity MUX8to1 ;


architecture Struct of MUX8to1 is

 component MUX_2_1  is
  port (S, A, B: in std_logic; Y: out std_logic);
end component MUX_2_1;

component MUX_4_1  is
  port (C1, C0, D3, D2, D1, D0: in std_logic; Y: out std_logic);
end component MUX_4_1;

  signal y_1,y_0 : std_logic;
  
  begin 
   M1 : MUX_4_1 port map (C1 =>S1,C0=>S0,D3=>A7,D2=>A6,D1=>A5,D0=>A4, Y =>y_1 );
	M2 : MUX_4_1 port map (C1 =>S1,C0=>S0,D3=>A3,D2=>A2,D1=>A1,D0=>A0, Y =>y_0 );
	M3 : MUX_2_1 port map ( S => S2, A=> y_1, B => y_0 , Y => Y_out);
	
	

   
 
  
end Struct;