
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc.

library work;
use work.config.all;

entity registers_tb is
end registers_tb;

architecture behavior OF registers_tb IS

	COMPONENT registers
		PORT(
			I_clk    : in STD_LOGIC;
			I_en     : in STD_LOGIC;
			I_Data   : in STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
			I_selRs1 : in STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
			I_selRs2 : in STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
			I_selRD  : in STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
			I_we     : in STD_LOGIC;
			O_dataA  : out STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);  
			O_dataB  : out STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0)
		);
	END COMPONENT;

   --Inputs
   signal I_clk    : std_logic := '0';
   signal I_en     : std_logic := '0';
   signal I_Data   : std_logic_vector(WORD_SIZE_MSB downto 0) := (others => '0');
   signal I_selRs1 : std_logic_vector(REGISTER_MUX_WIDTH- 1 downto 0) := (others => '0');
   signal I_selRs2 : std_logic_vector(REGISTER_MUX_WIDTH- 1 downto 0) := (others => '0');
   signal I_selRD  : std_logic_vector(REGISTER_MUX_WIDTH- 1 downto 0) := (others => '0');
   signal I_we     : std_logic := '0';
 
  --Outputs
   signal O_dataA : std_logic_vector(WORD_SIZE_MSB downto 0);
   signal O_dataB : std_logic_vector(WORD_SIZE_MSB downto 0);
 
   -- Clock period definitions
   constant I_clk_period : time := 10 ns;
begin

	-- Instantiate the Unit Under Test (UUT)
   uut: registers PORT MAP (
		 I_clk    => I_clk,
		 I_en     => I_en,
		 I_Data   => I_Data,
		 O_dataA  => O_dataA,
		 O_dataB  => O_dataB,
		 I_selRs1 => I_selRs1,
		 I_selRs2 => I_selRs2,
		 I_selRD  => I_selRD,
		 I_we     => I_we
	  );

   -- Clock process definitions
   I_clk_process :process
   begin
    I_clk <= '0';
    wait for I_clk_period/2;
    I_clk <= '1';
    wait for I_clk_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin
	
		wait for I_clk_period;

		-- insert stimulus here 

		I_en <= '1';

		-- test for writing.
		-- r0 = 0xfab5
		I_selRs1 <= "00000";
		I_selRs2 <= "00001";
		I_selRD <= "00000";
		I_Data <= X"0000FAB5";
		I_we <= '1';
		wait for I_clk_period;

		-- r2 = 0x2222
		I_selRs1 <= "00000";
		I_selRs2 <= "00001";
		I_selRD <= "00010";
		I_Data <= X"00002222";
		I_we <= '1';
		wait for I_clk_period;

		-- r3 = 0x3333
		I_selRs1 <= "00000";
		I_selRs2 <= "00001";
		I_selRD <= "00010";
		I_Data <= X"00003333";
		I_we <= '1';
		wait for I_clk_period;

		--test just reading, with no write
		I_selRs1 <= "00000";
		I_selRs2 <= "00001";
		I_selRD <= "00000";
		I_Data <= X"0000FEED";
		I_we <= '0';
		wait for I_clk_period;

		--at this point dataA should not be 'feed'

		I_selRs1 <= "00001";
		I_selRs2 <= "00010";
		wait for I_clk_period;

		I_selRs1 <= "00011";
		I_selRs2 <= "00100";
		wait for I_clk_period;

		I_selRs1 <= "00000";
		I_selRs2 <= "00001";
		I_selRD <= "00100";
		I_Data <= X"00004444";
		I_we <= '1';
		wait for I_clk_period;

		I_we <= '0';
		wait for I_clk_period;

		-- nop
		wait for I_clk_period;

		I_selRs1 <= "00100";
		I_selRs2 <= "00100";
		wait for I_clk_period;

		wait;
   end process;

end;
