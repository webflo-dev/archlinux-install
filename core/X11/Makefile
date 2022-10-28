DESTDIR = /etc/X11/xorg.conf.d

install:
	sudo install -d -m 755 $(DESTDIR)
	sudo install -Dm 644 00-touchpad.conf $(DESTDIR)
	sudo install -Dm 644 10-monitor.conf $(DESTDIR)
	sudo install -Dm 644 20-intel.conf $(DESTDIR)
	sudo install -Dm 644 20-nvidia.conf $(DESTDIR)


.PHONY: install