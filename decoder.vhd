
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.config.all;

entity decoder is
	Port (
		I_clk     : in STD_LOGIC;
		I_en      : in STD_LOGIC;
		
		I_ins     : in STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
		
		O_selRs1  : out STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
		O_selRs2  : out STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
		O_selRD   : out STD_LOGIC_VECTOR (REGISTER_MUX_WIDTH- 1 downto 0);
		O_selWrR  : out STD_LOGIC;
		
		O_aluOp   : out STD_LOGIC_VECTOR (ALU_CONTROL_BUS_SIZE - 1 downto 0);
		O_imm     : out STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
		O_aluSrc  : out STD_LOGIC
	);
end decoder;


architecture Behavioral of decoder is
begin
    process(I_clk, I_en)
    begin
        if rising_edge(I_clk) and I_en='1' then
        
            case I_ins(INSTRUCTION_OPCODE_MSB_BIT downto INSTRUCTION_OPCODE_LSB_BIT) is
            
                when OPCODE_OP =>
                --
                    -- The alu op is 8 bits width composed from the next bits
                    --
                    O_aluOp <= I_ins(INSTRUCTION_FUNC7_MSB downto INSTRUCTION_FUNC7_LSB + 2) 
                             & I_ins(INSTRUCTION_FUNC3_MSB downto INSTRUCTION_FUNC3_LSB);
                             
                    O_aluSrc <= '1';
                    
                when OPCODE_OPIMM =>

                    case I_ins(14 downto 12) is
            
                        when "101" =>
                            --
                            -- The alu op is 8 bits width composed from the next bits
                            --
                            O_aluOp <= I_ins(INSTRUCTION_FUNC7_MSB downto INSTRUCTION_FUNC7_LSB + 2) 
                                     & I_ins(INSTRUCTION_FUNC3_MSB downto INSTRUCTION_FUNC3_LSB);

                        when others =>
                            O_aluOp <= "00000" & I_ins(INSTRUCTION_FUNC3_MSB downto INSTRUCTION_FUNC3_LSB);
                    
                    end case;
                    
                    O_aluSrc <= '0';
                
                when others =>
                    O_aluOp <= "UUUUUUUU";
                    
            end case;
        end if;
    end process;
end Behavioral;

