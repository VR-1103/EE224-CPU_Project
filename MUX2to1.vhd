library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_2_1  is
  port (S, A, B: in std_logic; Y: out std_logic);
end entity MUX_2_1;
--For 0 choses B

architecture Struct of MUX_2_1 is
  signal Q, S1, S2: std_logic;
begin
  -- component instances  
  NOT1: INVERTER port map(A => S, Y=> Q);
  AND1: AND_2 port map (A => Q, B => B, Y => S1);
  AND2: AND_2 port map (A => A, B => S, Y => S2);
  
  OR1: OR_2 port map (A => S1, B => S2, Y => Y); 
end Struct;