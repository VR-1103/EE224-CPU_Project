library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all;

library work;
use work.Gates.all;

entity main is
	port(clock, reset: in std_logic;
			output : out std_logic);
end main;

architecture bhv of main is
--Including the components
	component alu is
		port (
		clock: in std_logic;
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		sel: in std_logic_vector(1 downto 0);
		X: out std_logic_vector(15 downto 0);
		C: out std_logic;
		Z: out std_logic);
	end component;
	
	component se7 is
		port (A: in std_logic_vector(8 downto 0);
				outp: out std_logic_vector(15 downto 0));
	end component;
	
	component se10 is
		port (A: in std_logic_vector(5 downto 0);
				outp: out std_logic_vector(15 downto 0));
	end component;
	
	component temporary_register is
		port (clock, reset: in std_logic; 
        temp_write : in std_logic_vector(15 downto 0);
        temp_read : out std_logic_vector(15 downto 0);
        temp_W : in std_logic);
	end component;
	
	component register_file is 
-- PC is R7 so incorporating it in register file itself
		port(
			clock, reset, PC_w, RF_W : in std_logic;
			A1, A2, A3 : in std_logic_vector(2 downto 0);
			D3, PC_write : in std_logic_vector(15 downto 0);
			D1, D2, PC_read: out std_logic_vector(15 downto 0));
	end component;
	
	component memory is 
		port(
			 M_add, M_inp : in std_logic_vector(15 downto 0);
			 M_data : out std_logic_vector(15 downto 0);
			 clock, Mem_R, Mem_W : in std_logic);
	end component;
	
	component MUX_1X2_16BIT is 
		port (A,B: in std_logic_vector(15 downto 0) ;Sig_16BIT: in std_logic;Y: out std_logic_vector(15 downto 0));
	end component;
	
	component MUX_4x1_16BIT is 
		port (D3,D2,D1,D0 : in std_logic_vector(15 downto 0);C_1,C_0: in std_logic; Y : out std_logic_vector(15 downto 0));
	end component;
	
	component DEMUX_1X2_16BIT is 
		port (A : in std_logic_vector(15 downto 0) ;S_16BIT : in std_logic;
				Y1,Y0 : out std_logic_vector(15 downto 0));
	end component;
	
	component MUX_8X1_16BIT is 
	  port (A7,A6,A5,A4,A3,A2,A1,A0 :in std_logic_vector( 15 downto 0);
       S_2,S_1,S_0: in std_logic;Y : out std_logic_vector(15 downto 0));
	 end component;
	 
	 component MUX_4x1_3BIT is 
			port(A,B,C,D: in std_logic_vector(2 downto 0);S1,S0: in std_logic; Y: out std_logic_vector(2 downto 0));
	end component;
	
	component lmsm is
		port( 
		r_add: out std_logic_vector(2 downto 0);
		count:in integer range 0 to 8);
	end component;

--Signals used
	type state is (rst,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20);
	signal state_present,state_next: state:=rst;
	signal m1_op,pc_op,t4_op,m2_op,m3_op,m_data,dm_op1,dm_op2,se10_op,se7_op,m5_op,rf_d1,rf_d2,m6_op,m7_op,t1_op,t2_op,t3_op,m8_op,m9_op,
			 alu_x: std_logic_vector(15 downto 0);
	signal alu_c,alu_z : std_logic;
	signal t1_11_9,t1_5_3,t1_8_6,lmsm_op,y: std_logic_vector(2 downto 0);
	signal t1_8_0: std_logic_vector(8 downto 0);
	signal t1_5_0: std_logic_vector(5 downto 0);
	signal a,b,c,d,e,f,g,h,i,j,k,l,m,n,p,r,s,pc_w,t1_w,t2_w,t3_w,t4_w,mem_w,mem_r,rf_w,carry_next,zero_next,carry_present,zero_present: std_logic:='0';
	signal lmsm_count,lmsm_count_next: integer:= 0; --lmsm count
	signal sel: std_logic_vector(1 downto 0);
	
