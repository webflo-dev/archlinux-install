#!/usr/bin/env bash

SOURCEDIR=${SOURCEDIR:-$(pwd)}
DESTDIR=${HOME}/.config

sudo gpasswd -a ${USER} input
install -Dm 644 /etc/libinput-gestures.conf ${DESTDIR}
libinput-gestures-setup start
