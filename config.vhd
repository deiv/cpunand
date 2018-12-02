
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package config is

	-- Registers size (XLEN in Risc-V specs)
	constant WORD_SIZE    : integer := 32;
	constant WORD_SIZE_MSB: integer := 31;
	
	constant REGISTER_COUNT    : integer := 32;
	constant REGISTER_MUX_WIDTH: integer := 5;
	
	constant ALU_CONTROL_BUS_SIZE   : integer := 8;
	
	--
	-- ISA BIT MAPPINGS
	--
    constant INSTRUCTION_OPCODE_LSB_BIT : integer := 0;
	constant INSTRUCTION_OPCODE_MSB_BIT : integer := 6;
	
	constant INSTRUCTION_FUNC7_MSB : integer := 31;
	constant INSTRUCTION_FUNC7_LSB : integer := 25;
	
	constant INSTRUCTION_FUNC3_MSB : integer := 14;
	constant INSTRUCTION_FUNC3_LSB : integer := 12;
	
	--
	-- OPCODES
	--
	constant OPCODE_SIZE : integer := 7;
	constant OPCODE_MSB  : integer := OPCODE_SIZE - 1;
	
	constant OPCODE_OP   : std_logic_vector(OPCODE_MSB downto 0) := "0110011";
	constant OPCODE_OPIMM: std_logic_vector(OPCODE_MSB downto 0) := "0010011";
	
	--
	-- ALU OPCODES
	-- 
    --
    -- addi	UUUUUUUUUUUUUUUUU000UUUUU0010011
    -- slti	UUUUUUUUUUUUUUUUU010UUUUU0010011
    -- sltiU UUUUUUUUUUUUUUUUU011UUUUU0010011
    -- xori	 UUUUUUUUUUUUUUUUU100UUUUU0010011
    -- ori	UUUUUUUUUUUUUUUUU110UUUUU0010011
    -- andi	UUUUUUUUUUUUUUUUU111UUUUU0010011
    -- slli	0000000UUUUUUUUUU001UUUUU0010011
    -- srli	0000000UUUUUUUUUU101UUUUU0010011
    -- srai	0100000UUUUUUUUUU101UUUUU0010011
    --
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
    -- NOTE: XXX: ALU_OPCODE_SUB for immediate value, is not valid, check at some point...
    -- 
    --  constant ALU_OPCODE_SUB   : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "10100000";
    --
    constant ALU_OPCODE_ADD  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000000";
    constant ALU_OPCODE_SUB  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "01000000";
    constant ALU_OPCODE_SLL  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000001";
    constant ALU_OPCODE_SLT  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000010";
    constant ALU_OPCODE_SLTU : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000011";
    constant ALU_OPCODE_XOR  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000100";
    constant ALU_OPCODE_SRL  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000101";
    constant ALU_OPCODE_SRA  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "01000101";
    constant ALU_OPCODE_OR   : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000110";
    constant ALU_OPCODE_AND  : std_logic_vector(ALU_CONTROL_BUS_SIZE - 1 downto 0) := "00000111"; 


   
	
	--
	--
	--
	-- constant ZERO_BYTE : std_logic_vector(2 downto 0)  := "00000000";

end config;

-- package body config is
--  
-- end config;
