
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc.

library work;
use work.config.all;

entity alu_tb is
end alu_tb;

architecture behavior OF alu_tb IS

function hex (lvec: in std_logic_vector) return string is
        variable text: string(lvec'length / 4 - 1 downto 0) := (others => '9');
        subtype halfbyte is std_logic_vector(4-1 downto 0);
    begin
        assert lvec'length mod 4 = 0
            report "hex() works only with vectors whose length is a multiple of 4"
            severity FAILURE;
        for k in text'range loop
            case halfbyte'(lvec(4 * k + 3 downto 4 * k)) is
                when "0000" => text(k) := '0';
                when "0001" => text(k) := '1';
                when "0010" => text(k) := '2';
                when "0011" => text(k) := '3';
                when "0100" => text(k) := '4';
                when "0101" => text(k) := '5';
                when "0110" => text(k) := '6';
                when "0111" => text(k) := '7';
                when "1000" => text(k) := '8';
                when "1001" => text(k) := '9';
                when "1010" => text(k) := 'A';
                when "1011" => text(k) := 'B';
                when "1100" => text(k) := 'C';
                when "1101" => text(k) := 'D';
                when "1110" => text(k) := 'E';
                when "1111" => text(k) := 'F';
                when others => text(k) := '!';
            end case;
        end loop;
        return text;
    end function;
    
	COMPONENT alu
		Port (
            I_clk    : in STD_LOGIC;
            I_en     : in STD_LOGIC;
            
            I_op     : in STD_LOGIC_VECTOR (ALU_CONTROL_BUS_SIZE - 1 downto 0);
            I_op1    : in STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
            I_op2    : in STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
            
            O_result : out STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0)
		);
	END COMPONENT;
	
    signal I_clk : STD_LOGIC;
    signal I_en  : STD_LOGIC;
    signal I_op  : STD_LOGIC_VECTOR (ALU_CONTROL_BUS_SIZE - 1 downto 0);
    signal I_op1 : STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
    signal I_op2 : STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);

    signal O_result : STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
 
   -- Clock period definitions
   constant I_clk_period : time := 10 ns;
begin

	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
		 I_clk     => I_clk,
		 I_en      => I_en,
		 I_op     => I_op,
		 I_op1  => I_op1,
		 I_op2  => I_op2,
		 O_result  => O_result
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
        
        -- constant ALU_OPCODE_ADD  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000000";
        -- constant ALU_OPCODE_SUB  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "01000000";
        -- constant ALU_OPCODE_SLL  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000001";
        -- constant ALU_OPCODE_SLT  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000010";
        -- constant ALU_OPCODE_SLTU : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000011";
        -- constant ALU_OPCODE_XOR  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000100";
        -- constant ALU_OPCODE_SRL  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000101";
        -- constant ALU_OPCODE_SRA  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "01000101";
        -- constant ALU_OPCODE_OR   : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000110";
        -- constant ALU_OPCODE_AND  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000111"; 
        
        -- ALU_OPCODE_ADD	
        I_op <= ALU_OPCODE_ADD;
        I_op1 <= X"01010101";
        I_op2 <= X"10101010";

        wait for I_clk_period;
        assert O_result = X"11111111"
            report "test fail: ALU_OPCODE_ADD" severity error;
            
        -- ALU_OPCODE_ADD	
        I_op <= ALU_OPCODE_ADD;
        I_op1 <= X"00000ED4";
        I_op2 <= X"000D58CD";

        wait for I_clk_period;
        assert O_result = X"000D67A1"
            report "test fail: ALU_OPCODE_ADD" severity error;
            
        -- ALU_OPCODE_SUB	
        I_op <= ALU_OPCODE_SUB;
        I_op1 <= X"01010101";
        I_op2 <= X"10101010";

        wait for I_clk_period;
        assert O_result = X"F0F0F0F1"
            report "test fail: ALU_OPCODE_SUB" severity error;
            
        -- ALU_OPCODE_SUB	
        I_op <= ALU_OPCODE_SUB;
        I_op1 <= X"0000021D";
        I_op2 <= X"0000003A";

        wait for I_clk_period;
        assert O_result = X"000001E3"
            report "test fail: ALU_OPCODE_SUB" severity error;
            
        -- ALU_OPCODE_XOR	
        I_op <= ALU_OPCODE_XOR;
        I_op1 <= X"F0F0F0F0";
        I_op2 <= X"F0F0F0F0";

        wait for I_clk_period;
        assert O_result = X"00000000"
            report "test fail: ALU_OPCODE_XOR" severity error;
            
        -- ALU_OPCODE_XOR	
        I_op <= ALU_OPCODE_XOR;
        I_op1 <= X"F0F0F0F0";
        I_op2 <= X"0F0F0F0F";

        wait for I_clk_period;
        assert O_result = X"FFFFFFFF"
            report "test fail: ALU_OPCODE_XOR" severity error;
            
        -- ALU_OPCODE_OR	
        I_op <= ALU_OPCODE_OR;
        I_op1 <= X"F0F0F0F0";
        I_op2 <= X"F0F0F0F0";

        wait for I_clk_period;
        assert O_result = X"F0F0F0F0"
            report "test fail: ALU_OPCODE_OR" severity error;
            
        -- ALU_OPCODE_OR	
        I_op <= ALU_OPCODE_OR;
        I_op1 <= X"F0F0F0F0";
        I_op2 <= X"0F0F0F0F";

        wait for I_clk_period;
        assert O_result = X"FFFFFFFF"
            report "test fail: ALU_OPCODE_OR" severity error;
       
        -- ALU_OPCODE_AND	
        I_op <= ALU_OPCODE_AND;
        I_op1 <= X"F0F0F0F0";
        I_op2 <= X"F0F0F0F0";

        wait for I_clk_period;
        assert O_result = X"F0F0F0F0"
            report "test fail: ALU_OPCODE_AND" severity error;
            
        -- ALU_OPCODE_AND	
        I_op <= ALU_OPCODE_AND;
        I_op1 <= X"F0F0F0F0";
        I_op2 <= X"0F0F0F0F";

        wait for I_clk_period;
        assert O_result = X"00000000"
            report "test fail: ALU_OPCODE_AND" severity error;
            
        wait;
   end process;

end;
