#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})
DESTDIR=${HOME}/.config/nvim

install -d -m 755 ${DESTDIR}
git clone --depth 1 https://github.com/NvChad/NvChad ${DESTDIR} 
