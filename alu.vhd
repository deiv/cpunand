
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.config.all;

entity alu is
    Port (
        I_clk    : in STD_LOGIC;
        I_en     : in STD_LOGIC;
        
        I_op     : in STD_LOGIC_VECTOR (ALU_CONTROL_BUS_SIZE - 1 downto 0);
        I_op1    : in STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
        I_op2    : in STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0);
        
        O_result : out STD_LOGIC_VECTOR (WORD_SIZE_MSB downto 0)
    );
end alu;


architecture Behavioral of alu is
begin

    process(I_clk, I_en)
    begin
        if rising_edge(I_clk) and I_en='1' then

            case I_op is
                when ALU_OPCODE_ADD => O_result <= std_logic_vector(signed(I_op1) + signed(I_op2));
                when ALU_OPCODE_SUB => O_result <= std_logic_vector(signed(I_op1) - signed(I_op2));
                
                when ALU_OPCODE_XOR => O_result <= I_op1 xor I_op2;
                when ALU_OPCODE_OR  => O_result <= I_op1 or  I_op2;
                when ALU_OPCODE_AND => O_result <= I_op1 and I_op2;	 
                
                when ALU_OPCODE_SLL => O_result <= std_logic_vector(shift_left(unsigned(I_op1),  to_integer(unsigned(I_op1(4 downto 0)))));
                when ALU_OPCODE_SRL => O_result <= std_logic_vector(shift_right(unsigned(I_op1), to_integer(unsigned(I_op2(4 downto 0)))));
                when ALU_OPCODE_SRA => O_result <= std_logic_vector(shift_right(signed(I_op1),   to_integer(unsigned(I_op2(4 downto 0)))));
                
                when ALU_OPCODE_SLT =>
                    if signed(I_op1) < signed(I_op2) then
                        O_result <= X"00000001";
                    else
                        O_result <= X"00000000";
                    end if;
                
                when ALU_OPCODE_SLTU=>
                    if unsigned(I_op1) < unsigned(I_op2) then
                        O_result <= X"00000001";
                    else
                        O_result <= X"00000000";
                    end if;

                when others => O_result <=  "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";

            end case;
        end if;
    end process;
end Behavioral;

