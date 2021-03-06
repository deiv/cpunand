
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


library ieee;
use ieee.std_logic_1164.all;

entity xor_chip is

	port
	(
		x	: in std_logic;
		y	: in std_logic;
		o	: out std_logic
	);

end entity;

architecture rtl of xor_chip is
begin

	process (x, y)
	begin
		o <= (not (x and y)) and (x or y);
	end process;
end rtl;


library ieee;
use ieee.std_logic_1164.all;

entity mux_chip is

	port
	(
		x	: in std_logic;
		y	: in std_logic;
		sel	: in std_logic;
		o	: out std_logic
	);

end entity;

architecture rtl of mux_chip is
begin

	process (x, y, sel)
	begin
		o <= (x and not sel) or (y and sel);
	end process;
end rtl;


library ieee;
use ieee.std_logic_1164.all;

entity dmux_chip is

	port
	(
		data : in std_logic;
		sel	 : in std_logic;
		x	 : out std_logic;
		y	 : out std_logic
	);

end entity;

architecture rtl of dmux_chip is
begin

	process (data, sel)
	begin
		x <= data and not sel;
		y <= data and sel;
	end process;
end rtl;
