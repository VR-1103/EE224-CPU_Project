Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_1X2_16BIT is 
  port (A,B: in std_logic_vector(15 downto 0) ;Sig_16BIT: in std_logic;Y: out std_logic_vector(15 downto 0));
  end entity MUX_1X2_16BIT ;


architecture Struct of MUX_1X2_16BIT is

 component MUX_1X2_4BIT is 
 port (A3,A2,A1,A0,B3,B2,B1,B0,Sig_4BIT: in std_logic;Y3,Y2, Y1 ,Y0 : out std_logic);
 end component MUX_1X2_4BIT ;

  --signal y_1,y_0 : std_logic;
  
  begin 
   M1 : MUX_1X2_4BIT port map (A3=>A(15),B3=>B(15),A2=>A(14),B2=>B(14),A1=>A(13),B1=>B(13),A0=>A(12),B0=>B(12),Sig_4BIT=>Sig_16BIT,Y3=>Y(15),Y2=>Y(14),Y1=>Y(13),Y0=>Y(12));
	M2 : MUX_1X2_4BIT port map (A3=>A(11),B3=>B(11),A2=>A(10),B2=>B(10),A1=>A(9),B1=>B(9),A0=>A(8),B0=>B(8),Sig_4BIT=>Sig_16BIT,Y3=>Y(11),Y2=>Y(10),Y1=>Y(9),Y0=>Y(8));
	M3 : MUX_1X2_4BIT port map (A3=>A(7),B3=>B(7),A2=>A(6),B2=>B(6),A1=>A(5),B1=>B(5),A0=>A(4),B0=>B(4),Sig_4BIT=>Sig_16BIT,Y3=>Y(7),Y2=>Y(6),Y1=>Y(5),Y0=>Y(4));
	M4 : MUX_1X2_4BIT port map (A3=>A(3),B3=>B(3),A2=>A(2),B2=>B(2),A1=>A(1),B1=>B(1),A0=>A(0),B0=>B(0),Sig_4BIT=>Sig_16BIT,Y3=>Y(3),Y2=>Y(2),Y1=>Y(1),Y0=>Y(0));
	

   
 
  
end Struct;