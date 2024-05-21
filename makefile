GCC=gcc
BINDIR=bin
TESTDIR=test_files
FILENAME=ll
BINNAME=lang.bin
TEST_OK=test_ok
TEST_NOOK=test_nook

all: clean parser test

parser:
	@yacc -d $(FILENAME).y
	@flex $(FILENAME).lex
	@$(GCC) lex.yy.c y.tab.c y.tab.h -lm
	@mv a.out ./$(BINDIR)/$(BINNAME)

clean:
	@rm -rf $(BINDIR)/*
	@rm -rf lex.yy.c
	@rm -rf y.tab.h y.tab.c


test: 
	@touch $(BINDIR)/$(TEST_OK).report
	@while read line ; do \
		echo "$$line" | ./$(BINDIR)/$(BINNAME) >> $(BINDIR)/$(TEST_OK).report ; \
	done < $(TESTDIR)/$(TEST_OK)||true;	

	@touch $(BINDIR)/$(TEST_NOOK).report
	@while read line ; do \
		echo "$$line" | ./$(BINDIR)/$(BINNAME) >> $(BINDIR)/$(TEST_NOOK).report; \
	done < $(TESTDIR)/$(TEST_NOOK)||true;	

									

	