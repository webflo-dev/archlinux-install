#!/usr/bin/env bash

export INSTALLER_INSTALL_DIR=$HOME/_install
export INSTALLER_WORKDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

configure_package_manager() {
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


system_update(){
  sudo pacman -Syyu
}

install_yay() {
  if ! command -v yay >/dev/null 2>&1; then
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/yay.git $INSTALLER_INSTALL_DIR/yay
    (cd $INSTALLER_INSTALL_DIR/yay && makepkg -si)
  fi
}


install_packages() {
	local return_value=$1
  declare -A default_selected=()
  packages=( $(tail -n +2 packages-$2.csv | cut -d ';' -f1) )
  if [[ "$3" == "allow_selection" ]]; then
    multiselect selected_packages packages default_selected
  else
    selected_packages=( ${packages[@]} )
  fi
  yay -S --needed --combinedupgrade --batchinstall --cleanafter --answerdiff None --answerclean None --removemake --noconfirm ${selected_packages[@]};
  eval $return_value='("${selected_packages[@]}")'
}


postinstall() {
  for core_install in $INSTALLER_WORKDIR/core/*/postinstall.sh; do
    # make -C $(dirname $core_install) install
    source $core_install
  done
}


postinstall_packages(){
  local -n packages=$1
  for package in "${packages[@]}"; do
    folder=$INSTALLER_WORKDIR/postinstall/$package
    if [[ -e $folder/postinstall.sh ]]; then
      source $folder/postinstall.sh
    fi

    # if [[ -e $folder/Makefile ]]; then
    #   make -C $folder install
    # fi
  done
}

main(){
  configure_package_manager
  system_update
  install_yay

  install_packages core_packages "core" 
  install_packages extra_packages "extra" "allow_selection"

  postinstall
  postinstall_packages core_packages
  postinstall_packages extra_packages
}

mkdir -p $INSTALLER_INSTALL_DIR
source $INSTALLER_WORKDIR/multiselect.sh
main "$@"

