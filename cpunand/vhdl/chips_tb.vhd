
library ieee;
use ieee.std_logic_1164.all;

entity chips_tb is
end chips_tb;

architecture behav of chips_tb is
  component and_chip
    port (
	   x, y : in std_logic;
		o : out std_logic);
  end component;

  for and_0: and_chip use entity work.nand_chip;
  signal x, y, o : std_logic;
  
begin
  and_0: and_chip port map (x => x, y => y, o => o);

  process
    type pattern_type is record
      x, y: std_logic;
      o : std_logic;
    end record;
	 
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      (('0', '0', '0'),
       ('1', '0', '0'),
       ('0', '1', '0'),
       ('1', '1', '1'));
		 
  begin
    for i in patterns'range loop
      x <= patterns(i).x;
      y <= patterns(i).y;
		
      --  Wait for the results.
      wait for 1 ns;
      --  Check the outputs.
      assert o = patterns(i).o
        report "test fail" severity error;
    end loop;
	 
    assert false report "end of test" severity note;
    --  Wait forever; this will finish the simulation.
    wait;
	 
  end process;
end behav;
