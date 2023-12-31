# https://www.gnu.org/software/make/manual/make.html#Makefile-Basics
SHELL = /bin/sh

# https://savannah.gnu.org/bugs/index.php?64472
INSTALL = install
CC = cc

prefix = /usr/local
datarootdir = $(prefix)/share
datadir = $(datarootdir)
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
sysconfdir = $(prefix)/etc

all: passwiz passphrase

passwiz: passwiz.sh
	cp ./passwiz.sh ./passwiz
	chmod +x ./passwiz

passphrase: src/passphrase.c
	$(CC) ./src/passphrase.c -lsodium -o ./passphrase

install: passwiz passphrase
	$(INSTALL) --verbose --mode=664 -D \
		--target-directory=$(DESTDIR)$(sysconfdir)/passwiz/ \
		./etc/eff_large_wordlist.txt
	$(INSTALL) --verbose --mode=775 -D \
		--target-directory=$(DESTDIR)$(bindir)/ \
		./passwiz
	$(INSTALL) --verbose --mode=775 -D \
		--target-directory=$(DESTDIR)$(bindir)/ \
		./passphrase

uninstall:
	rm --verbose --recursive --force \
		$(DESTDIR)$(sysconfdir)/passwiz \
		$(DESTDIR)$(bindir)/passwiz \
		$(DESTDIR)$(bindir)/passphrase

clean:
	rm --verbose --force ./passwiz ./passphrase

.PHONY: all install uninstall clean
