#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})
DESTDIR=/etc/X11/xorg.conf.d

sudo install -d -m 755 ${DESTDIR}
sudo install -Dm 644 ${SOURCEDIR}/00-touchpad.conf ${DESTDIR}
sudo install -Dm 644 ${SOURCEDIR}/10-monitor.conf ${DESTDIR}
sudo install -Dm 644 ${SOURCEDIR}/20-intel.conf ${DESTDIR}
# sudo install -Dm 644 ${SOURCEDIR}/20-nvidia.conf ${DESTDIR}
