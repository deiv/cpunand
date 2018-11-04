
library ieee;
use ieee.std_logic_1164.all;

entity nand_chip is

	port
	(
		x	: in std_logic;
		y	: in std_logic;
		o	: out std_logic
	);

end entity;

architecture rtl of nand_chip is
begin

	process (x, y)
	begin
		o <= x nand y;
	end process;
end rtl;


library ieee;
use ieee.std_logic_1164.all;

entity not_chip is

	port
	(
		x	: in std_logic;
		o	: out std_logic
	);

end entity;

architecture rtl of not_chip is
begin

	process (x)
	begin
		o <= x nand x;
	end process;
end rtl;


library ieee;
use ieee.std_logic_1164.all;

entity and_chip is

	port 
	(
		x	: in std_logic;
		y	: in std_logic;
		o	: out std_logic
	);

end entity;

architecture rtl of and_chip is
begin

	process (x, y)
	begin
		o <= not (x nand y);
	end process;
end rtl;


library ieee;
use ieee.std_logic_1164.all;

entity or_chip is

	port
	(
		x	: in std_logic;
		y	: in std_logic;
		o	: out std_logic
	);

end entity;

architecture rtl of or_chip is
begin

	process (x, y)
	begin
		o <= not x nand not y;
	end process;
end rtl;
