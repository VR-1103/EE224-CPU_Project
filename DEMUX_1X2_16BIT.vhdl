Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity DEMUX_1X2_16BIT is 
  port (A : in std_logic_vector(15 downto 0) ;S_16BIT : in std_logic;
  Y1,Y0 : out std_logic_vector(15 downto 0));
  end entity DEMUX_1X2_16BIT ;


architecture Struct of DEMUX_1X2_16BIT is
 
component DEMUX_1X2_4BIT is 
  port (A3,A2,A1,A0,S_4BIT: in std_logic; Y7,Y6,Y5,Y4,Y3,Y2, Y1 ,Y0 : out std_logic);
  end component DEMUX_1X2_4BIT ;


    
  begin 
	M1 : DEMUX_1X2_4BIT port map (A(15),A(14),A(13),A(12),S_16BIT,Y1(15),Y1(14),Y1(13),Y1(12),Y0(15),Y0(14),Y0(13),Y0(12));
	M2 : DEMUX_1X2_4BIT port map (A(11),A(10),A(9),A(8),S_16BIT,Y1(11),Y1(10),Y1(9),Y1(8),Y0(11),Y0(10),Y0(9),Y0(8));
	M3 : DEMUX_1X2_4BIT port map (A(7),A(6),A(5),A(4),S_16BIT,Y1(7),Y1(6),Y1(5),Y1(4),Y0(7),Y0(6),Y0(5),Y0(4));
	M4 : DEMUX_1X2_4BIT port map (A(3),A(2),A(1),A(0),S_16BIT,Y1(3),Y1(2),Y1(1),Y1(0),Y0(3),Y0(2),Y0(1),Y0(0));
end Struct;