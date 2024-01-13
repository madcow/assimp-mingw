BASH := bash
RMR  := rm -rf

all:
	$(BASH) build.sh

clean:
	$(RMR) ./lib
	$(RMR) ./include
	$(RMR) ./build
