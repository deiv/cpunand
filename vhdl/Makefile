
GHDL=/usr/bin/ghdl-mcode
GHDLFLAGS=--ieee=synopsys
GHDLRUNFLAGS=

CHIPS=nand and

CHIPSENTITIES_NAMES=$(addsuffix _chip,$(CHIPS))
TESTENTITIES_NAMES=$(addprefix tb_, $(addsuffix _chip,$(CHIPS)))

TESTBENCHS_SRCS=$(addprefix tb_, $(addsuffix _chip.vhd,$(CHIPS)))
TESTBENCHS_NAMES=$(addprefix tb_, $(addsuffix _chip-test,$(CHIPS)))

OBJ_FILE=work-obj93.cf


all: $(OBJ_FILE)

tests: run

$(TESTBENCHS_SRCS):
	cat testbench_template.vhd | sed 's\@@CHIPUNIT@@\$(subst .vhd,,$(subst tb_,,$@))\g' > $@

generate: $(OBJ_FILE)

$(TESTENTITIES_NAMES): $(TESTBENCHS_SRCS)
	$(GHDL) -a $(GHDLFLAGS) $(addsuffix .vhd,$@)
	$(GHDL) -c $(GHDLFLAGS) -e $@


$(CHIPSENTITIES_NAMES):
	$(GHDL) -a $(GHDLFLAGS) chips.vhd
	$(GHDL) -c $(GHDLFLAGS) -e $@

analyze:  $(CHIPSENTITIES_NAMES) $(TESTENTITIES_NAMES)

$(TESTBENCHS_NAMES): $(OBJ_FILE)
	$(GHDL) -c $(GHDLFLAGS) -r $(subst -test,,$@) $(GHDLRUNFLAGS)

$(OBJ_FILE):  chips.vhd $(TESTBENCHS_SRCS)
	make analyze

run : $(OBJ_FILE)
	make $(TESTBENCHS_NAMES)

clean:
	rm -Rf $(OBJ_FILE) $(TESTBENCHS_SRCS)

.PHONY: clean analyze generate run tests all $(TESTENTITIES_NAMES) $(TESTBENCHS_NAMES) $(CHIPSENTITIES_NAMES)
