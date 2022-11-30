library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity DEMUX1to2  is
  port (S, D: in std_logic; Y1,Y0: out std_logic);
end entity DEMUX1to2;

architecture Struct of DEMUX1to2 is
  signal S_BAR : std_logic;
begin
  -- component instances
  Complement: INVERTER port map (A => S,  Y => S_BAR);
  AND1: AND_2 port map ( A =>S , B=> D, Y => Y1);
  AND2: AND_2 port map (A => S_BAR, B => D, Y => Y0);
  
 
  
end Struct;