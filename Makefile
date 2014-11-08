all: deps compile

all-clean: deps-clean clean

REBAR?=rebar
ERLANG?=`which erl`

clean:
	rm -rf yep ebin doc

compile:
	@(echo "Using Erlang in $(ERLANG)"; $(REBAR) compile escriptize)

deps:
	@(echo "Using Erlang in $(ERLANG)"; $(REBAR) -q get-deps)

deps-clean:
	rm -rf lib

install:
	chmod +x yep
	cp yep /usr/local/bin

install-clean:
	rm /usr/local/bin/yep

