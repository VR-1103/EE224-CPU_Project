-- A DUT entity is used to wrap your design so that we can combine it with testbench.
-- This example shows how you can do this for the OR Gate

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(1 downto 0);
       	output_vector: out std_logic_vector(0 downto 0));
end entity;

architecture DutWrap of DUT is
   component main is
		port(clock, reset: in std_logic;
		output: out std_logic);
	end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: main 
			port map (
					-- order of inputs B A
					clock => input_vector(1),
					reset => input_vector(0),
               -- order of output OUTPUT
					output => output_vector(0));
--					output(15) => output_vector(15),
--					output(14) => output_vector(14),
--					output(13) => output_vector(13),
--					output(12) => output_vector(12),
--					output(11) => output_vector(11),
--					output(10) => output_vector(10),
--					output(9) => output_vector(9),
--					output(8) => output_vector(8),
--					output(7) => output_vector(7),
--					output(6) => output_vector(6),
--					output(5) => output_vector(5),
--					output(4) => output_vector(4),
--					output(3) => output_vector(3),
--					output(2) => output_vector(2),
--					output(1) => output_vector(1),
--					output(0) => output_vector(0));
end DutWrap;