
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc.

entity tb_@@CHIPUNIT@@ is
end tb_@@CHIPUNIT@@;

architecture behav of tb_@@CHIPUNIT@@ is

  component the_chip
    port (
        x, y : in std_logic;
        o : out std_logic);
  end component;

  for the_chip_0: the_chip use entity work.@@CHIPUNIT@@;
  signal x, y, o : std_logic;
  file input_buf : text;
      
begin
  the_chip_0: the_chip port map (x => x, y => y, o => o);

  process
    type pattern_type is record
      x, y: std_logic;
      o : std_logic;
    end record;

    variable read_col_from_input_buf : line;
    variable val_x, val_y, val_o : std_logic;
    variable val_SPACE : character;
  begin
  
    file_open(input_buf, "test_data/@@CHIPUNIT@@.td",  read_mode); 

    while not endfile(input_buf) loop
        readline(input_buf, read_col_from_input_buf);
        read(read_col_from_input_buf, val_x);
        read(read_col_from_input_buf, val_SPACE);
        read(read_col_from_input_buf, val_y);
        read(read_col_from_input_buf, val_SPACE);
        read(read_col_from_input_buf, val_o);
        
        x <= val_x;
        y <= val_y;
            
        --  Wait for the results.
        wait for 1 ns;
        --  Check the outputs.
        assert o = val_o
            report "test fail" severity error;
            
    end loop;
        
    file_close(input_buf);             
	 
    assert false report "end of test" severity note;
    --  Wait forever; this will finish the simulation.
    wait;
	 
  end process;
end behav;
