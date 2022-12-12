#!/usr/bin/env bash

SOURCEDIR=${SOURCEDIR:-$(pwd)}
DESTDIR=/etc/zsh

sudo install -d -m 755 ${DESTDIR}
sudo install -Dm 644 ${SOURCEDIR}/zshenv ${DESTDIR}