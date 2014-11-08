all:
	rebar get-deps compile escriptize

clean:
	rm -rf yep ebin doc

deps-clean:
	rm -rf lib

install:
	chmod +x yep
	cp yep /usr/local/bin

install-clean:
	rm /usr/local/bin/yep