begin
-- Instantiation of the components as given in the port map diagram
	rf: register_file port map(clock,reset,pc_w,rf_w,
										y,t1_8_6,y,
										m5_op,m1_op,
										rf_d1,rf_d2,pc_op);
	memory_main: memory port map(m2_op,m3_op,
										  m_data,
										  clock,mem_r,mem_w);
	t1: temporary_register port map(clock,reset,
										     dm_op2,t1_op,
											  t1_w);
	t2: temporary_register port map(clock,reset,
										     m6_op,t2_op,
											  t2_w);
	t3: temporary_register port map(clock,reset,
										     m7_op,t3_op,
											  t3_w);
	t4: temporary_register port map(clock,reset,
										     pc_op,t4_op,
											  t4_w);
	alu_main: alu port map(clock,
								  m8_op,m9_op,
								  sel,
								  alu_x,alu_c,alu_z);
	se7_main: se7 port map(t1_8_0,
								  se7_op);
	se10_main: se10 port map(t1_5_0,
								  se10_op);
	lmsm_main: lmsm port map(lmsm_op,lmsm_count);
	--lmsm count has count_now value from lmsm component
	m1: MUX_1X2_16BIT port map(alu_x,t3_op,a,m1_op);
	m2: MUX_4x1_16BIT port map("0000000000000000",pc_op,t3_op,t2_op,b,c,m2_op);
	m3: MUX_1X2_16BIT port map(t3_op,t2_op,s,m3_op);
	m4: MUX_4x1_3BIT port map (lmsm_op,t1_8_6,t1_5_3,t1_11_9,e,f,y);
	m5: MUX_4x1_16BIT port map("0000000000000000",t2_op,t3_op,t4_op,j,k,m5_op);
	m6: MUX_1X2_16BIT port map(alu_x,rf_d1,g,m6_op);
	m7: MUX_4x1_16BIT port map(alu_x,rf_d2,rf_d1,dm_op1,h,i,m7_op);
	m8: MUX_8X1_16BIT port map("0000000000000000","0000000000000000","0000000000000000",t3_op,t4_op,pc_op,t2_op,se7_op,r,l,m,m8_op);
	m9: MUX_4x1_16BIT port map(se7_op,se10_op,t3_op,"0000000000000001",n,p,m9_op);
	demux: DEMUX_1X2_16BIT port map(m_data,d,dm_op2,dm_op1);
	
--Breaking the t1_op signal into the required parts
	t1_11_9<=t1_op(11 downto 9);
	t1_8_6<=t1_op(8 downto 6);
	t1_5_3<=t1_op(5 downto 3);
	t1_8_0<=t1_op(8 downto 0);
	t1_5_0<=t1_op(5 downto 0);
	
