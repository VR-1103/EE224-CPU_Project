Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_8X1_4BIT is 
  port (A37,A36,A35,A34,A33,A32,A31,A30,
        A27,A26,A25,A24,A23,A22,A21,A20,
		  A17,A16,A15,A14,A13,A12,A11,A10,
		  A07,A06,A05,A04,A03,A02,A01,A00,
       S2,S1,S0: in std_logic;Y_out3,Y_out2,Y_out1,Y_out0 : out std_logic);
  end entity MUX_8X1_4BIT ;


architecture Struct of MUX_8X1_4BIT is

 component MUX8to1 is 
  port (A7,A6,A5,A4,A3,A2,A1,A0,S2,S1,S0: in std_logic;Y_out : out std_logic);
  end component MUX8to1 ;



  --signal y_31,y_30,y_21,y_20,y_11,y_10,y_01,y_00 : std_logic;
  
  begin 
   M1 : MUX8to1 port map (A7=>A37,A6=>A36,A5=>A35,A4=>A34,A3=>A33,A2=>A32,A1=>A31,A0=>A30,S2=>S2,S1=>S1,S0=>S0,Y_out=>Y_out3);
	M2 : MUX8to1 port map (A7=>A27,A6=>A26,A5=>A25,A4=>A24,A3=>A23,A2=>A22,A1=>A21,A0=>A20,S2=>S2,S1=>S1,S0=>S0,Y_out=>Y_out2);
	M3 : MUX8to1 port map (A7=>A17,A6=>A16,A5=>A15,A4=>A14,A3=>A13,A2=>A12,A1=>A11,A0=>A10,S2=>S2,S1=>S1,S0=>S0,Y_out=>Y_out1);
	M4 : MUX8to1 port map (A7=>A07,A6=>A06,A5=>A05,A4=>A04,A3=>A03,A2=>A02,A1=>A01,A0=>A00,S2=>S2,S1=>S1,S0=>S0,Y_out=>Y_out0);
	

   
 
  
end Struct;