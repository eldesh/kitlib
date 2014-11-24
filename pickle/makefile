
SMLSHARP = smlsharp

VPATH = .:..:test
INCDIR = $(patsubst %,-I%,$(subst :, ,$(VPATH)))
SMLSHARPFLAGS = $(INCDIR)

SRCS = eqhashdyn2.sml \
	   bitstream.sml \
	   ../hashtable/Polyhash.sml \
	   pickle.sml

OBJS = $(SRCS:.sml=.o)

TEST      = pickletest
TEST_SRCS = pickletest.sml
TEST_OBJS = $(TEST_SRCS:.sml=.o)

all: $(OBJS)

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
test: test/$(TEST).res
	@cat $<

test/$(TEST): $(OBJS) $(TEST_OBJS) test/test_main.sml
	$(SMLSHARP) $(SMLSHARPFLAGS) -o test/$(TEST) test/test_main.sml

test/$(TEST).out: test/$(TEST)
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
	rm -rf test/$(TEST)
	rm -rf test/$(TEST).out
	rm -rf test/$(TEST).res
