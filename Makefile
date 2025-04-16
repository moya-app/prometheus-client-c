
SHELL = /bin/bash
PREFIX=/usr/local

default: build

build: 
	mkdir prom/build
	mkdir promhttp/build
	cd prom/build && cmake .. && make -j2
	cd promhttp/build && cmake .. && make -j2

clean:
	rm -rf prom/build
	rm -rf promhttp/build

install:
	install -m 0755 -d ${PREFIX}/lib
	install -m 0755 prom/build/libprom.so ${PREFIX}/lib
	install -m 0755 promhttp/build/libpromhttp.so ${PREFIX}/lib

test: build
	mkdir promtest/build
	cd promtest/build && cmaker .. && make -j2
