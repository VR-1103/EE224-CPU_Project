Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_1X2_4BIT is 
  port (A3,A2,A1,A0,B3,B2,B1,B0,Sig_4BIT: in std_logic;Y3,Y2, Y1 ,Y0 : out std_logic);
  end entity MUX_1X2_4BIT ;


architecture Struct of MUX_1X2_4BIT is

 component MUX_2_1  is
  port (S, A, B: in std_logic; Y: out std_logic);
end component MUX_2_1;

  --signal y_1,y_0 : std_logic;
  
  begin 
   M1 : MUX_2_1 port map ( S => Sig_4BIT, A=> A3, B => B3 , Y => Y3);
	M2 : MUX_2_1 port map ( S => Sig_4BIT, A=> A2, B => B2 , Y => Y2);
	M3 : MUX_2_1 port map ( S => Sig_4BIT, A=> A1, B => B1 , Y => Y1);
	M4 : MUX_2_1 port map ( S => Sig_4BIT, A=> A0, B => B0 , Y => Y0);
	

   
 
  
end Struct;