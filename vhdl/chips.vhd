
library ieee;
use ieee.std_logic_1164.all;

entity and_chip is

	port 
	(
		x		: in std_logic;
		y	: in std_logic;
		o	: out std_logic
	);

end entity;

architecture rtl of and_chip is
begin

	process (x, y)
	begin
		o <= x and y;
	end process;
end rtl;
