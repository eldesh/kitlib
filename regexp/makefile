
SMLSHARP = smlsharp

VPATH = .:..:test
INCDIR = $(patsubst %,-I%,$(subst :, ,$(VPATH)))
SMLSHARPFLAGS = $(INCDIR)

SRCS = RegExp.sml

OBJS = $(SRCS:.sml=.o)

all: $(OBJS)

TEST      = regexp1 regexp2
TEST_SRCS = regexp1.sml regexp2.sml
TEST_OBJS = $(TEST_SRCS:.sml=.o)
TEST_RESS = $(addprefix test/,$(addsuffix .res,$(TEST)))

## .o type rules
%.o: %.sml
	$(SMLSHARP) $(SMLSHARPFLAGS) -c $<

## generate for SML dependence
%.d: %.sml
	@echo "generate [$@] from [$*]"
	@$(SHELL) -ec '$(SMLSHARP) -MM $(SMLSHARPFLAGS) $< \
		| sed "s/\($*\)\.o[ :]*/\1.o $@ : /g" > $@; \
		[ -s $@ ] || rm -rf $@'

.PHONY: test
test: $(TEST_RESS)
	@cat $^

test/regexp1: $(OBJS) test/regexp1.o test/test_main1.sml
	$(SMLSHARP) $(SMLSHARPFLAGS) -o test/regexp1 test/test_main1.sml

test/regexp2: $(OBJS) test/regexp2.o test/test_main2.sml
	$(SMLSHARP) $(SMLSHARPFLAGS) -o test/regexp2 test/test_main2.sml

test/%.out: test/%
	./$< > $@

%.res: %.out
	@[[ `diff $< $<.ok` ]] && \
           (echo "Test $@: ***ERR***" > $@) || \
           (echo "Test $@: OK" > $@)


ifeq (,$(findstring $(MAKECMDGOALS),clean))
-include $(filter %.d,$(SRCS:.sml=.d))
endif

.PHONY: clean
clean:
	rm -rf $(OBJS)
	rm -rf $(filter %.d,$(SRCS:.sml=.d))
	rm -rf $(addprefix test/,$(TEST_OBJS))
	rm -rf $(TEST_SRCS:.sml=.d)
	rm -rf $(addprefix test/,$(TEST))
	rm -rf $(addprefix test/,$(addsuffix .out,$(TEST)))
	rm -rf $(TEST_RESS)

