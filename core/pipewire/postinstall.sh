#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})
DESTDIR=${HOME}/.config/pipewire/filter-chain.conf.d

install -d -m 744 ${DESTDIR}
install -Dm 644 ${SOURCEDIR}/10-echo-cancellation.conf ${DESTDIR}
