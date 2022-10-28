#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})
DESTDIR = /etc/zsh

sudo install -d -m 755 ${DESTDIR}
sudo install -Dm 644 ${SOURCEDIR}/zshenv ${DESTDIR}