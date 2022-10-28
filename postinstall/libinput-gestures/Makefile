DESTDIR = ${HOME}/.config

install:
	sudo gpasswd -a ${USER} input
	libinput-gestures-setup start
	install -Dm 644 /etc/libinput-gestures.conf $(DESTDIR)

.PHONY: install