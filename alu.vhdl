library ieee;
use ieee.std_logic_1164.all;

entity alu is
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
	component adder_16bit is
		port(A,B: in std_logic_vector(15 downto 0);
			  S: out std_logic_vector(15 downto 0);
			  C: out std_logic);
	end component;

	signal add: std_logic_vector(15 downto 0);
	signal outp: std_logic_vector(15 downto 0);
	signal c_dummy : std_logic;
begin
	adder: adder_16bit port map(A=>A,B=>B,S=>add,C=>C_dummy);
	process(A,B,clock)
	begin
		if (clock'event and clock='1') then
			case sel is
				when "00" =>
					X <= add;
					outp <= add;
					c <= c_dummy;
					if (outp = "0000000000000000") then
						Z<='1';
					else
						Z<='0';
					end if;
				when "01" =>
					X <= A nand B;
					outp <= A nand B;
					C <= '0';
					if (outp = "0000000000000000") then
						Z<='1';
					else
						Z<='0';
					end if;
				when "10" =>
					X <= A(8 downto 0) & "0000000";
					outp <= A(8 downto 0) &"0000000";
					C <= '0';
					if (outp = "0000000000000000") then
						Z<='1';
					else
						Z<='0';
					end if;
				when others =>
					null;
			end case;
		else
			null;
		end if;
	end process;
end a1;
