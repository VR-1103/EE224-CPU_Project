Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity DEMUX_1X2_4BIT is 
  port (A3,A2,A1,A0,S_4BIT: in std_logic; Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0 : out std_logic);
  end entity DEMUX_1X2_4BIT ;

architecture Struct of DEMUX_1X2_4BIT is

 component DEMUX1to2  is
  port (S, D: in std_logic; Y1,Y0: out std_logic);
end component DEMUX1to2;
  
  begin 
   M1 : DEMUX1to2 port map ( S => S_4BIT, D=>A3 ,Y1=>Y7,Y0=>Y3);
	M2 : DEMUX1to2 port map ( S => S_4BIT, D=>A2 ,Y1=>Y6,Y0=>Y2);
	M3 : DEMUX1to2 port map ( S => S_4BIT, D=>A1 ,Y1=>Y5,Y0=>Y1);
	M4 : DEMUX1to2 port map ( S => S_4BIT, D=>A0 ,Y1=>Y4,Y0=>Y0);
  
end Struct;
