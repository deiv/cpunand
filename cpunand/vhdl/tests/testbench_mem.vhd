
library ieee;
use ieee.std_logic_1164.all;

entity tb_dff_chip is
end tb_dff_chip;

architecture behavior of tb_dff_chip is

    component dff
    port(
         d : in  std_logic;
         clk : in  std_logic;
         q : out  std_logic
        );
    end component;

   signal d : std_logic := '0';
   signal clk : std_logic := '0';
   signal q : std_logic;

   constant clk_period : time := 10 ns;

begin

    uut: dff port map (
        q => q,
        clk => clk,
        d => d
    );

    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;

        clk <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin

        d <= '0';

        --  wait for the results.
        wait for 50 ns;

        --  check the outputs.
        assert q = '0' report "test fail" severity error;

        --  wait for the results.
        wait for 50 ns;

        --  check the outputs.
        assert q = '0' report "test fail" severity error;

        d <= '1';

        --  wait for the results.
        wait for 50 ns;

        --  check the outputs.
        assert q = '1' report "test fail" severity error;

        --  wait for the results.
        wait for 50 ns;

        --  check the outputs.
        assert q = '1' report "test fail" severity error;

        assert false report "end of test" severity note;
        --  wait forever; this will finish the simulation.
        wait;

        d <= '0';

        --  wait for the results.
        wait for 50 ns;

        --  check the outputs.
        assert q = '0' report "test fail" severity error;

        --  wait for the results.
        wait for 50 ns;

        --  check the outputs.
        assert q = '0' report "test fail" severity error;

        d <= '1';

        --  wait for the results.
        wait for 50 ns;

        --  check the outputs.
        assert q = '1' report "test fail" severity error;

        --  wait for the results.
        wait for 50 ns;

        --  check the outputs.
        assert q = '1' report "test fail" severity error;

        assert false report "end of test" severity note;
        --  wait forever; this will finish the simulation.
        wait;

    end process;

end;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- vhdl testbench code for the single-port ram
entity tb_single_port_ram_vhdl_chip is
end tb_single_port_ram_vhdl_chip;

architecture behavior of tb_single_port_ram_vhdl_chip is

    -- component declaration for the single-port ram in vhdl

    component single_port_ram_vhdl
    port(
         ram_addr : in  std_logic_vector(6 downto 0);
         ram_data_in : in  std_logic_vector(7 downto 0);
         ram_wr : in  std_logic;
         ram_clock : in  std_logic;
         ram_data_out : out  std_logic_vector(7 downto 0)
        );
    end component;


   --inputs
   signal ram_addr : std_logic_vector(6 downto 0) := (others => '0');
   signal ram_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal ram_wr : std_logic := '0';
   signal ram_clock : std_logic := '0';

  --outputs
   signal ram_data_out : std_logic_vector(7 downto 0);

   -- clock period definitions
   constant ram_clock_period : time := 10 ns;

begin

 -- instantiate the single-port ram in vhdl
   uut: single_port_ram_vhdl port map (
          ram_addr => ram_addr,
          ram_data_in => ram_data_in,
          ram_wr => ram_wr,
          ram_clock => ram_clock,
          ram_data_out => ram_data_out
        );

   -- clock process definitions
    ram_clock_process :process
    begin
    ram_clock <= '0';
    wait for ram_clock_period/2;
    ram_clock <= '1';
    wait for ram_clock_period/2;
    end process;

    stim_proc: process
    begin
        ram_wr <= '0';
        ram_addr <= "0000000";
        ram_data_in <= x"ff";
          wait for 100 ns;

        -- start reading data from ram
        for i in 0 to 5 loop
        ram_addr <= ram_addr + "0000001";
          wait for ram_clock_period*5;
        end loop;
        ram_addr <= "0000000";
        ram_wr <= '1';

        -- start writing to ram
        wait for 100 ns;
        for i in 0 to 5 loop
        ram_addr <= ram_addr + "0000001";
        ram_data_in <= ram_data_in-x"01";
          wait for ram_clock_period*5;
        end loop;
        ram_wr <= '0';

        ram_addr <= "0000000";
        wait for 100 ns;

        -- start reading data from ram
        for i in 0 to 5 loop
        ram_addr <= ram_addr + "0000001";
          wait for ram_clock_period*5;
        end loop;
        ram_addr <= "0000000";

        wait;
    end process;

end;
