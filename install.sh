#!/bin/bash

source multiselect.sh


export INSTALLER_INSTALL_DIR=$HOME/_install
export INSTALLER_WORKDIR=$(dirname ${BASH_SOURCE[0]})
mkdir -p $INSTALLER_INSTALL_DIR

function configure_package_manager() {
  if ! command -v yay >/dev/null 2>&1; then
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git $INSTALLER_INSTALL_DIR/yay
    (cd $INSTALLER_INSTALL_DIR/yay && makepkg -si)
  fi

  local file="/etc/pacman.conf"

  sudo bash -c "echo '
  ' >> $file"

  declare -A replacements
  replacements[Color]="Color"
  replacements[ILoveCandy]="ILoveCandy"
  replacements[ParallelDownloads]="ParallelDownloads = 12"

  for key in "${!replacements[@]}"; do
    value=${replacements[$key]}
    sudo grep -q -E "^(#)?$key" $file && sudo sed -i -E "s/^#?$key.*/$value/" $file || sudo sed -i -e "/^\[options\]/a $value" $file
  done
}


function system_update(){
  yay -Syyu
}


function install_packages() {
	local return_value=$1
  packages=( $(tail -n +2 packages-$2.csv | cut -d ';' -f1) )
  if [[ "$3" == "allow_selection" ]]; then
    multiselect selected_packages packages
  else
    selected_packages=( ${packages[@]} )
  fi
  yay -S --needed ${selected_packages[@]};
  eval $return_value='("${selected_packages[@]}")'
}


function postinstall() {
  for core_install in $INSTALLER_WORKDIR/core/*/Makefile; do
    make -C $(dirname $core_install) install
  done
}


function postinstall_packages(){
  local -n packages=$1
  for package in "${packages[@]}"; do
    folder=$INSTALLER_WORKDIR/postinstall/$package
    if [[ -e $folder/Makefile ]]; then
      make -C $folder install
    fi
  done
}

configure_package_manager
system_update

install_packages core_packages "core" 
install_packages extra_packages "extra" "allow_selection"

postinstall
postinstall_packages core_packages
postinstall_packages extra_packages


