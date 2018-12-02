
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc.

library work;
use work.config.all;

entity decoder_tb is
end decoder_tb;

architecture behavior OF decoder_tb IS

	COMPONENT decoder
		Port (
			I_clk     : in STD_LOGIC;
			I_en      : in STD_LOGIC;
			
			I_ins     : in STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
			
			O_selRs1  : out STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
			O_selRs2  : out STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
			O_selRD   : out STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
			O_selWrR  : out STD_LOGIC;
			
			O_aluOp   : out STD_LOGIC_VECTOR (ALU_CONTROL_BUS_SIZE- 1 downto 0);
			O_imm     : out STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
			O_aluSrc  : out STD_LOGIC
		);
	END COMPONENT;
	
	signal I_clk     : STD_LOGIC;
	signal I_en      : STD_LOGIC;
	signal I_ins     : STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
	
	signal O_selRs1  : STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
	signal O_selRs2  : STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
	signal O_selRD   : STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
	signal O_selWrR  : STD_LOGIC;
	signal O_aluOp   : STD_LOGIC_VECTOR (ALU_CONTROL_BUS_SIZE- 1 downto 0);
	signal O_imm     : STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
	signal O_aluSrc  : STD_LOGIC;
 
   -- Clock period definitions
   constant I_clk_period : time := 10 ns;
begin

	-- Instantiate the Unit Under Test (UUT)
   uut: decoder PORT MAP (
		 I_clk     => I_clk,
		 I_en      => I_en,
		 I_ins     => I_ins,
		 O_selRs1  => O_selRs1,
		 O_selRs2  => O_selRs2,
		 O_selRD   => O_selRD,
		 O_selWrR  => O_selWrR,
		 O_aluOp   => O_aluOp,
		 O_imm     => O_imm,
		 O_aluSrc  => O_aluSrc
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
		
		--
		-- addi	UUUUUUUUUUUUUUUUU000UUUUU0010011
		-- slti	UUUUUUUUUUUUUUUUU010UUUUU0010011
		-- sltiU	UUUUUUUUUUUUUUUUU011UUUUU0010011
		-- xori	UUUUUUUUUUUUUUUUU100UUUUU0010011
		-- ori	UUUUUUUUUUUUUUUUU110UUUUU0010011
		-- andi	UUUUUUUUUUUUUUUUU111UUUUU0010011
		-- slli	0000000UUUUUUUUUU001UUUUU0010011
		-- srli	0000000UUUUUUUUUU101UUUUU0010011
		-- srai	0100000UUUUUUUUUU101UUUUU0010011
				
		-- OP		
		-- add	0000000UUUUUUUUUU000UUUUU0110011
		-- sUb	0100000UUUUUUUUUU000UUUUU0110011
		-- sll	0000000UUUUUUUUUU001UUUUU0110011
		-- slt	0000000UUUUUUUUUU010UUUUU0110011
		-- sltU	0000000UUUUUUUUUU011UUUUU0110011
		-- xor	0000000UUUUUUUUUU100UUUUU0110011
		-- srl	0000000UUUUUUUUUU101UUUUU0110011
		-- sra	0100000UUUUUUUUUU101UUUUU0110011
		-- or	0000000UUUUUUUUUU110UUUUU0110011
		-- and	0000000UUUUUUUUUU111UUUUU0110011
		--

		
		-- add	0000000UUUUUUUUUU000UUUUU0110011
		I_ins <= "0000000UUUUUUUUUU000UUUUU0110011";
		wait for I_clk_period;
        assert O_aluOp = "00000000"
            report "test fail" severity error;
        assert O_aluSrc = '1'
            report "test fail" severity error;

		-- sUb	0100000UUUUUUUUUU000UUUUU0110011
		I_ins <= "0100000UUUUUUUUUU000UUUUU0110011";
		wait for I_clk_period;
        assert O_aluOp = "01000000"
        	report "test fail" severity error;
        assert O_aluSrc = '1'
            report "test fail" severity error;
            
		-- sll	0000000UUUUUUUUUU001UUUUU0110011
		I_ins <= "0000000UUUUUUUUUU001UUUUU0110011";
		wait for I_clk_period;
        assert O_aluOp = "00000001"
        	report "test fail" severity error;
        assert O_aluSrc = '1'
            report "test fail" severity error;
            

		-- addi	UUUUUUUUUUUUUUUUU000UUUUU0010011
		I_ins <= "UUUUUUUUUUUUUUUUU000UUUUU0010011";
		wait for I_clk_period;
        assert O_aluOp = "00000000"
        	report "test fail" severity error;
        assert O_aluSrc = '0'
            report "test fail" severity error;
            
		-- slti UUUUUUUUUUUUUUUUU010UUUUU0010011
		I_ins <= "UUUUUUUUUUUUUUUUU010UUUUU0010011";
		wait for I_clk_period;
        assert O_aluOp = "00000010"
        	report "test fail" severity error;
        assert O_aluSrc = '0'
            report "test fail" severity error;
            
		-- slli 0000000UUUUUUUUUU001UUUUU0010011
		I_ins <= "0000000UUUUUUUUUU001UUUUU0010011";
		wait for I_clk_period;
        assert O_aluOp = "00000001"
        	report "test fail" severity error;
        assert O_aluSrc = '0'
            report "test fail" severity error;
            
		-- srli 0000000UUUUUUUUUU101UUUUU0010011
		I_ins <= "0000000UUUUUUUUUU101UUUUU0010011";
		wait for I_clk_period;
        assert O_aluOp = "00000101"
        	report "test fail" severity error;
        assert O_aluSrc = '0'
            report "test fail" severity error;
            
		-- srai 0100000UUUUUUUUUU101UUUUU0010011
		I_ins <= "0100000UUUUUUUUUU101UUUUU0010011";
		wait for I_clk_period;
        assert O_aluOp = "01000101"
        	report "test fail" severity error;
        assert O_aluSrc = '0'
            report "test fail" severity error;
            
		wait;
   end process;

end;
