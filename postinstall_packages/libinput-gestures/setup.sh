#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})
DESTDIR=${HOME}/.config

sudo gpasswd -a ${USER} input
install -Dm 644 /etc/libinput-gestures.conf ${DESTDIR}
libinput-gestures-setup start
