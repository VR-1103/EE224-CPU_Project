library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lmsm is
	--LMSM block is required for the instructions LM and SM
	--It checks which values of the 9 bit immediate are 1 and returns the corresponding address in the Register file as output in corresponding clock cycles
	port( imm:in std_logic_vector(8 downto 0);
	q:in std_logic; --When q is 1, that is when the count moves to next bit on the left in immediate
	clock:in std_logic;
	r_add: out std_logic_vector(2 downto 0);
	count:out integer); --count gives out which bit in immediate is being scanned at the moment
end lmsm;

architecture bhv of lmsm is
signal count_now,count_next : integer := 0; 
signal r_add_next: std_logic_vector(2 downto 0) := "000";
begin

clock_process : process (clock,r_add_next)
--in next clock cycle, r_add output is given value r_add_next got from get_radd process
begin
	if (clock'event and clock='1') then
		r_add <= r_add_next;
		count_now <= count_next;
	else null;
	end if;
end process;

get_radd : process (imm,count_now)
--given particular imm, count_now, update what r_add comes next
begin
	if (imm(count_now)='0' or count_now>7) then --when immediate's bit is 1 or the count is less than 8 is when the r_add matters
		null;
	else
		if (count_now<4) then
			r_add_next(2) <= '0';
		else 
			r_add_next(2) <= '1';
		end if;
		if (count_now=0 or count_now=4) then
			r_add_next(1 downto 0) <= "00";
		elsif (count_now=1 or count_now=5) then
			r_add_next(1 downto 0) <= "01";
		elsif (count_now=2 or count_now=6) then
			r_add_next(1 downto 0) <= "10";
		elsif (count_now=3 or count_now=7) then
			r_add_next(1 downto 0) <= "11";
		else null;
		end if; 
	end if;	
end process;

change_count : process (q,count_now)
--whenever q changes from 0 to 1, it means that we want count_now to update to the count_now+1
--if count_now=8, then we want count_now=0 instantiation
begin
	if (count_now>7) then
		count_next <= 0;
	elsif (q='1') then 
		count_next <= count_now+1;
	else null;
	end if;
end process;
count <= count_now; 
end architecture;		
		
