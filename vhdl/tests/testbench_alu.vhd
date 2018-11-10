
library ieee;
use ieee.std_logic_1164.all;

entity tb_half_adder_chip is
end tb_half_adder_chip;

architecture behav of tb_half_adder_chip is

  component the_chip
    port (
        x, y : in std_logic;
        sum, carry : out std_logic);
  end component;

  for the_chip_0: the_chip use entity work.half_adder;
  signal x, y, sum, carry : std_logic;
      
begin
  the_chip_0: the_chip port map (x => x, y => y, sum => sum, carry => carry);

  process
    type pattern_type is record
        x, y : std_logic;
        sum, carry : std_logic;
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      (('0', '0', '0', '0'),
       ('1', '0', '1', '0'),
       ('0', '1', '1', '0'),
       ('1', '1', '0', '1'));

  begin

    for i in patterns'range loop
      x <= patterns(i).x;
      y <= patterns(i).y;

      --  Wait for the results.
      wait for 1 ns;
      --  Check the outputs.
      assert sum = patterns(i).sum
        report "test fail" severity error;
      assert carry = patterns(i).carry
        report "test fail" severity error;
    end loop;

    assert false report "end of test" severity note;
    --  Wait forever; this will finish the simulation.
    wait;
	 
  end process;
end behav;


library ieee;
use ieee.std_logic_1164.all;

entity tb_full_adder_chip is
end tb_full_adder_chip;

architecture behav of tb_full_adder_chip is

  component the_chip
    port (
        x, y, z : in std_logic;
        sum, carry : out std_logic);
  end component;

  for the_chip_0: the_chip use entity work.full_adder;
  signal x, y, z, sum, carry : std_logic;

begin
  the_chip_0: the_chip port map (x => x, y => y, z => z, sum => sum, carry => carry);

  process
    type pattern_type is record
        x, y, z : std_logic;
        sum, carry : std_logic;
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      (('0', '0', '0', '0', '0'),
       ('0', '0', '1', '1', '0'),
       ('0', '1', '0', '1', '0'),
       ('0', '1', '1', '0', '1'),
       ('1', '0', '0', '1', '0'),
       ('1', '0', '1', '0', '1'),
       ('1', '1', '0', '0', '1'),
       ('1', '1', '1', '1', '1'));

  begin

    for i in patterns'range loop
      x <= patterns(i).x;
      y <= patterns(i).y;
      z <= patterns(i).z;

      --  Wait for the results.
      wait for 1 ns;
      --  Check the outputs.
      assert sum = patterns(i).sum
        report "test fail" severity error;
      assert carry = patterns(i).carry
        report "test fail" severity error;
    end loop;

    assert false report "end of test" severity note;
    --  Wait forever; this will finish the simulation.
    wait;

  end process;
end behav;