--Clock process
clk_process: process(clock,reset)
	begin
	if (reset = '1') then
		state_present <= s1;
	elsif (clock='1' and clock' event) then
		state_present <= state_next;
		carry_present <= carry_next;
		zero_present <= zero_next;
		lmsm_count <= lmsm_count_next;
	else
		null;
	end if;
end process;

--Process for control signals
output_process: process(state_present,alu_c,alu_z,t1_op,t3_op,t2_op,carry_present,zero_present,lmsm_count,t1_8_0)
	begin
		a<='0';
		b<='0';
		c<='0';
		d<='0';
		e<='0';
		f<='0';
		g<='0';
		h<='0';
		i<='0';
		j<='0';
		k<='0';
		l<='0';
		m<='0';
		n<='0';
		p<='0';
		r<='0';
		s<='0';
		mem_r<='0';
		mem_w<='0';
		pc_w<='0';
		t1_w<='0';
		t2_w<='0';
		t3_w<='0';
		t4_w<='0';
		sel<="11";
		rf_w<='0';
	case state_present is
	when s1=>
		a<='1';
		b<='1';
		d<='1';
		l<='1';
		mem_r<='1';
		pc_w<='1';
		t1_w<='1';
		t4_w<='1';
		sel<="00";
	when s2=>
		h<='1';
		t2_w<='1';
		t3_w<='1';
		sel<="11";
	when s3=>
		if (t1_op (1 downto 0) = "00") then
			t2_w<='1';
			g<='1';
			m<='1';
			p<='1';
			sel<="00";
			carry_next<=alu_c;
			zero_next<=alu_z;
		elsif (t1_op (1 downto 0) = "10") then
			if (carry_present = '1') then
				t2_w<='1';
				g<='1';
				m<='1';
				p<='1';
				sel<="00";
				carry_next<=alu_c;
				zero_next<=alu_z;
			else 
				t2_w<='1';
				f<='1';
				sel<="11"; 
			end if;
		elsif (t1_op (1 downto 0) = "01") then
			if (zero_present = '1') then
				t2_w<='1';
				g<='1';
				m<='1';
				p<='1';
				sel<="00";
				carry_next<=alu_c;
				zero_next<=alu_z;
			else 
				t2_w<='1';
				f<='1';
			end if;
		else null;
		end if;
	when s4=>
		   if (t1_op(15 downto 12) = "0011") then
			e<='0';
			f<='0';
		elsif (t1_op(15 downto 12) = "0000") then
			e<='0';
			f<='1';
		elsif (t1_op(15 downto 12) = "0010") then
			e<='0';
			f<='1';
		elsif (t1_op(15 downto 12) = "0001") then
			e<='1';
			f<='0';
		else
			null;
		end if;
		j<='1';
		sel<="11";
		rf_w<='1';
	when s5=>
			if (t1_op (1 downto 0) = "00") then
			t2_w<='1';
			g<='1';
			m<='1';
			p<='1';
			sel<="01";
			zero_next<=alu_z;
		elsif (t1_op (1 downto 0) = "10") then
			if (carry_present = '1') then
				t2_w<='1';
				g<='1';
				m<='1';
				p<='1';
				sel<="01";
				zero_next<=alu_z;
			else 
				t2_w<='1';
				f<='1';
				sel<="11"; 
			end if;
		elsif (t1_op (1 downto 0) = "01") then
			if (zero_present = '1') then 
				t2_w<='1';
				g<='1';
				m<='1';
				p<='1';
				sel<="01";
				zero_next<=alu_z;
			else 
				t2_w<='1';
				f<='1';
				sel<="11";
			end if;
		else null;
		end if;
	when s6=>
		g<='1';
		m<='1';
		n<='1';
		t2_w<='1';
		sel<="00";
		carry_next<=alu_c;
		zero_next<=alu_z;
	when s7=>
		g<='1';
		t2_w<='1';
		sel<="10";
	when s8=>
		h<='1';
		i<='1';
		n<='1';
		r<='1';
		t3_w<='1';
		sel<="00";
		if (t1_op(15 downto 12) = "0100") then
			if (t3_op = "0000000000000000") then
				zero_next<=alu_z;
			else null;
			end if;
		else
			null;
		end if;
	when s9=>
		c<='1';
		mem_r<='1';
		t3_w<='1';
		sel<="11";
	when s10=>
		c<='1';
		mem_w<='1';
		sel<="11";
	when s11=>
		t3_w<='1';
		mem_r<='1';
		sel<="11";
		if (lmsm_count=8) then
			lmsm_count_next <= 0;
		else null;
		end if;
	when s19=>
		if (t1_8_0 (lmsm_count) = '0') then 
			rf_w<='0';
		else 
			rf_w<='1';
		end if;
		e<='1';
		f<='1';
		k<='1';
		if (lmsm_count=8) then
			lmsm_count_next <= 0;
		else
			lmsm_count_next <= lmsm_count +1;
		end if;
	when s12=>
		t2_w<='1';
		g<='1';
		m<='1';
		sel<="00";
	when s13=>
		if (t1_op(14)='1') then
			if (t2_op=t3_op) then
				pc_w<='1';
				a<='1';
				l<='1';
				m<='1';
				n<='1';
				sel<="00";
			else --nothing must be done
				sel<="11";
			end if;	
		else 
			pc_w<='1';
			a<='1';
			l<='1';
			m<='1';
			n<='1';
			p<='1';
			sel<="00";
		end if;
	when s14=>
		sel<="11";
		rf_w<='1';
	when s15=>
		pc_w<='1';
		sel<="11";
	when s16=>
		t3_w<='1';
		if (lmsm_count=8) then
			lmsm_count_next <= 0;
		else null;
		end if;
		e<='1';
		f<='1';
		i<='1';
		sel<="11";
	when s20=>
		s<='1';
		if (t1_8_0 (lmsm_count) = '0') then 
			mem_w<='0';
		else 
			mem_w<='1';
		end if;
		if (lmsm_count=8) then
			lmsm_count_next <= 0;
		else 
			lmsm_count_next <= lmsm_count +1;
		end if;		
	when s17=>
		t2_w<='1';
		g<='1';
		m<='1';
		sel<="00";
	when s18=> 
		k<='1';
		rf_w<='1';
	when others=>
		null;
	end case;
end process;


--State Transition process
state_transition: process(state_present,t1_op,lmsm_count,t1_8_0)
	begin
	state_next<=state_present;
	case state_present is
	when rst=>
		state_next<=s1;
	when s1=>
		state_next<=s2;
	when s2=>
		case t1_op(15 downto 12) is
			when "0000"=>
				state_next<=s3;
			when "0001"=>
				state_next<=s6;
			when "0010"=>
				state_next<=s5;
			when "0011"=>
				state_next<=s7;
			when "0100"=>
				state_next<=s8;
			when "0101"=>
				state_next<=s8;
			when "0110"=>
				state_next<=s11;
			when "0111"=>
				state_next<=s16;
			when "1100"=>
				state_next<=s13;
			when "1000"=>
				state_next<=s14;
			when "1001"=>
				state_next<=s14;
			when others=>
				null;
		end case;
	when s3=>
		state_next<=s4;
	when s4=>
		state_next<=s1;
	when s5=>
		state_next<=s4;
	when s6=>
		state_next<=s4;
	when s7=>
		state_next<=s4;
	when s8=>
		if (t1_op(15 downto 12) = "0100") then --decoder to decide which state to go to
			state_next<=s9;
		elsif (t1_op(15 downto 12) = "0101") then
			state_next<=s10;
		else null;
		end if;
	when s9=>
		state_next<=s18;
	when s10=>
		state_next<=s1;
	when s11=>
		if (lmsm_count=8) then
			state_next<=s1;
		else 
			state_next<=s19;
		end if; 
	when s19=>
		if (lmsm_count=8) then --when final immediate bit is being searched, always goes to s1
			state_next<=s1;
		elsif (t1_8_0 (lmsm_count) = '0') then --if particular immediate value is 0 then next 
		--left bit is searched without updation of memory address, ie no s12 state
			state_next<=s19;	
		else 
			state_next<=s12;
		end if; 		
	when s12=>
		state_next<=s11;
	when s13=>
		state_next<=s1;
	when s14=>
		if (t1_op(15 downto 12) = "1000") then
			state_next<=s13;
		elsif (t1_op(15 downto 12) = "1001") then
			state_next<=s15;
		else null;
		end if;
	when s15=>
		state_next<=s1;
	when s16=> 
		if (lmsm_count=8) then
			state_next<=s1;
		else 
			state_next<=s20;
		end if;
	when s20=>
		if (lmsm_count=8) then --when final immediate bit is being searched, always goes to s1
			state_next<=s1;
		elsif (t1_8_0 (lmsm_count) = '0') then --if particular immediate value is 0 then next 
		--left bit is searched without updation of memory address, ie no s17 state
			state_next<=s16; 
		else 
			state_next<=s17;
		end if;
	when s17=>
		state_next<=s16;
	when s18=>
		state_next<=s1;
	when others=>
		null;
	end case;
end process;

--The output for the RTL Simulation has been set to '0', as a dummy output.
output <= '0';
end bhv;
	
