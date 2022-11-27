Library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MUX_4_1  is
  port (C1, C0, D3, D2, D1, D0: in std_logic; Y: out std_logic);
end entity MUX_4_1;

architecture Struct of MUX_4_1 is
  signal S1, S0: std_logic;
  component MUX_2_1 is
		port (S, A, B: in std_logic; Y: out std_logic);
	end component;
begin
  -- component instances
	MUX2_1: MUX_2_1 port map (S => C1, A => D3, B => D1, Y => S1);
	MUX2_2: MUX_2_1 port map (S => C1, A => D2, B => D0, Y => S0);

	MUX2_3: MUX_2_1 port map (S => C0, A => S1, B => S0, Y => Y);
end Struct;