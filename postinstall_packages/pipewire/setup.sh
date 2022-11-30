#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})

install -d -m 744 $HOME/.config/

install -Dm 644 $SOURCEDIR/10-echo-cancellation.conf $HOME/.config/pipewire/filter-chain.conf.d
install -Dm 644 $SOURCEDIR/pipewire-filter-chain.service $HOME/.config/systemd/user

