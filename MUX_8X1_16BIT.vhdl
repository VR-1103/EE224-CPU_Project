Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_8X1_16BIT is 
  port (A7,A6,A5,A4,A3,A2,A1,A0 :in std_logic_vector( 15 downto 0);
       S_2,S_1,S_0: in std_logic;Y : out std_logic_vector(15 downto 0));
  end entity MUX_8X1_16BIT ;


architecture Struct of MUX_8X1_16BIT is

component MUX_8X1_4BIT is 
  port (A37,A36,A35,A34,A33,A32,A31,A30,
        A27,A26,A25,A24,A23,A22,A21,A20,
		  A17,A16,A15,A14,A13,A12,A11,A10,
		  A07,A06,A05,A04,A03,A02,A01,A00,
       S2,S1,S0: in std_logic;Y_out3,Y_out2,Y_out1,Y_out0 : out std_logic);
  end component MUX_8X1_4BIT ;



  --signal y_31,y_30,y_21,y_20,y_11,y_10,y_01,y_00 : std_logic;
  
  begin 
   M1 : MUX_8X1_4BIT port map (A37=>A7(15),A36=>A6(15),A35=>A5(15),A34=>A4(15),A33=>A3(15),A32=>A2(15),A31=>A1(15),A30=>A0(15),
                               A27=>A7(14),A26=>A6(14),A25=>A5(14),A24=>A4(14),A23=>A3(14),A22=>A2(14),A21=>A1(14),A20=>A0(14),
		               A17=>A7(13),A16=>A6(13),A15=>A5(13),A14=>A4(13),A13=>A3(13),A12=>A2(13),A11=>A1(13),A10=>A0(13),
		               A07=>A7(12),A06=> A6(12),A05=> A5(12),A04=> A4(12),A03=> A3(12),A02=> A2(12),A01=> A1(12),A00=>A0(12),
                               S2=>S_2,S1=>S_1,S0=>S_0,
			       Y_out3=>Y(15),Y_out2=>Y(14),Y_out1=>Y(13),Y_out0=>Y(12));
										 
   M2 : MUX_8X1_4BIT port map     (A37=>A7(11),A36=>A6(11),A35=>A5(11),A34=>A4(11),A33=>A3(11),A32=>A2(11),A31=>A1(11),A30=> A0(11),
                                   A27=>A7(10),A26=>A6(10),A25=>A5(10),A24=>A4(10),A23=>A3(10),A22=>A2(10),A21=>A1(10),A20=>A0(10),
		                   A17=>A7(9),A16=> A6(9),A15=> A5(9),A14=> A4(9),A13=>A3(9),A12=>A2(9),A11=>A1(9),A10=> A0(9),
		                   A07=>A7(8),A06=>A6(8),A05=>  A5(8),A04=> A4(8),A03=> A3(8),A02=> A2(8),A01=> A1(8),A00=> A0(8),
                                   S2=>S_2,S1=>S_1,S0=>S_0,
				   Y_out3=>Y(11),Y_out2=>Y(10),Y_out1=>Y(9),Y_out0=>Y(8));
										 
	M3 : MUX_8X1_4BIT port map (A37=>A7(7),A36=>A6(7),A35=>A5(7),A34=>A4(7),A33=>A3(7),A32=>A2(7),A31=>A1(7),A30=>A0(7),
                                    A27=>A7(6),A26=>A6(6),A25=>A5(6),A24=>A4(6),A23=>A3(6),A22=>A2(6),A21=>A1(6),A20=>A0(6),
		                    A17=>A7(5),A16=>A6(5),A15=>A5(5),A14=>A4(5),A13=>A3(5),A12=>A2(5),A11=>A1(5),A10=> A0(5),
		                    A07=>A7(4),A06=> A6(4),A05=>A5(4),A04=> A4(4),A03=> A3(4),A02=>A2(4),A01=>A1(4),A00=> A0(4),
                                    S2=>S_2,S1=>S_1,S0=>S_0,
				    Y_out3=>Y(7),Y_out2=>Y(6),Y_out1=>Y(5),Y_out0=>Y(4));
										 
	M4 : MUX_8X1_4BIT port map (A37=>A7(3),A36=>A6(3),A35=>A5(3),A34=>A4(3),A33=>A3(3),A32=>A2(3),A31=>A1(3),A30=>A0(3),
                                    A27=>A7(2),A26=>A6(2),A25=>A5(2),A24=>A4(2),A23=>A3(2),A22=>A2(2),A21=>A1(2),A20=>A0(2),
		                    A17=>A7(1),A16=>A6(1),A15=>A5(1),A14=>A4(1),A13=>A3(1),A12=>A2(1),A11=>A1(1),A10=>A0(1),
		                    A07=>A7(0),A06=>A6(0),A05=>A5(0),A04=>A4(0),A03=>A3(0),A02=>A2(0),A01=>A1(0),A00=>A0(0),
                                    S2=>S_2,S1=>S_1,S0=>S_0,
				    Y_out3=>Y(3),Y_out2=>Y(2),Y_out1=>Y(1),Y_out0=>Y(0));									 
	

   
 
  
end Struct;