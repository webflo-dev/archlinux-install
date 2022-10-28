#!/usr/bin/env bash

SOURCEDIR=$(dirname ${BASH_SOURCE[0]})
DESTDIR = ${HOME}/.local
DESTDIR_BIN = ${DESTDIR}/bin
DESTDIR_GIT = ${DESTDIR}/share/dot-files

install -d -m 755 ${DESTDIR_BIN}
install -d -m 744 ${DESTDIR_GIT}

install -Dm 755 ${SOURCEDIR}/dot-config ${DESTDIR_BIN}

git clone --bare https://github.com/webflo-dev/dotfiles.git ${DESTDIR_GIT}/.git
${DESTDIR_BIN}/dot-config checkout -f
git clone --depth=1 https://github.com/BlingCorp/bling.git ~/.config/awesome/modules/bling
