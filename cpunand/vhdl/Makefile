
GHDL=/usr/bin/ghdl-mcode
GHDLFLAGS=--ieee=synopsys
GHDLRUNFLAGS=

CHIPS_1INPUT=not
CHIPS_2INPUTS=nand and or xor
CHIPS_3_1=mux
CHIPS_2_2=dmux

BASIC_CHIPS=$(CHIPS_1INPUT) $(CHIPS_2INPUTS) $(CHIPS_3_1) $(CHIPS_2_2)
ALU_CHIPS=half_adder full_adder alu
MEM_CHIPS=Single_port_RAM_VHDL
#DFF

BASIC_CHIPSENTITIES_NAMES=$(addsuffix _chip,$(BASIC_CHIPS))
BASIC_TESTENTITIES_NAMES=$(addprefix tb_, $(addsuffix _chip,$(BASIC_CHIPS)))

ALL_CHIPS=$(BASIC_CHIPS) $(ALU_CHIPS) $(MEM_CHIPS)
TESTBENCHS_NAMES=$(addprefix tb_, $(addsuffix _chip-test,$(ALL_CHIPS)))

TESTBENCHS_1_1_SRCS=$(addprefix tests/generated/tb_, $(addsuffix _chip.vhd,$(CHIPS_1INPUT)))
TESTBENCHS_2_1_SRCS=$(addprefix tests/generated/tb_, $(addsuffix _chip.vhd,$(CHIPS_2INPUTS)))
TESTBENCHS_3_1_SRCS=$(addprefix tests/generated/tb_, $(addsuffix _chip.vhd,$(CHIPS_3_1)))
TESTBENCHS_2_2_SRCS=$(addprefix tests/generated/tb_, $(addsuffix _chip.vhd,$(CHIPS_2_2)))

TEST_TEMPLATE_1_1=tests/testbench_1-1_template.vhd
TEST_TEMPLATE_2_1=tests/testbench_2-1_template.vhd
TEST_TEMPLATE_3_1=tests/testbench_3-1_template.vhd
TEST_TEMPLATE_2_2=tests/testbench_2-2_template.vhd

ALU_CHIPSENTITIES_NAME=half_adder full_adder alu
ALU_TESTBENCHS_SRCS=tests/testbench_alu.vhd
ALU_TESTENTITIES_NAMES=tb_half_adder_chip tb_full_adder_chip tb_alu_chip

MEM_CHIPSENTITIES_NAME=DFF Single_port_RAM_VHDL
MEM_TESTBENCHS_SRCS=tests/testbench_mem.vhd
MEM_TESTENTITIES_NAMES= tb_single_port_ram_vhdl_chip
#tb_DFF_chip

GENERATED_TESTS_DIR=tests/generated/

OBJ_FILE=work-obj93.cf


all: $(OBJ_FILE)

tests: run

$(GENERATED_TESTS_DIR):
	mkdir -p $(GENERATED_TESTS_DIR)

$(TESTBENCHS_1_1_SRCS): $(GENERATED_TESTS_DIR)
	cat $(TEST_TEMPLATE_1_1) | sed 's\@@CHIPUNIT@@\$(subst .vhd,,$(subst tests/generated/tb_,,$@))\g' > $@

$(TESTBENCHS_2_1_SRCS): $(GENERATED_TESTS_DIR)
	cat $(TEST_TEMPLATE_2_1) | sed 's\@@CHIPUNIT@@\$(subst .vhd,,$(subst tests/generated/tb_,,$@))\g' > $@

$(TESTBENCHS_3_1_SRCS): $(GENERATED_TESTS_DIR)
	cat $(TEST_TEMPLATE_3_1) | sed 's\@@CHIPUNIT@@\$(subst .vhd,,$(subst tests/generated/tb_,,$@))\g' > $@

$(TESTBENCHS_2_2_SRCS): $(GENERATED_TESTS_DIR)
	cat $(TEST_TEMPLATE_2_2) | sed 's\@@CHIPUNIT@@\$(subst .vhd,,$(subst tests/generated/tb_,,$@))\g' > $@

generate: $(OBJ_FILE)

$(BASIC_TESTENTITIES_NAMES): $(TESTBENCHS_1_1_SRCS) $(TESTBENCHS_2_1_SRCS) $(TESTBENCHS_3_1_SRCS) $(TESTBENCHS_2_2_SRCS)
	$(GHDL) -a $(GHDLFLAGS) $(addprefix tests/generated/, $(addsuffix .vhd,$@))
	$(GHDL) -c $(GHDLFLAGS) -e $@

$(BASIC_CHIPSENTITIES_NAMES):
	$(GHDL) -a $(GHDLFLAGS) chips.vhd
	$(GHDL) -c $(GHDLFLAGS) -e $@

$(ALU_CHIPSENTITIES_NAME):
	$(GHDL) -a $(GHDLFLAGS) alu.vhd
	$(GHDL) -c $(GHDLFLAGS) -e $@

$(ALU_TESTENTITIES_NAMES):
	$(GHDL) -a $(GHDLFLAGS) $(ALU_TESTBENCHS_SRCS)
	$(GHDL) -c $(GHDLFLAGS) -e $@

$(MEM_CHIPSENTITIES_NAME):
	$(GHDL) -a $(GHDLFLAGS) memory.vhd
	$(GHDL) -c $(GHDLFLAGS) -e $@

$(MEM_TESTENTITIES_NAMES):
	$(GHDL) -a $(GHDLFLAGS) $(MEM_TESTBENCHS_SRCS)
	$(GHDL) -c $(GHDLFLAGS) -e $@

analyze:  $(BASIC_CHIPSENTITIES_NAMES) $(BASIC_TESTENTITIES_NAMES) $(ALU_CHIPSENTITIES_NAME) $(ALU_TESTENTITIES_NAMES) $(MEM_CHIPSENTITIES_NAME) $(MEM_TESTENTITIES_NAMES) $(ALU_TESTBENCHS_SRCS) $(MEM_TESTBENCHS_SRCS)

$(TESTBENCHS_NAMES): $(OBJ_FILE)
	mkdir -p tests/waveforms
	$(GHDL) -c $(GHDLFLAGS) -r $(subst -test,,$@) $(GHDLRUNFLAGS) --vcd=tests/waveforms/$@.vcd

$(OBJ_FILE):  chips.vhd alu.vhd memory.vhd $(TESTBENCHS_1_1_SRCS) $(TESTBENCHS_2_1_SRCS) $(TESTBENCHS_3_1_SRCS) $(TESTBENCHS_2_2_SRCS) $(TESTBENCHS_SRCS)
	make analyze

run : $(OBJ_FILE)
	make $(TESTBENCHS_NAMES)

clean:
	rm -Rf $(OBJ_FILE) $(TESTBENCHS_1_1_SRCS) $(TESTBENCHS_2_1_SRCS) $(TESTBENCHS_3_1_SRCS) $(TESTBENCHS_2_2_SRCS) $(GENERATED_TESTS_DIR) tests/waveforms

.PHONY: clean analyze generate run tests all $(BASIC_TESTENTITIES_NAMES) $(TESTBENCHS_NAMES) $(BASIC_CHIPSENTITIES_NAMES)
