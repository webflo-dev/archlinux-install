DESTDIR = ${HOME}/.local
DESTDIR_BIN = $(DESTDIR)/bin
DESTDIR_GIT = $(DESTDIR)/share/dot-files

install:
	install -d -m 755 $(DESTDIR_BIN)
	install -Dm 755 dot-config $(DESTDIR_BIN)
	install -d -m 744 $(DESTDIR_GIT)
	git clone --bare git@github.com:webflo-dev/dotfiles.git $(DESTDIR_GIT)/.git
	$(DESTDIR_BIN)/dot-config checkout -f

.PHONY: install