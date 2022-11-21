#!/usr/bin/env bash

export INSTALLER_INSTALL_DIR=$HOME/_install
export INSTALLER_WORKDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

get_packages(){
  tail -n +2 packages.csv
}

install_script_requirements() {
  sudo pacman -Syyu
  sudo pacman --needed --noconfirm --noprogressbar gum
}

configure_package_manager() {
  local file="/etc/pacman.conf"

  sudo bash -c "echo >> $file"

  declare -A replacements
  replacements[Color]="Color"
  replacements[ILoveCandy]="ILoveCandy"
  replacements[ParallelDownloads]="ParallelDownloads = 12"

  for key in "${!replacements[@]}"; do
    value=${replacements[$key]}
    sudo grep -q -E "^(#)?$key" $file && sudo sed -i -E "s/^#?$key.*/$value/" $file || sudo sed -i -e "/^\[options\]/a $value" $file
  done
}


install_yay() {
  if ! command -v yay >/dev/null 2>&1; then
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/yay.git $INSTALLER_INSTALL_DIR/yay
    (cd $INSTALLER_INSTALL_DIR/yay && makepkg -si)
  fi
  yay -Syyu
}

get_required_packages(){
  get_packages | awk -F',' '$2 == "true" {gsub(";","\n");printf "%s\n%s", $3, $4}'
}

get_optional_packages_list(){
  get_packages | awk -F',' '$2 != "true" {printf "[%s] %s\n", $1, $3}' | column -t
}

get_optional_packages() {
  local source="$@"
  get_packages | awk -v "source=$source" -F',' 'BEGIN {
  split(source, tmp, " ");
  for (i in tmp) packages[tmp[i]] = "";
}
  ($3 in packages) {gsub(";","\n");printf "%s\n%s", $3, $4}
'
}

install_packages() {
  local -n packages=$1
  yay -S --needed --combinedupgrade --batchinstall --cleanafter --answerdiff None --answerclean None --removemake ${packages[@]}
}


postinstall_packages(){
  local -n packages=$1
  for package in "${packages[@]}"; do
    folder=$INSTALLER_WORKDIR/postinstall_packages/$package
    if [[ -e $folder/setup.sh ]]; then
      source $folder/setup.sh
    fi
  done
}


postinstall_scripts(){
  for core_install in $INSTALLER_WORKDIR/postinstall_scripts/*/setup.sh; do
    source $core_install
  done
}

text_box() {
  gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "$1"
}

text_title() {
  gum style --foreground "$1"
  echo ""
}

main(){
  text_box "archlinux install $(gum style --foreground 212 'custom') !"
  text_title "Select additionnal packages to install"

  required_packages=( $(get_required_packages) )
  optional_packages=( $(get_optional_packages_list | gum choose --no-limit --height 30 | awk '{print $2}') )
  packages_to_install=( $(get_optional_packages "${optional_packages[@]}") )

  # install required packages and run postinstall setup
  text_title "installing required packages..."
  install_packages required_packages

  text_title "running required postinstall scripts..."
  postinstall_packages required_packages

  # install selected optional packages and run postinstall setup
  text_title "installing additionnal packages..."
  install_packages packages_to_install

  text_title "running additionnal postinstall scripts..."
  postinstall_packages packages_to_install

  # run postinstall scripts
  text_title "running postinstall scripts..."
  postinstall_scripts

  text_box "custom installation of Archlinux is $(gum style --foreground 212 'done') !"
}

mkdir -p $INSTALLER_INSTALL_DIR
main "$@"

