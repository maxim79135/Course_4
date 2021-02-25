library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_port_rom is

	port
	(
		addr	: in natural range 0 to 127;
		clk		: in std_logic;
		q		: out std_logic_vector(3 downto 0)
	);
	
end entity;

architecture rtl of single_port_rom is

	-- Build a 2-D array type for the RoM
	subtype word_t is std_logic_vector(3 downto 0);
	type memory_t is array(255 downto 0) of word_t;
		
	function init_rom
		return memory_t is
		variable tmp : memory_t := (others => (others => '0'));
		begin
			for addr_pos in 0 to 127 loop
				-- Initialize each address with the address itself
				tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, 4));
			end loop;
		return tmp;
	end init_rom;
	
	-- Declare the ROM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	signal rom : memory_t := (
		0 => "0000", -- Prog 0
		1 => "1000",
		2 => "1100",
		3 => "1110",
		4 => "1111",
		5 => "1110",
		6 => "1100",
		7 => "1000",
		8 => "1000", -- Prog 1
		9 => "0100",
		10 => "0010",
		11 => "0001",
		12 => "1000",
		13 => "0100",
		14 => "0010",
		15 => "0001",
		16 => "0001", -- Prog 2
		17 => "0010",
		18 => "0100",
		19 => "1000",
		20 => "0001",
		21 => "0010",
		22 => "0100",
		23 => "1000",
		24 => "0101", -- Prog 3
		25 => "1010",
		26 => "0101",
		27 => "1010",
		28 => "0101",
		29 => "1010",
		30 => "0101",
		31 => "1010",
		32 => "1000", -- Prog 4
		33 => "0100",
		34 => "0010",
		35 => "0001",
		36 => "1000",
		37 => "0100",
		38 => "0010",
		39 => "0001",
		40 => "0000", -- Prog 5
		41 => "0001",
		42 => "0011",
		43 => "0111",
		44 => "1111",
		45 => "0111",
		46 => "0011",
		47 => "0001",
		48 => "1001", -- Prog 6
		49 => "0110",
		50 => "1001",
		51 => "0110",
		52 => "1001",
		53 => "0110",
		54 => "1001",
		55 => "0110",
		56 => "0000", -- 
		57 => "0000",
		58 => "0000",
		59 => "0000",
		60 => "0000",
		61 => "0000",
		62 => "0000",
		63 => "0000",
		64 => "1100", -- Prog 7
		65 => "0011",
		66 => "1100",
		67 => "0011",
		68 => "1100",
		69 => "0011",
		70 => "1100",
		71 => "0011",
		72 => "1100", -- Prog 8
		73 => "0110",
		74 => "0011",
		75 => "0110",
		76 => "1100",
		77 => "0110",
		78 => "0011",
		79 => "0110",
		OTHERS => "0000"
	);
	
begin
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			q <= rom(addr);
		end if;
	end process;
		
end rtl;
