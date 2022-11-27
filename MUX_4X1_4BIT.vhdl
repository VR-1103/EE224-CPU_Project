Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_4X1_4BIT is 
  port (D33,D32,D31,D30,D23,D22,D21,D20,D13,D12,D11,D10,D03,D02,D01,D00,C00,C11: in std_logic;Y3,Y2, Y1 ,Y0 : out std_logic);
  end entity MUX_4X1_4BIT ;


architecture Struct of MUX_4X1_4BIT is

component MUX_4_1  is
  port (C1, C0, D3, D2, D1, D0: in std_logic; Y: out std_logic);
end component MUX_4_1;

  --signal y_1,y_0 : std_logic;
  
  begin 
   M1 : MUX_4_1 port map (C1=>C11,C0=>C00,D3=>D33,D2=>D32 ,D1=>D31, D0=>D30,Y =>Y3);
	M2 : MUX_4_1 port map (C1=>C11,C0=>C00,D3=>D23,D2=>D22 ,D1=>D21, D0=>D20,Y =>Y2);
	M3 : MUX_4_1 port map (C1=>C11,C0=>C00,D3=>D13,D2=>D12 ,D1=>D11, D0=>D10,Y =>Y1);
	M4 : MUX_4_1 port map (C1=>C11,C0=>C00,D3=>D03,D2=>D02 ,D1=>D01, D0=>D00,Y =>Y0);
	

   
 
  
end Struct;