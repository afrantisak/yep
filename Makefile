all: deps compile
all-clean: deps-clean compile-clean
clean: compile-clean

REBAR?=rebar
ERLANG?=`which erl`

deps:
	@(echo "Using Erlang in $(ERLANG)"; $(REBAR) -q get-deps)
deps-clean:
	rm -rf lib

compile:
	@(echo "Using Erlang in $(ERLANG)"; $(REBAR) compile escriptize)
compile-clean:
	rm -rf ebin doc yep

install:
	chmod +x yep
	cp yep /usr/local/bin
install-clean:
	rm /usr/local/bin/yep

