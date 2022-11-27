Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_4x1_16BIT is 
  port (D3,D2,D1,D0 : in std_logic_vector(15 downto 0);C_1,C_0: in std_logic; Y : out std_logic_vector(15 downto 0));
  end entity MUX_4x1_16BIT ;


architecture Struct of MUX_4x1_16BIT is

component MUX_4X1_4BIT is 
  port (D33,D32,D31,D30,D23,D22,D21,D20,D13,D12,D11,D10,D03,D02,D01,D00,C00,C11: in std_logic;Y3,Y2, Y1 ,Y0 : out std_logic);
  end component MUX_4X1_4BIT ;


  --signal y_1,y_0 : std_logic;
  
  begin 
   M1 : MUX_4X1_4BIT port map (D33=>D3(15),D32=>D2(15),D31=>D1(15),D30=>D0(15),
			       D23=>D3(14),D22=>D2(14),D21=>D1(14),D20=>D0(14),
			       D13=>D3(13),D12=>D2(13),D11=>D1(13),D10=>D0(13),
			       D03=>D3(12),D02=>D2(12),D01=>D1(12),D00=>D0(12),
			       C00=>C_0,C11=>C_1,Y3=>Y(15),Y2=>Y(14),Y1=>Y(13),Y0=>Y(12));
	
   M2 : MUX_4X1_4BIT port map (D33=>D3(11),D32=>D2(11),D31=>D1(11),D30=>D0(11),
			       D23=>D3(10),D22=>D2(10),D21=>D1(10),D20=>D0(10),
			       D13=>D3(9),D12=>D2(9),D11=>D1(9),D10=>D0(9),
		               D03=>D3(8),D02=>D2(8),D01=>D1(8),D00=>D0(8),
			       C00=>C_0,C11=>C_1,Y3=>Y(11),Y2=>Y(10),Y1=>Y(9),Y0=>Y(8));
	  
  M3 : MUX_4X1_4BIT port map (D33=>D3(7),D32=>D2(7),D31=>D1(7),D30=>D0(7),
			      D23=>D3(6),D22=>D2(6),D21=>D1(6),D20=>D0(6),
			      D13=>D3(5),D12=>D2(5),D11=>D1(5),D10=>D0(5),
			      D03=>D3(4),D02=>D2(4),D01=>D1(4),D00=>D0(4),
			      C00=>C_0,C11=>C_1,Y3=>Y(7),Y2=>Y(6),Y1=>Y(5),Y0=>Y(4));
	
  M4 : MUX_4X1_4BIT port map (D33=>D3(3),D32=>D2(3),D31=>D1(3),D30=>D0(3),
			      D23=>D3(2),D22=>D2(2),D21=>D1(2),D20=>D0(2),
			      D13=>D3(1),D12=>D2(1),D11=>D1(1),D10=>D0(1),
			      D03=>D3(0),D02=>D2(0),D01=>D1(0),D00=>D0(0),
			      C00=>C_0,C11=>C_1,Y3=>Y(3),Y2=>Y(2),Y1=>Y(1),Y0=>Y(0));
	
   
 
  
end Struct;