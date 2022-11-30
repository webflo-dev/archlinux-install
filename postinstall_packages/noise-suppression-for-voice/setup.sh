#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})
DESTDIR=${HOME}/.config/pipewire/filter-chain.conf.d

install -d -m 755 ${DESTDIR}
install -Dm 644 ${SOURCEDIR}/99-input-denoising.conf ${DESTDIR}
