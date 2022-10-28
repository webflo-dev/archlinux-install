DESTDIR = ${HOME}/.config/pipewire/filter-chain.conf.d

install:
	install -d -m 755 $(DESTDIR)
	install -Dm 644 99-input-denoising.conf $(DESTDIR)

.PHONY: install