
GHDL=/usr/bin/ghdl-mcode
GHDLFLAGS=--ieee=synopsys
GHDLRUNFLAGS=

CHIPS_1INPUT=not
CHIPS_2INPUTS=nand and or xor

ALL_CHIPS=$(CHIPS_1INPUT) $(CHIPS_2INPUTS)

CHIPSENTITIES_NAMES=$(addsuffix _chip,$(ALL_CHIPS))
TESTENTITIES_NAMES=$(addprefix tb_, $(addsuffix _chip,$(ALL_CHIPS)))
TESTBENCHS_NAMES=$(addprefix tb_, $(addsuffix _chip-test,$(ALL_CHIPS)))

TESTBENCHS_1_1_SRCS=$(addprefix tests/tb_, $(addsuffix _chip.vhd,$(CHIPS_1INPUT)))
TESTBENCHS_2_1_SRCS=$(addprefix tests/tb_, $(addsuffix _chip.vhd,$(CHIPS_2INPUTS)))

TEST_TEMPLATE_1_1=tests/testbench_1-1_template.vhd
TEST_TEMPLATE_2_1=tests/testbench_2-1_template.vhd

OBJ_FILE=work-obj93.cf


all: $(OBJ_FILE)

tests: run

$(TESTBENCHS_1_1_SRCS):
	cat $(TEST_TEMPLATE_1_1) | sed 's\@@CHIPUNIT@@\$(subst .vhd,,$(subst tests/tb_,,$@))\g' > $@

$(TESTBENCHS_2_1_SRCS):
	cat $(TEST_TEMPLATE_2_1) | sed 's\@@CHIPUNIT@@\$(subst .vhd,,$(subst tests/tb_,,$@))\g' > $@

generate: $(OBJ_FILE)

$(TESTENTITIES_NAMES): $(TESTBENCHS_1_1_SRCS) $(TESTBENCHS_2_1_SRCS)
	$(GHDL) -a $(GHDLFLAGS) $(addprefix tests/, $(addsuffix .vhd,$@))
	$(GHDL) -c $(GHDLFLAGS) -e $@

$(CHIPSENTITIES_NAMES):
	$(GHDL) -a $(GHDLFLAGS) chips.vhd
	$(GHDL) -c $(GHDLFLAGS) -e $@

analyze:  $(CHIPSENTITIES_NAMES) $(TESTENTITIES_NAMES)

$(TESTBENCHS_NAMES): $(OBJ_FILE)
	$(GHDL) -c $(GHDLFLAGS) -r $(subst -test,,$@) $(GHDLRUNFLAGS)

$(OBJ_FILE):  chips.vhd $(TESTBENCHS_1_1_SRCS) $(TESTBENCHS_2_1_SRCS)
	make analyze

run : $(OBJ_FILE)
	make $(TESTBENCHS_NAMES)

clean:
	rm -Rf $(OBJ_FILE) $(TESTBENCHS_1_1_SRCS) $(TESTBENCHS_2_1_SRCS)

.PHONY: clean analyze generate run tests all $(TESTENTITIES_NAMES) $(TESTBENCHS_NAMES) $(CHIPSENTITIES_NAMES)
