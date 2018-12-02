
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


library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity alu is

	port
	(
		x	: in SIGNED(15 downto 0);
		y	: in SIGNED(15 downto 0);
        zx  : in std_logic;
        nx  : in std_logic;
        zy  : in std_logic;
        ny  : in std_logic;
        f   : in std_logic;
        no  : in std_logic;

        o : out SIGNED(15 downto 0);
        zr  : out std_logic;
        ng  : out std_logic
	);

end entity;

architecture rtl of alu is
    signal zx_mux, nx_mux, zy_mux, ny_mux, f_mux, final_out : SIGNED(15 downto 0);
    constant ZEROVALUE : SIGNED(15 downto 0) := "0000000000000000";
    constant ONEVALUE : SIGNED(15 downto 0)  := "1111111111111111";

begin

    zx_mux <= x when (zx = '0') else ZEROVALUE;
    nx_mux <= zx_mux when (nx = '0') else not zx_mux;

    zy_mux <= y when (zy = '0') else ZEROVALUE;
    ny_mux <= zy_mux when (ny = '0') else not zy_mux;

    f_mux <= nx_mux and ny_mux when (f = '0') else nx_mux + ny_mux;
    final_out <= f_mux when (no = '0') else not f_mux;

    o <= final_out;
    zr <= '1' when (final_out = ZEROVALUE) else '0';
    ng <= '1' when (final_out < ZEROVALUE) else '0';

end rtl;
