
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.config.all;

entity registers is
	Port (
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
end registers;

--
-- TODO: x0 register is zero always (RO)
-- TODO: pc register
--
architecture Behavioral of registers is
    type register_array_t is array (0 to REGISTER_COUNT- 1) of std_logic_vector(WORD_SIZE_MSB downto 0);
    signal regs: register_array_t := (others => X"00000000");
    -- signal dataAout: STD_LOGIC_VECTOR (XLENM1 downto 0) := (others=>'0');
    -- signal dataBout: STD_LOGIC_VECTOR (XLENM1 downto 0) := (others=>'0');
begin

	process(I_clk, I_en)
	begin
		if rising_edge(I_clk) and I_en='1' then
			O_dataA <= regs(to_integer(unsigned(I_selRs1)));
			O_dataB <= regs(to_integer(unsigned(I_selRs2)));
			
			if (I_we = '1') then
				regs(to_integer(unsigned(I_selRD))) <= I_Data;
			end if;
		end if;
	end process;
	
	-- O_dataA <= dataAout;
	-- O_dataB <= dataBout;

end Behavioral;

