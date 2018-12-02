
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


library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity tb_alu_chip is
end tb_alu_chip;

architecture behav of tb_alu_chip is

  component the_chip
    port (
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
        ng  : out std_logic);
  end component;

  for the_chip_0: the_chip use entity work.alu;

  signal x, y, o : SIGNED(15 downto 0);
  signal zx, nx, zy, ny, f, no, zr, ng : std_logic;

begin
  the_chip_0: the_chip port map (x => x, y => y, o => o,
                                 zx => zx, nx => nx, zy => zy, ny => ny,
                                 f => f, no => no, zr => zr, ng => ng);

  process
    type pattern_type is record
        x, y : SIGNED(15 downto 0);
        zx, nx, zy, ny, f, no : std_logic;
        o : SIGNED(15 downto 0);
        zr, ng : std_logic;
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      (("0000000000000000","1111111111111111",'1','0','1','0','1','0',"0000000000000000",'1','0'),
       ("0000000000000000","1111111111111111",'1','1','1','1','1','1',"0000000000000001",'0','0'),
       ("0000000000000000","1111111111111111",'1','1','1','0','1','0',"1111111111111111",'0','1'),
       ("0000000000000000","1111111111111111",'0','0','1','1','0','0',"0000000000000000",'1','0'),
       ("0000000000000000","1111111111111111",'1','1','0','0','0','0',"1111111111111111",'0','1'),
       ("0000000000000000","1111111111111111",'0','0','1','1','0','1',"1111111111111111",'0','1'),
       ("0000000000000000","1111111111111111",'1','1','0','0','0','1',"0000000000000000",'1','0'),
       ("0000000000000000","1111111111111111",'0','0','1','1','1','1',"0000000000000000",'1','0'),
       ("0000000000000000","1111111111111111",'1','1','0','0','1','1',"0000000000000001",'0','0'),
       ("0000000000000000","1111111111111111",'0','1','1','1','1','1',"0000000000000001",'0','0'),
       ("0000000000000000","1111111111111111",'1','1','0','1','1','1',"0000000000000000",'1','0'),
       ("0000000000000000","1111111111111111",'0','0','1','1','1','0',"1111111111111111",'0','1'),
       ("0000000000000000","1111111111111111",'1','1','0','0','1','0',"1111111111111110",'0','1'),
       ("0000000000000000","1111111111111111",'0','0','0','0','1','0',"1111111111111111",'0','1'),
       ("0000000000000000","1111111111111111",'0','1','0','0','1','1',"0000000000000001",'0','0'),
       ("0000000000000000","1111111111111111",'0','0','0','1','1','1',"1111111111111111",'0','1'),
       ("0000000000000000","1111111111111111",'0','0','0','0','0','0',"0000000000000000",'1','0'),
       ("0000000000000000","1111111111111111",'0','1','0','1','0','1',"1111111111111111",'0','1'),
       ("0000000000010001","0000000000000011",'1','0','1','0','1','0',"0000000000000000",'1','0'),
       ("0000000000010001","0000000000000011",'1','1','1','1','1','1',"0000000000000001",'0','0'),
       ("0000000000010001","0000000000000011",'1','1','1','0','1','0',"1111111111111111",'0','1'),
       ("0000000000010001","0000000000000011",'0','0','1','1','0','0',"0000000000010001",'0','0'),
       ("0000000000010001","0000000000000011",'1','1','0','0','0','0',"0000000000000011",'0','0'),
       ("0000000000010001","0000000000000011",'0','0','1','1','0','1',"1111111111101110",'0','1'),
       ("0000000000010001","0000000000000011",'1','1','0','0','0','1',"1111111111111100",'0','1'),
       ("0000000000010001","0000000000000011",'0','0','1','1','1','1',"1111111111101111",'0','1'),
       ("0000000000010001","0000000000000011",'1','1','0','0','1','1',"1111111111111101",'0','1'),
       ("0000000000010001","0000000000000011",'0','1','1','1','1','1',"0000000000010010",'0','0'),
       ("0000000000010001","0000000000000011",'1','1','0','1','1','1',"0000000000000100",'0','0'),
       ("0000000000010001","0000000000000011",'0','0','1','1','1','0',"0000000000010000",'0','0'),
       ("0000000000010001","0000000000000011",'1','1','0','0','1','0',"0000000000000010",'0','0'),
       ("0000000000010001","0000000000000011",'0','0','0','0','1','0',"0000000000010100",'0','0'),
       ("0000000000010001","0000000000000011",'0','1','0','0','1','1',"0000000000001110",'0','0'),
       ("0000000000010001","0000000000000011",'0','0','0','1','1','1',"1111111111110010",'0','1'),
       ("0000000000010001","0000000000000011",'0','0','0','0','0','0',"0000000000000001",'0','0'),
       ("0000000000010001","0000000000000011",'0','1','0','1','0','1',"0000000000010011",'0','0'));

  begin

    for i in patterns'range loop
      x <= patterns(i).x;
      y <= patterns(i).y;
      zx <= patterns(i).zx;
      nx <= patterns(i).nx;
      zy <= patterns(i).zy;
      ny <= patterns(i).ny;
      f <= patterns(i).f;
      no <= patterns(i).no;

      --  Wait for the results.
      wait for 10 ns;
      --  Check the outputs.
      assert o = patterns(i).o
        report "test fail: o" severity error;
      assert zr = patterns(i).zr
        report "test fail: zr" severity error;
      assert ng = patterns(i).ng
        report "test fail: ng" severity error;
    end loop;

    assert false report "end of test" severity note;
    --  Wait forever; this will finish the simulation.
    wait;

  end process;
end behav;