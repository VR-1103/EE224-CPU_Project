library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lmsm is
	port( imm:in std_logic_vector(8 downto 0);
		r_add: out std_logic_vector(2 downto 0);
		count:in integer);
end lmsm;

architecture bhv of lmsm is 
begin

get_radd : process (imm,count)
--given particular imm, count, r_add corresponding is given out
begin
	if (count<4) then
		r_add(2) <= '0';
	else 
		r_add(2) <= '1';
	end if;
	if (count=0 or count=4) then
		r_add(1 downto 0) <= "00";
	elsif (count=1 or count=5) then
		r_add(1 downto 0) <= "01";
	elsif (count=2 or count=6) then
		r_add(1 downto 0) <= "10";
	elsif (count=3 or count=7) then
		r_add(1 downto 0) <= "11";
	else null;
	end if; 	
end process;

end architecture;		
		
