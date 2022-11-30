library ieee;
use ieee.std_logic_1164.all;

entity alu is
	--An ALU that has 2 16 bit inputs, 2 select lines, an output X and 2 flags Carry C and Zero Z
	port (
	clock: in std_logic;
	A: in std_logic_vector(15 downto 0);
	B: in std_logic_vector(15 downto 0);
	sel: in std_logic_vector(1 downto 0);
	X: out std_logic_vector(15 downto 0);
	C: out std_logic;
	Z: out std_logic);
end alu;

architecture a1 of alu is
  function add(A: in std_logic_vector(15 downto 0);
    B: in std_logic_vector(15 downto 0))
    return std_logic_vector is
	   variable sum : std_logic_vector(15 downto 0) := (others => '0');
		variable carry : std_logic_vector(15 downto 0) := (others => '0');
    begin
		L1: for i in 0 to 15 loop
		  if i = 0 then
		    sum(i) := A(i) xor B(i) xor '0';
			 carry(i) := A(i) and B(i);
		  else 
		    sum(i) := A(i) xor B(i) xor carry(i-1);
			 carry(i) := (A(i) and B(i)) or (carry(i-1) and (A(i) xor B(i)));
		  end if;
		end loop L1;
    return carry(15) & sum;
  end add;
  
begin
alu_proc: process(A, B, sel)
variable temp: std_logic_vector(16 downto 0);
begin
    if sel="00" then 
      temp := add(A,B);
	   X<= temp(15 downto 0);
	   C <= temp(16);
		if temp(15 downto 0)="0000000000000000" then
		  Z<='1';
		else
		  Z<='0';
		end if;
    elsif sel="01" then
      temp := '0'&(A nand B);
		X<=temp(15 downto 0);
		if temp="00000000000000000" then
		  Z<='1';
		else
		  Z <='0';
		end if;
    elsif sel="10" then
      temp := '0' & A(8 downto 0) &"0000000";
		X <= temp(15 downto 0);
		C <= '0';
	   if temp="00000000000000000" then
		  Z <= '1';
	   else
	     Z <= '0';
	   end if;
    else
      null;
    end if;
	
end process;
end a1;