CFLAGS ?= -DPROM_LOG_ENABLE -g -O3
LIB_PATH := .:$$PWD/prom/build:$$PWD/promhttp/build:/usr/local/lib
# SHELL = /bin/bash
#
ifeq ($(DESTDIR),)
INSTALL_DIR := /usr
else 
INSTALL_DIR ?= $(DESTDIR)/usr
endif

default: build

build: 
	mkdir prom/build
	mkdir promhttp/build
	cd prom/build && cmake $(CMAKE_EXTRA_OPTS) .. && $(MAKE) $(MAKE_FLAGS)
	cd promhttp/build && cmake .. && $(MAKE) $(MAKE_FLAGS)

distclean: clean
clean:
	rm -rf prom/build
	rm -rf promhttp/build
	rm -rf promtest/build

install:
	install -m 755 -d $(INSTALL_DIR)/lib/$(DEB_BUILD_GNU_TYPE)
	install -m 755 prom/build/libprom.so $(INSTALL_DIR)/lib/$(DEB_BUILD_GNU_TYPE)
	install -m 755 promhttp/build/libpromhttp.so $(INSTALL_DIR)/lib/$(DEB_BUILD_GNU_TYPE)

test:
	mkdir promtest/build
	cd promtest/build && cmake .. && make -j2
