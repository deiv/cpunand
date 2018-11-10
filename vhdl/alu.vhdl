
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is

	port
	(
		x	: in std_logic;
		y	: in std_logic;
		sum	: out std_logic;
		carry	: out std_logic
	);

end entity;

architecture rtl of half_adder is
begin

	process (x, y)
	begin
		sum <= x xor y;
		carry <= x and y;
	end process;
end rtl;

library ieee;
use ieee.std_logic_1164.all;


entity full_adder is

	port
	(
		x	: in std_logic;
		y	: in std_logic;
        z	: in std_logic;
		sum	: out std_logic;
		carry	: out std_logic
	);

end entity;

architecture rtl of full_adder is
begin

	process (x, y, z)
	begin
		sum <= (x xor y) xor z;
		carry <= (x and y) or (z and (x xor y)) ;
	end process;
end rtl;
